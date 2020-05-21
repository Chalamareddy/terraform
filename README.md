# CWH Terraform (for disaster recovery)

This script will deploy infrastructure resource in AWS for Disaster Recovery for Bridgestone CWH (Central Web Hosting).


This script will use the most recent AMI with tag "reference" that match with your instance. You can find the tag "reference" into `env_prod_ami.tf`.
Also, this script will use the most recent snapshot with tag "id" that is match with the volume. You can find the tag "is" into `var_prod_compute.tf`.

## SETUP

1. Install terraform on your computer (minimum version : 0.9.3)
2. Ensure you have the latest version of the code from GitLab.
3. Download the current `terraform.tfstate` (and `terraform.tfstate.backup`) file from AWS S3 (bucket : cwh-terraform/oregon) and put it into this directory.
4. Setup your access key, secret key and region into `main_access.tf` file.
5. Run `terraform validate` command to be sure there is no syntax error.

## DEPLOY

1. Ensure you have the latest version of the code from GitLab.
2. Download the current `terraform.tfstate` (and `terraform.tfstate.backup`) file from AWS S3 (bucket : cwh-terraform/oregon) and put it into this directory.
3. Run `terraform validate` command to be sure there is no syntax error.
4. Run `terraform plan` command to see what will be create.
5. Run `terraform apply` to create the environment.
** Update ADS security group IP addresses **
6. Copy the current `terraform.tfstate` (and `terraform.tfstate.backup`) file to AWS S3 (bucket : cwh-terraform/oregon).

## DESTROY

** WARNING ** Terraform destroy command will destroy everything create by terraform (with this script). DO NOT use it if you are not really sure what you are doing !

1. Ensure you have the latest version of the code from GitLab.
2. Download the current `terraform.tfstate` (and `terraform.tfstate.backup`) file from AWS S3 (bucket : cwh-terraform/oregon) and put it into this directory.
3. Run `terraform validate` command to be sure there is no syntax error.
4. Run `terraform destroy` command to destroy the environment.
5. Copy the current `terraform.tfstate` (and `terraform.tfstate.backup`) file to AWS S3 (bucket : cwh-terraform/oregon).
6. Delete the RDS instance manually by going to aws console -> RDS -> Select the db instance and click on delete

# DR Execution

When you run this terraform repository you will also need to execute a few commands to fix the enviornment. Using [CWH-Ansible](https://gitlab.com/cwh-msp/cwh-ansible) is strongly recommended.

**SECURITY NOTICE: Disconnect from any us-east VPN when you are in us-west to prevent any mistakes!**

## 1. Fix hostname issue for Java processes and reboot EC2 instances
> Ensure that all services are able to start properly after instances have been initialized

1. Set a proper hostname because there is no reverse DNS in place: `ansible -m shell -a 'echo "127.0.0.1 $(hostname)" >> /etc/hosts' aem,aem-author-cold,tomcat -i inventory/prod --become`
2. From AWS Console, select all Oregon EC2 instances
3. Perform reboot on instances
4. Wait for instances to come back up

## 2. Test connectivity
1. Connect to the DR VPN instance (Elastic IP: 52.88.232.245 and port udp/1194)
2. Test connection: `ansible -m ping all -i inventory/prod`
3. Test login: `ansible -m shell -a "whoami" all -i inventory/prod`

If everything runs properly, then you are good to go. If not, then you will need to configure your ansible to log into the instances using SSH keys.

## 3. Enable SSH Password Auth
> Password authentication will only work if you have restored the user profiles in the LDAP

1. Fix SSH config to allow password login: `ansible -m shell -a "sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config" all --become -i inventory/prod`
2. Reload the SSH daemon with the updated config: `ansible -m service -a "name=sshd state=reloaded" all --become -i inventory/prod`

## 4. Disable Collectd
> Collectd service will generate duplicate information in CloudWatch when the DR environment is up at the same time as the regular production. Therefore, we need to disable the service.

1. Disable collectd service: `ansible -m service -a "name=collectd state=stopped enabled=no" all --become -i inventory/prod`

## 5. Restore mysql cluster
> It is highly unlikely that mysql cluster will be able to start in a proper state. We will have to perform a full DB restore to get back to a desired state.
> **Change the date to your current date (YYYYMMDDHH)**

1. On both x-mysql-2 and x-mysql-4, clean the ndb file system: `sudo systemctl stop ndbd && sudo ndbd --initial && cd /mnt/apps/mysql/data/BACKUP/BACKUP-2018050203`
2. Restore the DBs on x-mysql-2: `ndb_restore -m -r -c "10.10.0.20" -b 2017090806 -n 3`
3. Restore the DBs on x-mysql-4: `ndb_restore -r -c "10.10.0.20" -b 2017090806 -n 4`  
    **If stored procedures are missing - run this on x-mysql-1:** `mysql -v -u mysql_backup -p <  /mnt/apps/mysql/data/BACKUP/storedProcedure-20170908_06.sql`
4. On both x-mysql-2 and x-mysql-4, stop the ndbd that was started in *initial* mode: `pkill ndbd`
5. Restart the cluster (x-mysql-1/2/3/4)
  * `sudo service memcached stop` (x-mysql-1/3)
  * `sudo service mysqld stop` (x-mysql-1/3)
  * `sudo service ndbd stop` (x-mysql-2/4)
  * `sudo service ndb_mgmd stop` (x-mysql-1/3)
  * `sudo service ndb_mgmd start` (x-mysql-1/3)
  * `sudo service ndbd start` (x-mysql-2/4)
  * `sudo service mysqld start` (x-mysql-1/3)
  * `sudo service memcached start` (x-mysql-1/3)
6. Test MySQL connectivity using any MySQL client

## 6. Fix potential issue for Solr and restart Tomcat JVM
> Solr will sometimes fail to elect a leader if all instances are started at the same time. So we need to restart the cluster to get Solr working.
> Tomcat will also need to be restarted to ensure all applications are able to talk to the MySQL Cluster.

1. Stop any running Solr services: `ansible -m shell -a "service solr stop" tomcat --become -i inventory/prod`
2. Start Solr: `ansible -m shell -a "service solr start" tomcat --become -i inventory/prod`
3. Verify that Solr is working: `ansible -m shell -a "service solr status" tomcat --become -i inventory/prod`. The number of 'liveNodes' should be 3.
4. Restart Tomcat by logging into SSH on all the tomcat instances and performing a `sudo service tomcat restart`
5. Once Tomcat is up, verify that all the apps are in the *running* state

## 7. Purge cache
> Ensure that we are not service stale cache from Oregon

1. `ansible-playbook playbooks/clear-cache-bsro.yml -i inventory/prod`
2. `ansible-playbook playbooks/clear-cache-commercial.yml -i inventory/prod`
3. `ansible-playbook playbooks/clear-cache-consumer.yml -i inventory/prod`

## 8. Smoke tests

1. Using the AWS CLI, you can get the list of ELB names and CNAMES: `aws elb describe-load-balancers --query 'LoadBalancerDescriptions[*].{Name:LoadBalancerName,CNAME:DNSName}' --region us-west-2`
2. Resolve the CNAME in the list to IP addresses
3. Match domain names to the IP addresses sing the your *host* file
4. Check the websites in your web browser using private browsing and developer view
5. Once you've checked the sites, you can contact the agencies and the BU for additional tests

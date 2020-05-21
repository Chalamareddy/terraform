/*
Environment : INT, QA, UAT, PROD
AWS Services : RDS

Code to deploy RDS MSSQL DB instances in all env. for identity.thetread.com
*/


# Option group identical for all identity db instances
resource "aws_db_option_group" "cwh_db_optgrp_msssqlw_identity" {
  name                     = "cwh-option-group-msssqlw-identity"
  option_group_description = "Terraform - Option Group for X-MSSQLW-X db instances"
  engine_name              = "sqlserver-web"
  major_engine_version     = "14.00" /*SQL Server 2017*/

    option {
      option_name = "SQLSERVER_BACKUP_RESTORE"
      option_settings {
        name = "IAM_ROLE_ARN"
        value = "arn:aws:iam::116307434611:role/service-role/cwh-rds-identity-serverbackuprestore"
      }
    }
}

# Parameters group identical for all identity db instances
resource "aws_db_parameter_group" "cwh_db_paramgrp_mssqlweb_identity" {
  name   = "cwh-rds-pg-mssqlw-identity"
  family = "sqlserver-web-14.0"
}

resource "aws_db_instance" "prod-db-mssqlw-1" {
  allocated_storage           = "${var.prod_mssql_1_storage_alloc}"
  auto_minor_version_upgrade  = "${var.prod_mssql_1_auto_minor_upgrade}"
  availability_zone           = "${element(var.azs_prod, 0)}"
  backup_retention_period     = "${var.prod_mssql_1_backup_retention}"
  backup_window               = "${var.prod_mssql_1_backup_window}"
  db_subnet_group_name        = "${aws_db_subnet_group.cwhprod-db-subnet-1.id}"
  engine                      = "${var.prod_mssql_1_engine}"
  identifier                  = "${var.prod_mssql_1_name}"
  instance_class              = "${var.prod_mssql_1_instance}"
  storage_encrypted           = "${var.prod_mssql_1_storage_encryption}" #encrypting data would render DR impossible in the current scheme
  parameter_group_name        = "${aws_db_parameter_group.cwh_db_paramgrp_mssqlweb_identity.id}"
  option_group_name           = "${aws_db_option_group.cwh_db_optgrp_msssqlw_identity.id}"
  username                    = "${var.prod_mssql_1_sa_username}"
  password                    = "${var.prod_mssql_1_sa_password}"
  storage_type                = "${var.prod_mssql_1_storage_type}"
  timezone                    = "${var.prod_mssql_1_timezone}"
  vpc_security_group_ids      = ["${aws_security_group.sg_mssqlw_prod.id}"]
}
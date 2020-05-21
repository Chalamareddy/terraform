data "aws_ami" "prod-varnish1" {
  owners          = ["self"]
  most_recent     = true
  filter { name   = "tag:reference" values = ["prod-varnish-1"]}
}
data "aws_ami" "prod-varnish2" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-varnish-2"]}
}
data "aws_ami" "prod-varnish3" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-varnish-3"]}
}
data "aws_ami" "prod-varnish4" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-varnish-4"]}
}
data "aws_ami" "prod-varnish-th" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-varnish-th-1"]}
}
data "aws_ami" "prod-apache1" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-apache-1"]}
}
data "aws_ami" "prod-apache2" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-apache-2"]}
}
data "aws_ami" "prod-apache3" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-apache-3"]}
}
data "aws_ami" "prod-apache4" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-apache-4"]}
}
data "aws_ami" "prod-apache-author-1" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-apache-author-1"]}
}
data "aws_ami" "prod-apache-author-2" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-apache-author-2"]}
}
# data "aws_ami" "prod-mssql1" {
# owners          = ["self"]
#   most_recent      = true
#   filter { name   = "tag:reference" values = ["prod-mssql-1"]}
# }
# data "aws_ami" "prod-mssql2" {
# owners          = ["self"]
#   most_recent      = true
#   filter { name   = "tag:reference" values = ["prod-mssql-2"]}
# }
data "aws_ami" "prod-author" {
  owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-author-1"]}
}
data "aws_ami" "prod-author-cold" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-author-standby-2"]}
}
data "aws_ami" "prod-publish1" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-publish-1"]}
}
data "aws_ami" "prod-publish2" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-publish-2"]}
}
data "aws_ami" "prod-publish3" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-publish-2"]}
}
data "aws_ami" "prod-publish4" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-publish-4"]}
}
data "aws_ami" "prod-tomcat1" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-solr-tomcat-1"]}
}
data "aws_ami" "prod-tomcat2" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-solr-tomcat-2"]}
}
data "aws_ami" "prod-tomcat3" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-solr-tomcat-3"]}
}
data "aws_ami" "prod-mysql1" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-mysql-1"]}
}
data "aws_ami" "prod-mysql2" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-mysql-2"]}
}
data "aws_ami" "prod-mysql3" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-mysql-3"]}
}
data "aws_ami" "prod-mysql4" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-mysql-4"]}
}
data "aws_ami" "prod-ldap" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-ldap"]}
}
#data "aws_ami" "prod-usermanager1" {
#owners          = ["self"]
#  most_recent      = true
#  filter { name   = "tag:reference" values = ["prod-usermanager-1"]}
#}
#data "aws_ami" "prod-usermanager2" {
#owners          = ["self"]
#  most_recent      = true
#  filter { name   = "tag:reference" values = ["prod-usermanager-2"]}
#}
data "aws_ami" "prod-vpnnat" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-vpnnat"]}
}
/*data "aws_ami" "prod-vpnipsec" {
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-vpn-ipsec"]}
}*/

data "aws_ami" "prod-iis1" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-iis-1"]}
}
data "aws_ami" "prod-iis2" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-iis-2"]}
}
data "aws_ami" "prod-iis3" {
owners          = ["self"]
  most_recent      = true
  filter { name   = "tag:reference" values = ["prod-iis-3"]}
}

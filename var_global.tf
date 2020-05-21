# Name
variable "name" { default = "cwh"}
variable "name_prod" { default = "cwh-prod"}

# Key
variable "namekey" { default = "cwh-bridgestone-key"}

# Simple AD
variable "addomain" { default = "cwh.local"}
variable "adpass" { default = "cwhrzrfsh2015!"}

# CIDR
variable "cidr_prod" { default = "10.10.0.0/16"}

# AZs
variable "azs_prod" { default = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2a"]}

# Private DNS
variable "enable_dns_hostnames" { default = true}
variable "enable_dns_support" { default = true}

# Public IP
variable "natgw_prod_a_eip" { default = "eipalloc-31042c0b"} # 35.162.251.251
variable "natgw_prod_b_eip" { default = "eipalloc-0a052d30"} # 34.211.97.111
variable "natgw_prod_c_eip" { default = "eipalloc-a9052d93"} # 52.26.147.144
#variable "prod-usermanager1-eip" { default = "eipalloc-14e1c92e"} # 34.212.59.14
#variable "prod-usermanager2-eip" { default = "eipalloc-f8edc5c2"} # 34.208.185.25
variable "prod-vpnnat1-eip" { default = "eipalloc-39e3cb03"} # 52.88.232.245
variable "prod-vpn-ipsec-eip" { default = "eipalloc-4ae0c870"} # 34.208.225.139

# Log rotate
variable "logrotate-s3-service" { default = "com.amazonaws.us-west-2.s3"}

# NAT gateway
variable "enable_nat_gateway" {
  description = "should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

# Map Public IP
variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = false
}

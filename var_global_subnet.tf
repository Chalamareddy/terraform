# PROD Private subnets
variable "private_subnets_prod" { default = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]}
variable "private_subnets_prod_tags" { default = ["prod-private-1a", "prod-private-1c", "prod-private-1d", "prod-private-1e"]}
# PROD Public subnets
variable "public_subnets_prod" { default = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]}
variable "public_subnets_prod_tags" { default = ["prod-public-1a", "prod-public-1c", "prod-public-1d", "prod-public-1e"]}
# PROD Lambda subnets
variable "lambda_subnets_prod" { default = ["10.10.14.0/24", "10.10.15.0/24", "10.10.16.0/24", "10.10.17.0/24"]}
variable "lambda_subnets_prod_tags" { default = ["prod-lambda-1a", "prod-lambda-1c", "prod-lambda-1d", "prod-lambda-1e"]}
# PROD ELB subnets
variable "elb_subnets_prod" { default = ["10.10.20.0/24", "10.10.21.0/24", "10.10.22.0/24", "10.10.23.0/24"]}
variable "elb_subnets_prod_tags" { default = ["prod-elb-1a", "prod-elb-1c", "prod-elb-1d", "prod-elb-1e"]}

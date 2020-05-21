# Configure the AWS account and region
provider "aws" {
        access_key = ""
        secret_key = ""
        region= "us-west-2"
}

# Set Terraform version constraint
terraform { required_version = ">= 0.9.3"}

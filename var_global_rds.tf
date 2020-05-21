# Options for PROD-DB-MSSQLW-1 RDS
variable "prod_mssql_1_name" { default = "prod-db-mssqlw-1"}
variable "prod_mssql_1_instance" { default = "db.t2.medium"}
variable "prod_mssql_1_engine" { default = "sqlserver-web"}
variable "prod_mssql_1_storage_alloc" { default = "20"}
variable "prod_mssql_1_storage_type" { default = "gp2"}
variable "prod_mssql_1_storage_encryption" { default = "false"}
variable "prod_mssql_1_backup_retention" { default = "35"}
variable "prod_mssql_1_backup_window" { default = "03:00-04:00"}
variable "prod_mssql_1_auto_minor_upgrade" { default = "false"}
variable "prod_mssql_1_timezone" { default = "Eastern Standard Time"}
variable "prod_mssql_1_sa_username" { default = "masteruser"}
variable "prod_mssql_1_sa_password" { default = "testuser1"}

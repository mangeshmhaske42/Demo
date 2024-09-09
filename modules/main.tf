
provider "aws" {
  region = var.region
}

module "secret_manager" {
    source      = "./modules/secret_manager"
    db_password = var.db_password
}

module "rds_database" {
    source      = "./modules/rds"
    db_username = var.db_username 
}
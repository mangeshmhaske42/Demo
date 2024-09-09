data "aws_secretsmanager_secret" "db_password" {
	name	= "prod/postgres/password"
}

data "aws_secretsmanager_secret_version" "db_password_version" {
	secret_id		= data.aws_secretsmanager_secret.db_password.id
}

resource "aws_db_instance" "example" {
  identifier              = "rds-identifier-name"
  instance_class          = "db.t3.micro" 
  engine                  = "postgres"   
  engine_version  		  = "13.4"
  allocated_storage       = 20            
  storage_type            = "gp2"          
  username                = var.db_username
  password                = data.aws_secretsmanager_secret_version.db_password_version.secret_string
  db_name                 = "postgres-db-instance"
  multi_az                = false
  #backup_retention_period = 1
  #backup_window			   = "21:30-22:30"	
  publicly_accessible     = false
#   vpc_security_group_ids  = [aws_security_group.db_sg.id]
#   db_subnet_group_name    = aws_db_subnet_group.db_sub_grp.name
  storage_encrypted       = true
#   db_parameter_group_name = aws_db_parameter_group.postgres_parameter_group.name
#   option_group_name       = aws_db_option_group.postgres_option_group.name
  license_model           = "postgresql-license"

  tags = {
    Name = "postgres-db-instance"
  }
}
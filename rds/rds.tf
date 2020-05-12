// database subnet_group
resource "aws_db_subnet_group" "subnet_mysql" {
    name        = "subnet_mysql"
    description = "RDS subnet group"
    subnet_ids = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}
// database parameter
resource "aws_db_parameter_group" "mysql_parameter" {
  name   = "parameters-mysql" // 命名禁止用 "_" ，可用 "-"替代
  family = "mysql5.7"
  description = "MySQL parameter group"
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_instance" "mysqldb" {
  allocated_storage    = 20 // 20 GB of storage
   storage_type         = "gp2"
   engine               = "mysql"
   engine_version       = "5.7"
   identifier    = "mysql"
   instance_class       = "db.t2.micro"
   name                 = "terraform_mysqldb"
   username             = "tom"
   password             = var.RDS_PASSWORD
   vpc_security_group_ids  = [aws_security_group.http_server_sg.id]
   db_subnet_group_name    = aws_db_subnet_group.subnet_mysql.name
   parameter_group_name = aws_db_parameter_group.mysql_parameter.name
   backup_retention_period = 30 # how long you’re going to keep your backups
   multi_az                = "false" # set to true to have high availability
   availability_zone       = aws_subnet.main-private-1.availability_zone # prefered AZ
   skip_final_snapshot     = true # skip final snapshot when doing terraform destroy
   tags = {
    Name = "mysql_instance"
  }
}

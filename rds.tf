#subnet group for the RDS
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.private[0].id,aws_subnet.private[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}

#RDS instance
resource "aws_db_instance" "default" {
  identifier           = "cgpdb"
  allocated_storage    = 10
  engine               = "postgres"
 # engine_version       = "5.7"
  instance_class       = "db.t3.large"
  name                 = "mydb"
  username             = "cgpdbuser"
  password             = "postgresdb123"
  availability_zone    = "us-west-2a"
 # parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.id
}

#security group for the RDS

resource "aws_security_group" "rds_sg" {
  name        = "cgpdb-rds-sg"
  description = "cgpdb-rds-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
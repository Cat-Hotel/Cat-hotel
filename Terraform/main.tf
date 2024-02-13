terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# configured aws provider with proper credentials
provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key #get from the IAM
  secret_key = var.secret_key #get from the IAM
}


# create default vpc if one does not exit
resource "aws_default_vpc" "catHotel_vpc" {

  tags = {
    Name = "catHotel vpc"
  }
}


data "aws_availability_zones" "available_zones" {}

resource "aws_default_subnet" "subnet_catHotel_a" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
}

resource "aws_default_subnet" "subnet_catHotel_b" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}

# create security group for the database
resource "aws_security_group" "catHotel_security_group" {
  name        = "database security group"
  description = "enable sqlServer access on port 1433"
  vpc_id      = aws_default_vpc.catHotel_vpc.id

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "catHotel_security_group"
  }
}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "catHotel_subnet_group" {
  name       = "cathotelsubnetgroup"
  subnet_ids = [aws_default_subnet.subnet_catHotel_a.id, aws_default_subnet.subnet_catHotel_b.id]

  tags = {
    Name = "catHotel_subnet_group"
  }
}


# create the rds instance
resource "aws_db_instance" "catHotel_db_instance" {
  engine                 = "sqlserver-ex"
  multi_az               = false
  identifier             = "cat-hotel-db"
  username               = var.db_username #use this to connect to db with sql server 
  password               = var.db_password #use this to connect to db with sql server 
  instance_class         = "db.t3.small"
  allocated_storage      = 20
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.catHotel_subnet_group.name
  vpc_security_group_ids = [aws_security_group.catHotel_security_group.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  skip_final_snapshot    = true
}



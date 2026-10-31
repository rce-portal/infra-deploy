terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  count         = var.web_count
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  tags = {
    Name = "web-prod"
    Role = "web-prod"
  }
}

resource "aws_instance" "db" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
  tags = {
    Name = "db-prod"
    Role = "db-prod"
  }
}

resource "aws_s3_bucket" "backups" {
  bucket = "rce-portal-backups"

  tags = {
    Name = "rce-portal-backups"
    Env  = "prod"
  }
}

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id
  versioning_configuration {
    status = "Enabled"
  }
}

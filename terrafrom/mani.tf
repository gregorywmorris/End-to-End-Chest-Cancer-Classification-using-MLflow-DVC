provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-tf-test-bucket"
}

variable "instance_tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {
    Name = "mlflow"
  }
}

variable "bucket_tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = var.instance_tags
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = var.bucket_tags
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.example.arn
}





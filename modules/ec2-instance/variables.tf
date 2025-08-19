variable "region" {
  description = "value for the AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string

}

variable "env" {
  description = "Environment for the EC2 instance"
  type        = string
  default     = "dev"

}
# variable "ami_id" {
#   description = "AMI ID for the EC2 instance"
#   type        = string
#   default     = "ami-020cba7c55df1f615" # Linux Ubuntu 24.04 Canonical

# }

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"

}

variable "repo" {
  description = "Repository URL for the EC2 instance"
  type        = string
  default     = "https://github.com/nadineGomes/IaC"

}
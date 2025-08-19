variable "bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"

}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string

}

variable "private_key_path" {
  description = "Path to the private key for SSH access to the EC2 instance"
  type        = string
}
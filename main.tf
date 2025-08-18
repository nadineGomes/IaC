provider "aws" {
  region = "us-east-1"

}

# Chama o módulo do S3 para criar o bucket
module "s3_website_bucket" {
  source      = "./modules/s3-website"
  bucket_name = var.bucket_name
}

# Chama o módulo do EC2 para criar a instância
module "ec2_instance" {
  source        = "./modules/ec2-instance"
  instance_type = var.instance_type
  name          = var.instance_name
}


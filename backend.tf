terraform {
  backend "s3" {
    bucket         = "tf-backend-iac"
    key            = "projeto-iaC/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true

  }
}
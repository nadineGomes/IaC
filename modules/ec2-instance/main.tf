resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name        = var.name
    Environment = var.env
    provisioner = "web_server_terraform"
    Repo        = var.repo
  }
}
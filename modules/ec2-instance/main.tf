data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  key_name = "minha-chave-aws"

  tags = {
    Name        = var.instance_name
    Environment = var.env
    provisioner = "web_server_terraform"
    Repo        = var.repo

  }
}
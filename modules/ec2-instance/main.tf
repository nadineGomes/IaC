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
  key_name      = "minha-chave-aws"

connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file(var.private_key_path)
  host        = self.public_ip
}

provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx",
    "echo '<h1>Welcome to ${var.instance_name} in ${var.env} environment! The Nginx is alive!!!</h1>' | sudo tee /var/www/html/index.html"
  ]
}

  tags = {
    Name        = var.instance_name
    Environment = var.env
    provisioner = "web_server_terraform"
    Repo        = var.repo
    
    

  }
  
}





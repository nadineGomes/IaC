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
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              
              # Atualiza os pacotes e instala o Docker
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              
              # Adiciona o usuário 'ubuntu' ao grupo docker para não precisar de sudo
              sudo usermod -aG docker ubuntu
              
              # Inicia o serviço do Docker
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # Roda o container oficial do Nginx
              # -d: roda em background
              # -p 80:80: mapeia a porta 80 da instância para a porta 80 do container
              # --name nginx_container: dá um nome ao container
              # --restart always: garante que o container reinicie com a instância
              docker run -d -p 80:80 --name nginx_container --restart always nginx:latest
              EOF


  tags = {
    Name        = var.instance_name
    Environment = var.env
    provisioner = "web_server_terraform"
    Repo        = var.repo
        
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Security group for web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


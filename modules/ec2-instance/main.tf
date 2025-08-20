data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

}

resource "aws_iam_role" "ssm_role" {
  name = "ec2_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ec2_ssm_instance_profile"
  role = aws_iam_role.ssm_role.name
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

    # Permite o tráfego SSH de entrada (porta 22) - RECOMENDADO APENAS PARA SEU IP!
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [" 0.0.0.0/0"] # Substitua por seu IP específico para maior segurança
  }

  # Permite todo o tráfego de saída (essencial para o SSM e para baixar o Docker)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  key_name               = "minha-chave-aws"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name

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



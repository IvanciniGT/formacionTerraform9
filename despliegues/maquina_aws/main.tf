
module "mis_claves" {
    source              = "../modulo_claves_ssh"
    algoritmo           = {
                            nombre  = "RSA" # "rsa"
                            configuracion = "2048" # "p256"
                          }
}

resource "aws_key_pair" "mis_claves" {
    key_name   = "las_claves_de_${var.despliegue}"
    public_key = module.mis_claves.claves.publica.openssh
}


resource "aws_instance" "mi_maquina" {
    ami             = data.aws_ami.mi_imagen.image_id
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.mis_claves.key_name
    security_groups = [
                        aws_security_group.permitir_ssh.name
                      ]
    tags = {
        Name        = "LaMaquina-${var.despliegue}"
    }
    
    
    connection {
        host    = self.public_ip
        type    = "ssh" # "winrm"
        port    = 22
        user    = "ubuntu"
        private_key = module.mis_claves.claves.privada.pem
    }
    provisioner "remote-exec" {
        inline  = [
                        "echo Eureka"
                  ]
    }
    
}

data "aws_ami" "mi_imagen" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "permitir_ssh" {
  name        = "regla_permitir_ssh_${var.despliegue}"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "regla_permitir_ssh_${var.despliegue}"
  }
}

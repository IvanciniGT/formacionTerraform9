
resource "aws_instance" "mi_maquina" {
    ami             = data.aws_ami.mi_imagen.image_id
    instance_type   = "t2.micro"
    
    tags = {
        Name        = "LaMaquina-${var.despliegue}"
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


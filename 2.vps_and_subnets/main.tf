provider "aws" {
  shared_config_files = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

resource "aws_vpc" "aiden_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.aiden_vpc.id
}

resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.aiden_vpc.id
}

resource "aws_internet_gateway" "aiden_public_internet_gateway" {
  vpc_id =  aws_vpc.aiden_vpc.id
}

resource "aws_route_table" "aiden_public_subnet_route_table" {
  vpc_id =  aws_vpc.aiden_vpc.id

    route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.aiden_public_internet_gateway.id
    }

    route  {
            ipv6_cidr_block = "::/0"
            gateway_id = aws_internet_gateway.aiden_public_internet_gateway.id
    }
}

resource "aws_route_table_association" "aiden_public_association" {
  route_table_id = aws_route_table.aiden_public_subnet_route_table.id
  subnet_id = aws_subnet.public_subnet.id
}

//secuity group setup

resource "aws_security_group" "web_server_sg" {
  vpc_id = aws_vpc.fis_vpc.id

  ingress {
    description = "Allow HTTP trafic from internet"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]       
  }

  ingress {
    description = "Allow HTTPS trafic from internet"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all trafic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } 

  tags = {
    Name = "aeis security group"
  }          
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ununtu_aws_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  tags = {
    Name = "aws-course"
  }
}
resource "aws_network_interface" "aiden_network_interface" {
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.web_server_sg.id]
  private_ips = ["10.0.1.50"]
}
resource "aws_eip" "aiden_eip" {
  vpc = true
  network_interface = aws_network_interface.aiden_network_interface.id
  associate_with_private_ip = "10.0.1.50"
}
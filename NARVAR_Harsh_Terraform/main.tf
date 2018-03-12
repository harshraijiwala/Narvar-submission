provider "aws" {
  region="${var.aws_region}"
  profile="${var.aws_profile}"
}

#Creating AWS VPC for secure Private Infrastructure
resource "aws_vpc" "narvar_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  
  enable_dns_hostnames = true
  enable_dns_support   = true  

  tags {
    Name = "narvar_vpc"
  }
}

#Creating Internet gateway to allow connection to Public Network through Route Table

resource "aws_internet_gateway" "narvar_internet_gateway" {
  vpc_id = "${aws_vpc.narvar_vpc.id}"

  tags {
    Name = "narvar_igw"
  }
}

# Creating Route tables for Traffic Flow  

resource "aws_route_table" "narvar_public_rt" {
  vpc_id = "${aws_vpc.narvar_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.narvar_internet_gateway.id}"
  }

  tags {
    Name = "narvar_public"
  }
}

resource "aws_subnet" "narvar_public1_subnet" {
  vpc_id                  = "${aws_vpc.narvar_vpc.id}"
  cidr_block              = "${var.cidrs["public1"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "narvar_public1"
  }
}

resource "aws_subnet" "narvar_public2_subnet" {
  vpc_id                  = "${aws_vpc.narvar_vpc.id}"
  cidr_block              = "${var.cidrs["public2"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "narvar_public2"
  }
}


# Subnet Associations with Public Route Table

resource "aws_route_table_association" "narvar_public1_assoc" {
  subnet_id      = "${aws_subnet.narvar_public1_subnet.id}"
  route_table_id = "${aws_route_table.narvar_public_rt.id}"
}

resource "aws_route_table_association" "narvar_public2_assoc" {
  subnet_id      = "${aws_subnet.narvar_public2_subnet.id}"
  route_table_id = "${aws_route_table.narvar_public_rt.id}"
}


# Security Group Rules for Inbound_Outbound traffic 

resource "aws_security_group" "narvar_public_sg" {
  name        = "narvar_public_sg"
  description = "Used for public subnets"
  vpc_id      = "${aws_vpc.narvar_vpc.id}"

  #SG rule to allow incoming HTTP traffic 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #SG rule to allow incoming SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #SG rule to allow incoming HTTPS traffic

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #SG rule for Outbound traffic

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Associating Public key with the .pem file in EC2 instance

resource "aws_key_pair" "narvar_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

#Instantiating EC2 Server in public1 subnet in AZ us-east-2a

resource "aws_instance" "narvar_ec2_public1" {
  instance_type = "${var.ec2_instance_type}"
  ami           = "${var.ec2_ami}"

  tags {
    Name = "narvar_ec2_public1"
  }

  key_name               = "${aws_key_pair.narvar_auth.id}"
  vpc_security_group_ids = ["${aws_security_group.narvar_public_sg.id}"]
  subnet_id              = "${aws_subnet.narvar_public1_subnet.id}"
  associate_public_ip_address = true
}


#Instantiating EC2 Server in public2 subnet in AZ us-east-2b

resource "aws_instance" "narvar_ec2_public2" {
  instance_type = "${var.ec2_instance_type}"
  ami           = "${var.ec2_ami}"

  tags {
    Name = "narvar_ec2_public2"
  }

  key_name               = "${aws_key_pair.narvar_auth.id}"
  vpc_security_group_ids = ["${aws_security_group.narvar_public_sg.id}"]
  subnet_id              = "${aws_subnet.narvar_public2_subnet.id}"
  associate_public_ip_address = true
}




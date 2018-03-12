#-------------------------------------------------------------------------------
#***** Defineing all the variables which will be  used in the main.tf**********
#********Variable names are self explanatory as per conventions used in AWS****
#------------------------------------------------------------------------------ 

variable "aws_region" {}
variable "aws_profile" {}
data "aws_availability_zones" "available"{}
variable "vpc_cidr" {}

variable "cidrs" {
  type = "map"
}

variable "key_name" {}
variable "public_key_path" {}

variable "ec2_instance_type" {}
variable "ec2_ami" {}

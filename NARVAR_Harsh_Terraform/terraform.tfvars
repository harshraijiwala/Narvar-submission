#----------------------------------------------------------------------------------------------------
#This file allows to set all the dynamic parameters to the Variables defined in variable.tf file
#---------------------------------------------------------------------------------------------------

#Decalared values for profiling in AWS CLI
aws_profile = "harsh_narvar"
aws_region= "us-east-2"
vpc_cidr= "10.0.0.0/16"

#Declaring two subnets
cidrs={
  public1  = "10.0.1.0/24"
  public2  = "10.0.2.0/24"
}

#Declaring values required for instantiating the EC2 Instance
key_name		= "harsh_narvar"
public_key_path		= "/root/.ssh/harsh_narvar.pub"
ec2_instance_type	= "t2.micro"
ec2_ami			= "ami-0b1e356e"

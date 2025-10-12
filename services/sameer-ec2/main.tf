module "call_vpc" {
  source = "./VPC"
}

module "call_ec2" {
  source = "./EC2"
  ami = "ami-066784287e358dad1"
  type = "t3.large"
  subnet_id = module.call_vpc.vpc_output_subnet_id
  security_groups = module.call_vpc.vpc_output_sg_id
}


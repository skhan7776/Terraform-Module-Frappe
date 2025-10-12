
module "call_ec2" {
  source = "../../modules/EC2/"
  ami = "ami-066784287e358dad1"
  type = "t3.large"
  subnet_id = ["subnet-045da4727adf53336"]
  security_groups = ["sg-07a90917007e6cece"]
  key_pair_name = "tf-key-ticketing-system"
}


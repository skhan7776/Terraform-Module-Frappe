module "call_ec2" {
  source = "../../modules/EC2"
  ami = "ami-066784287e358dad1"
  type = "t3.large"
  subnet_id = ["subnet-06f822e89448eb832"]
  security_groups = ["sg-01957e991f91df7ea"]
  key_pair_name = "tf-helpdesk-key"
  machine_name = "os-ticketing"
}


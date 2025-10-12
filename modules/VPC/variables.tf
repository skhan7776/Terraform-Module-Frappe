
// VPC Creation
variable "myvpc" {
  type = string
  default = "10.0.0.0/16"
}

//public routing table
variable "public_route" {
  default = "0.0.0.0/0" 
}

//ipv6 routing table
variable "private_route" {
  default = "10.0.0.0/0"
}

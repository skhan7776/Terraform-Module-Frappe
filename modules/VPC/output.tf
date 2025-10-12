//output "vpcs" {
  //description = "VPC Outputs"
  //value       = { for vpc in aws_vpc.this : vpc.tags.Name => { "cidr_block" : vpc.cidr_block, "id" : vpc.id } }
//}

output "output_vpc_id" {
  value = aws_vpc.myvpc.id
}

output "vpc_output_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}

output "vpc_output_sg_id" {
  value = [aws_security_group.web_sg.id]
}
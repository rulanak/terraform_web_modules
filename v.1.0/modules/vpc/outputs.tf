output "vpc_id" {
  value       = aws_vpc.main.id
  description = "vpc id"
}
output "pub_subnet_ids" {
  value       = aws_subnet.pub_sub.*.id
  description = "ids of public subnets"
}
output "priv_subnet_ids" {
  value       = aws_subnet.priv_sub.*.id
  description = "ids of private subnets"
}

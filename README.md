# terraform_web_modules
![0*hzcn58R-qukKR_eg](https://user-images.githubusercontent.com/107318829/198931328-6ad3e2cd-5dc6-49dd-8367-3503a3ed5548.png)

With this repository we are able to create:

- Custom VPC
- Auto Scaling Group
- Application Load Balancer

with ` Child Modules`

The resources defined in a module are encapsulated, so the calling module cannot access their attributes directly.However, the child module can declare output values to selectively export certain values to be accessed by the calling module. For it we need:
- Outputs from VPC
```
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
```
- Outputs from ASG
```
output "name" {
  value = aws_autoscaling_group.main.name
}
```
- Create variables for argument that need expressions from another module, instead of hardcoding them
- Reference:
```
module "alb" {
  vpc_id        = module.vpc.vpc_id
  subnets       = module.vpc.pub_subnet_ids
  asg_name      = module.asg.name
}
```

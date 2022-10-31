variable "env" {
  type        = string
  description = "This is var for Environment"
  default     = "dev"
}
variable "region" {
  type    = string
  description = "Region for application. Write it shortly"
  default = "ue1"
}
variable "project" {
  type    = string
  description = "What project is resource for"
  default = "cat"
}
variable "managed_by" {
  type = string
  description = "By what resource managed"
  default = "Terraform"
}
variable "app_port" {
  type    = number
  default = 80
}
variable "ingress_ports" {
  type        = list(string)
  description = "list for ingress ports for sg"
  default     = ["443", "80"]
}
variable "ingress_cidrs" {
  type        = list(string)
  description = "cidrs for ingress ports"
  default     = ["0.0.0.0/0", "0.0.0.0/0"]
}
variable "asg_name" {
  type = string
  description = "Name of Auto Scaling Group. Call module.asg.name"
}
variable "subnets" {
  type = list(string)
  description = "Public subnets of custom VPC. Call module.vpc.pub_subnet_ids"
}
variable "vpc_id" {
  type = string
  description = "ID of custom VPC. Call module.vpc.vpc_id"
}
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
variable "instance_type" {
  type        = string
  description = "the size of EC2 instance"
  default     = "t2.micro"
}
variable "max_size" {
  type        = number
  description = "max size of instances"
  default     = 5
}
variable "min_size" {
  type        = number
  description = "min size of instances"
  default     = 2
}
variable "desired_capacity" {
  type        = number
  description = "desired capacity of instances"
  default     = 2
}
variable "force_delete" {
  type        = bool
  description = "if its true, it will delete ec2 if u delete asg. false - will no"
  default     = true

}
variable "ingress_ports" {
  type        = list(string)
  description = "list for ingress ports for sg"
  default     = ["22", "80"]
}
variable "ingress_cidrs" {
  type        = list(string)
  description = "cidrs for ingress ports"
  default     = ["44.212.71.220/32", "0.0.0.0/0"]
}
variable "vpc_id" {
  type = string
  description = "ID of custom VPC for SG. Call module.vpc.vpc_id"
}
variable "vpc_zone_identifier" {
  type = list(string)
  description = "Private subnets of custom VPC for ASG. Call module.vpc.priv_subnet_ids"
}
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
variable "vpc_cidr" {
  type        = string
  description = "cidr for vpc"
  default     = "10.0.0.0/16"
}
variable "cidr_pubs" {
  type        = list(string)
  description = "cidr for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "cidr_privs" {
  type        = list(string)
  description = "cidr for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}
variable "azs" {
  type    = list(string)
  description = "specify what AZ you want to use"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
module "vpc" {
  source     = "../modules/vpc"
  env        = "qa"
  region     = "ue1"
  project    = "dog"
  managed_by = "Terraform"
  vpc_cidr   = "11.0.0.0/16"
  cidr_pubs  = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
  cidr_privs = ["11.0.11.0/24", "11.0.12.0/24", "11.0.13.0/24"]
  azs        = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
module "asg" {
  source              = "../modules/asg"
  vpc_zone_identifier = module.vpc.priv_subnet_ids
  vpc_id              = module.vpc.vpc_id
  env                 = "qa"
  region              = "ue1"
  project             = "dog"
  managed_by          = "Terraform"
  instance_type       = "t2.micro"
  max_size            = 5
  min_size            = 2
  desired_capacity    = 2
  force_delete        = true
  ingress_ports       = ["22", "80"]
  ingress_cidrs       = ["44.212.71.220/32", "0.0.0.0/0"]
  bucket_key          = "terraform_web_modules/qa/terraform.tfstate"
}
module "alb" {
  source        = "../modules/alb"
  vpc_id        = module.vpc.vpc_id
  subnets       = module.vpc.pub_subnet_ids
  asg_name      = module.asg.name
  env           = "qa"
  region        = "ue1"
  project       = "dog"
  managed_by    = "Terraform"
  app_port      = 80
  ingress_ports = ["443", "80"]
  ingress_cidrs = ["0.0.0.0/0", "0.0.0.0/0"]
  bucket_key    = "terraform_web_modules/qa/terraform.tfstate"
}
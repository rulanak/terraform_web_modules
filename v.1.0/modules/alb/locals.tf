locals {
  name = "aws-${var.region}-${var.env}-${var.project}-rtype"
  common_tags = {
    env        = var.env
    project    = var.project
    managed_by = var.managed_by
  }
}
resource "aws_launch_configuration" "lc" {
  name            = replace(local.name, "rtype", "vpc")
  image_id        = data.aws_ami.amazon-linux-2.image_id
  instance_type   = var.instance_type
  user_data       = data.template_file.user_data.rendered
  security_groups = [aws_security_group.main.id]
  key_name        = aws_key_pair.terraform_server_key.key_name
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_key_pair" "terraform_server_key" {
  key_name   = "Terraform-server-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

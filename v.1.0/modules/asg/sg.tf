resource "aws_security_group" "main" {
  name        = replace(local.name, "rtype", "lc-sg")
  description = "SG for my main instance"
  vpc_id      = var.vpc_id
}
resource "aws_security_group_rule" "main_ingress_ssh" {
  count             = length(var.ingress_ports)
  type              = "ingress"
  from_port         = element(var.ingress_ports, count.index)
  to_port           = element(var.ingress_ports, count.index)
  protocol          = "tcp"
  cidr_blocks       = [element(var.ingress_cidrs, count.index)]
  security_group_id = aws_security_group.main.id
}
resource "aws_security_group_rule" "main_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" //all protocols all ports
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

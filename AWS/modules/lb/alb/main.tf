resource "aws_lb" "alb" {
	name = var.lb_name
	load_balancer_type = var.lb_type
	internal = var.lb_internal
	subnets = [var.subnet_id.0, var.subnet_id.1]
	security_groups = [var.security_group_id]
}

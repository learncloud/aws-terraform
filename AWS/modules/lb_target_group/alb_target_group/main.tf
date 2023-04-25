resource "aws_lb_target_group" "alb_target_group" {
	name = var.lb_target_group_name
	port = var.lb_target_group_port
	protocol = var.lb_target_group_protocol
	target_type = var.target_type
	vpc_id = var.vpc_id
}

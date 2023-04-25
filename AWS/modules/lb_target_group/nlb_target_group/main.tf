resource "aws_lb_target_group" "nlb_target_group" {
	name = var.lb_target_group_name
	port = var.lb_target_group_port
	protocol = var.lb_target_group_protocol
	vpc_id = var.vpc_id
	target_type = var.target_type

	health_check {
		path = "/"
		protocol = "HTTP"
		interval = 10
		healthy_threshold = 2
		unhealthy_threshold = 2
	}
}

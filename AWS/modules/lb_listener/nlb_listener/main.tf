resource "aws_lb_listener" "nlb_listener" {
	load_balancer_arn = var.nlb_arn
	port = var.nlb_listener_port
	protocol = var.nlb_listener_protocol
	
	default_action {
    		type = "forward"
		target_group_arn = var.target_group_arn
	}
}

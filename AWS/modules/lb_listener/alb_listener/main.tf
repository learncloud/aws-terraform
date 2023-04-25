resource "aws_lb_listener" "alb_listener" {
	load_balancer_arn = var.lb_arn
	port = var.lb_listener_port
	protocol = var.lb_listener_protocol

	default_action {
		type = "fixed-response"

		fixed_response {
			content_type = "text/plain"
			message_body = "404: page not found"
			status_code = 404
		}
	}
}

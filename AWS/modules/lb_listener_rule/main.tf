resource "aws_lb_listener_rule" "lb_listener_rule" {
	listener_arn = var.alb_listener_arn
	priority = 100

	condition {
		path_pattern {
			values = ["*"]
		}
	}
	action {
		type = "forward"
		target_group_arn = var.alb_target_group_arn
	}
}

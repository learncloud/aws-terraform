output "listener_arn" {
	value = aws_lb_listener.nlb_listener.arn
}

output "listener_id" {
	value = aws_lb_listener.nlb_listener.id
}

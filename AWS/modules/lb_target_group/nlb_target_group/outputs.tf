output "lb_target_group_id" {
	value = aws_lb_target_group.nlb_target_group.id
}

output "lb_target_group_arn" {
	value = aws_lb_target_group.nlb_target_group.arn
}

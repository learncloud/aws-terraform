output "auto_scaling_group_id" {
	value = aws_autoscaling_group.auto_scaling.id
}

output "auto_scaling_group_arn" {
	value = aws_autoscaling_group.auto_scaling.arn
}

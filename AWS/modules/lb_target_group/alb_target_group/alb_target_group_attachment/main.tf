resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
	count = length(var.target_ip)
	target_group_arn = var.alb_target_group_arn
	target_id = var.target_ip[count.index]
	port = 80
	availability_zone = "all"
}

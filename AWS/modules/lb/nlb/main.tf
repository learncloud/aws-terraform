resource "aws_lb" "nlb" {
	name = var.lb_name
	load_balancer_type = var.lb_type
	internal = var.lb_internal
	
	subnet_mapping {
		subnet_id = var.subnet_id.0
		private_ipv4_address = var.nlb_ip_mapping.0
	}
	subnet_mapping {
		subnet_id = var.subnet_id.1
		private_ipv4_address = var.nlb_ip_mapping.1
	}
}

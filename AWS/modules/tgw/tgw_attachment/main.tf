resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment" {
	vpc_id = var.vpc_id
	transit_gateway_id = var.tgw_id
	subnet_ids = ["${var.subnet_id.0}","${var.subnet_id.1}"]
	tags = {
		Name = var.tgw_attachment_name
	}
}

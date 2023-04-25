resource "aws_ec2_transit_gateway" "tgw" {
	amazon_side_asn = var.asn
	auto_accept_shared_attachments = var.auto_attachments
	default_route_table_association = var.route_association
	default_route_table_propagation = var.route_propagation
	dns_support = var.dns
	multicast_support = var.multicast
	vpn_ecmp_support = var.vpn
	tags = {
		Name = var.tgw_name
	}
}

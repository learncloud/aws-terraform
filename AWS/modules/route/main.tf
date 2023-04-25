resource "aws_route" "route" {
	depends_on = [var.depends]
	count = length(var.des_cidr)
	destination_cidr_block = var.des_cidr[count.index]
	gateway_id = var.gateway_id[count.index]
	route_table_id = var.route_table_id
}

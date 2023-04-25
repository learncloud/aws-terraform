resource "aws_nat_gateway" "ngw" {
	allocation_id = var.eip_id
	subnet_id = var.subnet_id
	tags = {
		Name = var.ngw_name
	}
}

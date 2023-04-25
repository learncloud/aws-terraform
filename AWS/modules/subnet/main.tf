resource "aws_subnet" "subnet" {
	count = length(var.subnet_cidr)
	vpc_id = var.vpc_id
	cidr_block = var.subnet_cidr[count.index]
	map_public_ip_on_launch = var.public_ip_launch
	availability_zone = var.az[count.index]
	tags = {
		Name = var.subnet_name[count.index]
	}
}

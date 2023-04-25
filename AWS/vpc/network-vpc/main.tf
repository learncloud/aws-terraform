provider "aws" {
	region = "us-west-2"
}

module "vpc" {
	source = "../../modules/vpc"
	vpc_cidr = "10.0.0.0/16"
	vpc_name = "network-vpc"
}

module "eip" {
	source = "../../modules/eip"
	eip_name = "eip"
}

module "igw" {
	source = "../../modules/igw"
	vpc_id = module.vpc.vpc_id
	igw_name = "igw"
}

module "tgw" {
	source = "../../modules/tgw"
	asn = "65412"
	auto_attachments = "disable"
	route_association = "disable"
	route_propagation = "disable"
	dns = "enable"
	multicast = "disable"
	vpn = "enable"
	tgw_name = "tgw"
}

module "tgw_attachment" {
	source = "../../modules/tgw/tgw_attachment"
	vpc_id = module.vpc.vpc_id
	tgw_id = module.tgw.tgw_id
	subnet_id = module.private_subnet.subnet_id
	tgw_attachment_name = "net-tgw-attachment"
}

module "tgw_route_table" {
	source = "../../modules/tgw/tgw_route_table"
	tgw_id = module.tgw.tgw_id
	tgw_route_table_name = "tgw_route_table"
}

module "tgw_route_association" {
	source = "../../modules/tgw/tgw_route_association"
	tgw_attachment_id = module.tgw_attachment.tgw_attachment_id
	tgw_route_table_id = module.tgw_route_table.tgw_route_table_id
}

module "tgw_route_propagation" {
	source = "../../modules/tgw/tgw_route_propagation"
	tgw_attachment_id = module.tgw_attachment.tgw_attachment_id
	tgw_route_table_id = module.tgw_route_table.tgw_route_table_id
}

module "tgw_route" {
	source = "../../modules/tgw/tgw_route"
	des_cidr = "0.0.0.0/0"
	tgw_attachment_id = module.tgw_attachment.tgw_attachment_id
	tgw_route_table_id = module.tgw_route_table.tgw_route_table_id
}

module "public_subnet" {
	source = "../../modules/subnet"
	vpc_id = module.vpc.vpc_id
	subnet_cidr = ["10.0.1.0/24","10.0.2.0/24"]
	az = ["us-west-2a","us-west-2c"]
	public_ip_launch = "true"
	subnet_name = ["net-pub-sub-a","net-pub-sub-c"]
}

module "private_subnet" {
	source = "../../modules/subnet"
	vpc_id = module.vpc.vpc_id
	subnet_cidr = ["10.0.3.0/24","10.0.4.0/24"]
	az = ["us-west-2a","us-west-2c"]
	public_ip_launch = "false"
	subnet_name = ["net-pri-sub-a","net-pri-sub-c"]
}

module "ngw" {
	source = "../../modules/ngw"
	eip_id = module.eip.eip_id
	subnet_id = module.public_subnet.subnet_id.0
	ngw_name = "ngw"
}

module "public_route_table" {
	source = "../../modules/route_table"
	vpc_id = module.vpc.vpc_id
	route_table_name = "net-pub-rt"
}

module "private_route_table" {
	source = "../../modules/route_table"
	vpc_id = module.vpc.vpc_id
	route_table_name = "net-pri-rt"
}

module "public_route_association" {
	source = "../../modules/route_association"
	subnet_cidr = module.public_subnet.subnet_cidr
	subnet_id = module.public_subnet.subnet_id
	route_table_id = module.public_route_table.route_table_id
}

module "private_route_association" {
	source = "../../modules/route_association"
	subnet_cidr = module.private_subnet.subnet_cidr
	subnet_id = module.private_subnet.subnet_id
	route_table_id = module.private_route_table.route_table_id
}

module "public_route" {
	source = "../../modules/route"
	depends = [module.tgw_attachment]
	des_cidr = ["0.0.0.0/0","10.1.0.0/16"]
	gateway_id = [module.igw.igw_id, module.tgw.tgw_id]
	route_table_id = module.public_route_table.route_table_id
}

module "private_route" {
	source = "../../modules/route"
	depends = [module.tgw_attachment]
	des_cidr = ["0.0.0.0/0", "10.1.0.0/16"]
	gateway_id = [module.ngw.ngw_id, module.tgw.tgw_id]
	route_table_id = module.private_route_table.route_table_id
}

module "security_group" {
	source = "../../modules/security_group"
	vpc_id = module.vpc.vpc_id
	sg_name = "all_sg"
}

module "alb" {
	source = "../../modules/lb/alb"
	lb_name = "net-alb"
	lb_type = "application"
	lb_internal = "false"
	subnet_id = module.public_subnet.subnet_id
	security_group_id = module.security_group.security_group_id
}

module "alb_listener" {
	source = "../../modules/lb_listener/alb_listener"
	lb_arn = module.alb.alb_arn
	lb_listener_port = "80"
	lb_listener_protocol = "HTTP"
}

module "alb_listener_rule" {
	source = "../../modules/lb_listener_rule"
	alb_listener_arn = module.alb_listener.alb_listener_arn
	alb_target_group_arn = module.alb_target_group.lb_target_group_arn
}

module "alb_target_group" {
	source = "../../modules/lb_target_group/alb_target_group"
	lb_target_group_name = "net-alb-tg"
	lb_target_group_port = "80"
	lb_target_group_protocol = "HTTP"
	target_type = "ip"
	vpc_id = module.vpc.vpc_id
}

module "alb_target_group_attachment" {
	source = "../../modules/lb_target_group/alb_target_group/alb_target_group_attachment"
	target_ip = ["10.1.1.100","10.1.2.200"]
	alb_target_group_arn = module.alb_target_group.lb_target_group_arn
}

module "bastion" {
	source = "../../modules/ec2"
	ami = "ami-08970fb2e5767e3b8"
	ec2_type = "t2.micro"
	subnet_id = module.public_subnet.subnet_id.0
	az = "us-west-2a"
	key_name = "test.key"
	security_group_id = module.security_group.security_group_id
	ec2_name = "bastion_server"
}

output "bastion_ip" {
	value = module.bastion.ec2_public_ip
}

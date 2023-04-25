provider "aws" {
	region = "us-west-2"
}

module "vpc" {
	source = "../../modules/vpc"
	vpc_cidr = "10.1.0.0/16"
	vpc_name = "application-vpc"
}

module "tgw_attachment" {
	source = "../../modules/tgw/tgw_attachment"
	vpc_id = module.vpc.vpc_id
	tgw_id = data.aws_ec2_transit_gateway.tgw_id.id
	subnet_id = module.private_subnet.subnet_id
	tgw_attachment_name = "app-tgw-attachment"
}

module "tgw_route_association" {
	source = "../../modules/tgw/tgw_route_association"
	tgw_attachment_id = module.tgw_attachment.tgw_attachment_id
	tgw_route_table_id = data.aws_ec2_transit_gateway_route_table.tgw_route_table_id.id
}

module "tgw_route_propagation" {
	source = "../../modules/tgw/tgw_route_propagation"
	tgw_attachment_id = module.tgw_attachment.tgw_attachment_id
	tgw_route_table_id = data.aws_ec2_transit_gateway_route_table.tgw_route_table_id.id
}

module "private_subnet" {
	source = "../../modules/subnet"
	vpc_id = module.vpc.vpc_id
	subnet_cidr = ["10.1.1.0/24","10.1.2.0/24"]
	az = ["us-west-2a","us-west-2c"]
	public_ip_launch = "false"
	subnet_name = ["app-pri-sub-a","app-pri-sub-c"]
}

module "private_route_table" {
	source = "../../modules/route_table"
	vpc_id = module.vpc.vpc_id
	route_table_name = "app-pri-rt"
}

module "private_route_association" {
	source = "../../modules/route_association"
	subnet_cidr = module.private_subnet.subnet_cidr
	subnet_id = module.private_subnet.subnet_id
	route_table_id = module.private_route_table.route_table_id
}

module "private_route" {
	source = "../../modules/route"
	depends = [module.tgw_attachment]
	des_cidr = ["10.0.0.0/16","0.0.0.0/0"]
	gateway_id = [data.aws_ec2_transit_gateway.tgw_id.id,data.aws_ec2_transit_gateway.tgw_id.id]
	route_table_id = module.private_route_table.route_table_id
}

module "security_group" {
	source = "../../modules/security_group"
	vpc_id = module.vpc.vpc_id
	sg_name = "all_sg"
}

module "template" {
	source = "../../modules/templates"
	ami = "ami-08970fb2e5767e3b8"
	ec2_type = "t2.micro"
	security_group_id = module.security_group.security_group_id
	key_name = "test.key"
}

module "nlb" {
	source = "../../modules/lb/nlb"
	lb_name = "app-nlb"
	lb_type = "network"
	lb_internal = "true"
	subnet_id = module.private_subnet.subnet_id
	nlb_ip_mapping = ["10.1.1.100","10.1.2.200"]
}

module "nlb_target_group" {
	source = "../../modules/lb_target_group/nlb_target_group"
	lb_target_group_name = "app-nlb-tg"
	lb_target_group_port = "80"
	lb_target_group_protocol = "TCP"
	vpc_id = module.vpc.vpc_id
	target_type = "instance"
}

module "nlb_listener" {
	source = "../../modules/lb_listener/nlb_listener"
	nlb_arn = module.nlb.nlb_arn
	nlb_listener_port=  "80"
	nlb_listener_protocol = "TCP"
	target_group_arn = module.nlb_target_group.lb_target_group_arn
}

module "auto_scaling_group" {
	source = "../../modules/auto_scaling_group"
	template_id = module.template.template_id
	subnet_id = module.private_subnet.subnet_id
	min_size = 2
	max_size = 4
	auto_scaling_name = "asg"
}

module "auto_scaling_attachment" {
	source = "../../modules/auto_scaling_group/auto_scaling_attachment"
	auto_scaling_group_id = module.auto_scaling_group.auto_scaling_group_id
	lb_target_group_arn = module.nlb_target_group.lb_target_group_arn
}

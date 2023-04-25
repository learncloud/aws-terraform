variable "lb_name" {
	type = string
}

variable "lb_type" {
	type = string
}

variable "lb_internal" {
	type = string
}

variable "subnet_id" {
	type = list(string)
}

variable "nlb_ip_mapping" {
	type = list(string)
}

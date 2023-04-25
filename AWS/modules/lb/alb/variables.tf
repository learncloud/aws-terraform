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

variable "security_group_id" {
	type = string
}

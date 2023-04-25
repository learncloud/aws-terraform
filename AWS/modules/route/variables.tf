variable "des_cidr" {
	type = list(string)
}

variable "gateway_id" {
	type = list(string)
}

variable "route_table_id" {
	type = string
}

variable "depends" {
	type = any
}

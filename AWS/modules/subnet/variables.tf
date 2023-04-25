variable "vpc_id" {
	type = string
}

variable "public_ip_launch" {
	type = string
}

variable "subnet_cidr" {
	type = list(string)
}

variable "az" {
	type = list(string)
}

variable "subnet_name" {
	type = list(string)
}

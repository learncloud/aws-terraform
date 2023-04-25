variable "template_id" {
	type = string
}

variable "subnet_id" {
	type = list(string)
}

variable "min_size" {
	type = number
}

variable "max_size" {
	type = number
}

variable "auto_scaling_name" {
	type = string
}

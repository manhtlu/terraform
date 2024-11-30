variable "keyname" {
  description = "Name of keypair"
  type        = string
  default     = "aws15_terraform_mykey"
}

variable "from_port" {
  type = number
  default = 80
}

variable "to_port" {
  type = number
  default = 80
}
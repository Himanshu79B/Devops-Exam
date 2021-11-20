variable "aws_profile" {
   type        = string
   default     = "default"
   description = "AWS Profile"
}

variable "aws_region" {
   type = string
   default = "eu-west-1"
   description = "AWS Region(eg: eu-west-1,eu-west2)"
}

variable "file_list" {
  type = list(string)
  description = "List of html files"
  default = ["one.html","two.html","three.html"]
}

variable "ami" {
  type = string
  default = "ami-09c3d87a33a50b325"
}

variable "instance_type" {
  type = string
  default = "t3.small"
}


variable "region" {
  description = "AWS region to build in"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Prefix used in resource names and tags"
  type        = string
  default     = "lab"
}

variable "vpc_cidr" {
  description = "IP range of the whole VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IP range of the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "IP range of the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of an EXISTING EC2 key pair in this region"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP with /32, e.g. 203.0.113.25/32 (allowed to SSH)"
  type        = string
}

variable "iam_user_name" {
  description = "Name of the IAM user to create"
  type        = string
  default     = "lab-user"
}
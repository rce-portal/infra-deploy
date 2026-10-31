variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI for web and db instances"
  type        = string
}

variable "subnet_id" {
  description = "Subnet to launch instances in"
  type        = string
}

variable "web_count" {
  description = "Number of web instances"
  type        = number
  default     = 1
}

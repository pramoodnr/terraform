variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "environment" {
  type    = string
  default = "dev"
}
variable "project_name" {
  type    = string
  default = "devops-portfolio"
}
variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}
variable "cluster_version" {
  type    = string
  default = "1.31"
}

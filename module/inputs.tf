variable "aws_region" {}

variable "aws_profile" {}

variable "ssm_role_policy" {
  default = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

variable "ecs_full_access_policy" {
  default = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

variable "vpc_id" {
  default = ""
}

variable "s3_bucket" {
    default = ""
}

variable "public_subnet_id" {
    default = ""
}

variable "kube_sg_id" {
    default = ""
}

variable "key_pair" {
    default = ""
}

variable "gitlab_fargate_mgr_instance_type" {
  default = "t2.micro"
}

variable "fargate_gitlab_mgr_ami" {
  default = "ami-0ac80df6eff0e70b5"
}

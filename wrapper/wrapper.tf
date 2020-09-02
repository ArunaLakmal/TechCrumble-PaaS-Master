data "terraform_remote_state" "core" {
    backend = "s3"

    config = {
        bucket = "${var.s3_bucket}"
        key = "dev/us-east-1/PaaS/Core/terraform.tfstate"
        region = "us-east-1"
    }
}

module "mod" {
    source = "../module"

    vpc_id = "${var.vpc_id != "" ? var.vpc_id : data.terraform_remote_state.core.outputs.vpc_id}"
    public_subnet_id = "${var.public_subnet_id != "" ? var.public_subnet_id : data.terraform_remote_state.core.outputs.public_subnet_id}"
    kube_sg_id = "${var.kube_sg_id != "" ? var.kube_sg_id : data.terraform_remote_state.core.outputs.kube_sg_id}"
    key_pair = "${var.kube_sg_id != "" ? var.kube_sg_id : data.terraform_remote_state.core.outputs.key_pair}"

    aws_region = "${var.aws_region}"
    aws_profile = "${var.aws_profile}"
}

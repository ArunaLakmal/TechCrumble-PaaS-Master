resource "aws_launch_configuration" "fargate_mgr_lc" {
  name_prefix          = "fargate_mgr_lc-"
  image_id             = "${var.fargate_gitlab_mgr_ami}"
  instance_type        = "${var.gitlab_fargate_mgr_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.fargate_mgr_instance_profile.id}"
  key_name             = "${var.key_pair}"
  user_data            = "${data.template_file.user-init-fargate-mgr.rendered}"
  security_groups      = ["${var.kube_sg_id}", ]

  lifecycle {
    create_before_destroy = true
  }
}

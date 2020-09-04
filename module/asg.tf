resource "aws_autoscaling_group" "kube_master_asg" {
  name                      = "kube_master_asg"
  max_size                  = 6
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = "${var.master_desired_capacity}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.kube_master_lc.id}"

  vpc_zone_identifier = ["${var.public_subnet_id}",
  ]
  
lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "kube_master"
    propagate_at_launch = true
  }
}

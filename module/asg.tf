resource "aws_autoscaling_group" "fargate_runner_mgr" {
  name                      = "fargate_mgr_asg"
  max_size                  = 6
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.fargate_mgr_lc.id}"

  vpc_zone_identifier = ["${var.public_subnet_id}",
  ]
  
lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "gitlab_fargate_manager"
    propagate_at_launch = true
  }
}

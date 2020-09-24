resource "aws_lb" "int_kube_master_lb" {
  name               = "kubemaster-int-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${var.private_subnet1.id}"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "int_kube_master_tg" {
  name     = "int-kube-master-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id.id}"
}

resource "aws_lb_listener" "int_kube_master_listener" {
    load_balancer_arn = "${aws_lb.int_kube_master_lb.arn}"
    tcp = "80"
    protocol = "TCP"

    default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.int_kube_master_tg.arn}"
  }
}

resource "aws_autoscaling_attachment" "int_lb-kube_master_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.kube_master_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.int_kube_master_tg.id}"
}
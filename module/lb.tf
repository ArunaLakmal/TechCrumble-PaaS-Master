resource "aws_lb" "int_kube_master_lb" {
  name               = "kubemaster-int-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${var.private_subnet1}",
  "${var.private_subnet2}"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "int_kube_master_tg" {
  name     = "int-kube-master-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group" "int_kube_master_6443" {
  name     = "int-kube-master-6443"
  port     = 6443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group" "int_kube_master_443" {
  name     = "int-kube-master-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "int_kube_master_listener" {
    load_balancer_arn = "${aws_lb.int_kube_master_lb.arn}"
    port = "80"
    protocol = "TCP"

    default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.int_kube_master_tg.arn}"
  }
}

resource "aws_lb_listener" "int_kube_master_listener_6443" {
    load_balancer_arn = "${aws_lb.int_kube_master_lb.arn}"
    port = "6443"
    protocol = "TCP"

    default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.int_kube_master_6443.arn}"
  }
}

resource "aws_lb_listener" "int_kube_master_listener_443" {
    load_balancer_arn = "${aws_lb.int_kube_master_lb.arn}"
    port = "443"
    protocol = "TCP"

    default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.int_kube_master_443.arn}"
  }
}

resource "aws_autoscaling_attachment" "int_lb-kube_master_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.kube_master_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.int_kube_master_tg.id}"
  depends_on = [aws_lb.int_kube_master_lb] 
}

resource "aws_autoscaling_attachment" "int_lb-kube_master_attachment_6443" {
  autoscaling_group_name = "${aws_autoscaling_group.kube_master_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.int_kube_master_6443.id}"
  depends_on = [aws_lb.int_kube_master_lb] 
}

resource "aws_autoscaling_attachment" "int_lb-kube_master_attachment_443" {
  autoscaling_group_name = "${aws_autoscaling_group.kube_master_asg.id}"
  alb_target_group_arn = "${aws_lb_target_group.int_kube_master_443.id}"
  depends_on = [aws_lb.int_kube_master_lb] 
}
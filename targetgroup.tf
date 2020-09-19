resource "aws_lb_target_group_attachment" "tg1" {
  target_group_arn = "${aws_lb_target_group.tg.arn}"
  target_id        = "${aws_instance.server-1.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg2" {
  target_group_arn = "${aws_lb_target_group.tg.arn}"
  target_id        = "${aws_instance.server-2.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg3" {
  target_group_arn = "${aws_lb_target_group.tg.arn}"
  target_id        = "${aws_instance.server-3.id}"
  port             = 80
}


resource "aws_lb_listener" "web" {
  load_balancer_arn = "${aws_lb.nlb.arn}"
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg.arn}"
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.r53.zone_id}"
  name    = "${aws_route53_zone.r53.name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.nlb.dns_name}"
    zone_id                = "${aws_lb.nlb.zone_id}"
    evaluate_target_health = true
  }
}
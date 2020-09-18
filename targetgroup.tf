resource "aws_lb_target_group_attachment" "tg1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.server-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.server-2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg3" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.server-3.id
  port             = 80
}

resource "aws_lb" "nlb" {
  name               = "aws-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public.*.id]
  enable_deletion_protection = true
 
} 
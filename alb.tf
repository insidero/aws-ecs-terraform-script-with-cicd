###################
## Load Balancer ##
###################
resource "aws_lb" "alb" {
    name               = "${var.name}-alb-1"
    load_balancer_type = "application"
    subnets            = module.vpc.public_subnets
    internal           = false
    security_groups = [aws_security_group.sg.id]
}

resource "aws_lb_target_group" "lb_target_group_1" {
    name        = "${var.name}-target-group-1"
    port        = "80"
    protocol    = "HTTP"
    target_type = "instance"
    vpc_id      = module.vpc.vpc_id
    health_check {
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        interval            = 300
        matcher             = "200,301,302"
    }
}

resource "aws_lb_listener" "web_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.lb_target_group_1.arn
    }
}

######
######

resource "aws_lb" "alb_2" {
    name               = "${var.name}-alb-2"
    load_balancer_type = "application"
    subnets            = module.vpc.public_subnets
    internal           = false
    security_groups = [aws_security_group.sg.id]
}

resource "aws_lb_target_group" "lb_target_group_2" {
    name        = "${var.name}-target-group-2"
    port        = "80"
    protocol    = "HTTP"
    target_type = "instance"
    vpc_id      = module.vpc.vpc_id
    health_check {
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        interval            = 300
        matcher             = "200,301,302"
    }
}

resource "aws_lb_listener" "web_listener_2" {
    load_balancer_arn = aws_lb.alb_2.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.lb_target_group_2.arn
    }
}


######
######

resource "aws_lb" "alb_3" {
    name               = "${var.name}-alb-3"
    load_balancer_type = "application"
    subnets            = module.vpc.public_subnets
    internal           = false
    security_groups = [aws_security_group.sg.id]
}

resource "aws_lb_target_group" "lb_target_group_3" {
    name        = "${var.name}-target-group-3"
    port        = "80"
    protocol    = "HTTP"
    target_type = "instance"
    vpc_id      = module.vpc.vpc_id
    health_check {
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 6
        interval            = 300
        matcher             = "200,301,302"
    }
}

resource "aws_lb_listener" "web_listener_3" {
    load_balancer_arn = aws_lb.alb_3.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.lb_target_group_3.arn
    }
}

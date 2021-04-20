##############################
##### Autoscaling Group ######
##############################
module "asg" {
    source  = "terraform-aws-modules/autoscaling/aws"
    version = "~> 3.0"

    name = "${var.name}-ecs-asg"

    # Launch configuration
    lc_name = "${var.name}-ecs-lc"

    image_id             = data.aws_ami.aws-linux-2.id
    instance_type        = "t2.micro"
    key_name             = var.key_name
    security_groups      = [aws_security_group.sg.id]
    iam_instance_profile = aws_iam_instance_profile.ecs_service_role.name
    user_data            = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo echo "ECS_CLUSTER=${module.ecs.this_ecs_cluster_name}" >> /etc/ecs/ecs.config
    EOF

    # Auto scaling group
    asg_name                  = "${var.name}-ecs-asg"
    vpc_zone_identifier       = module.vpc.private_subnets
    health_check_type         = "EC2"
    min_size                  = 0
    max_size                  = 2
    desired_capacity          = 1 # we don't need them for the example
    wait_for_capacity_timeout = 0
    target_group_arns         = [aws_lb_target_group.lb_target_group_1.arn, aws_lb_target_group.lb_target_group_2.arn]

    tags = [
        {
        key                 = "Name"
        value               = "${var.name}-ecs-asg"
        propagate_at_launch = true
        },
        {
        key                 = "CreatedBy"
        value               = "DevOps Team"
        propagate_at_launch = true
        }
    ]
}

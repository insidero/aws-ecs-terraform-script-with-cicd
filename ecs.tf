################
##### ECS ######
################
module "ecs" {
    source  = "terraform-aws-modules/ecs/aws"
    version = "2.8.0"
    name = "${var.name}-ecs-app"

    capacity_providers = [aws_ecs_capacity_provider.provider.name]

    default_capacity_provider_strategy = [
        {
        capacity_provider = aws_ecs_capacity_provider.provider.name
        weight            = "1"
        }
    ]

    tags = {
        "CreatedBy"       = "DevOps Team"
    }
}

##################################
##### ECS Capacity Provider ######
##################################
resource "aws_ecs_capacity_provider" "provider" {
    name = "${var.name}-ecs-provider"

    auto_scaling_group_provider {
        auto_scaling_group_arn = module.asg.this_autoscaling_group_arn
    }
}

####################
## Task Defintion 1 ##
####################
resource "aws_ecs_task_definition" "task_defintion_1" {
    family = "${var.name}-task-defintion-1"
    requires_compatibilities = ["EC2"]
    network_mode = "bridge"

    container_definitions =<<EOF
[{
    "name": "ecs-vote",
    "image": "${aws_ecr_repository.repo_1.repository_url}:latest",
    "cpu": 128,
    "memory": 128,
    "essential": true,
    "portMappings": [
        {
            "containerPort": 80,
            "hostPort": 0,
            "protocol": "tcp"
        }
    ]
}]
    EOF
}

#################
## ECS Service 1 ##
#################
resource "aws_ecs_service" "ecs_service_1" {
    name            = "${var.name}-ecs-service-1"
    cluster         = module.ecs.this_ecs_cluster_id
    task_definition = aws_ecs_task_definition.task_defintion_1.arn
    desired_count = 1

    deployment_maximum_percent         = 100
    deployment_minimum_healthy_percent = 0

    launch_type = "EC2"

    load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group_1.arn
    container_name   = "ecs-vote"
    container_port   = 80
    }

    depends_on = [ aws_lb_listener.web_listener ]
}


####################
## Task Defintion 2 ##
####################
resource "aws_ecs_task_definition" "task_defintion_2" {
    family = "${var.name}-task-defintion-2"
    requires_compatibilities = ["EC2"]
    network_mode = "bridge"

    container_definitions =<<EOF
[{
    "name": "ecs-worker",
    "image": "${aws_ecr_repository.repo_2.repository_url}:latest",
    "cpu": 128,
    "memory": 128,
    "essential": true,
    "portMappings": [
        {
            "containerPort": 80,
            "hostPort": 0,
            "protocol": "tcp"
        }
    ]
}]
    EOF
}

#################
## ECS Service 2 ##
#################
resource "aws_ecs_service" "ecs_service_2" {
    name            = "${var.name}-ecs-service-2"
    cluster         = module.ecs.this_ecs_cluster_id
    task_definition = aws_ecs_task_definition.task_defintion_2.arn
    desired_count = 1

    deployment_maximum_percent         = 100
    deployment_minimum_healthy_percent = 0

    launch_type = "EC2"

    load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group_2.arn
    container_name   = "ecs-worker"
    container_port   = 80
    }

    depends_on = [ aws_lb_listener.web_listener_2 ]
}


####################
## Task Defintion 3 ##
####################
resource "aws_ecs_task_definition" "task_defintion_3" {
    family = "${var.name}-task-defintion-3"
    requires_compatibilities = ["EC2"]
    network_mode = "bridge"

    container_definitions =<<EOF
[{
    "name": "ecs-result",
    "image": "${aws_ecr_repository.repo_3.repository_url}:latest",
    "cpu": 128,
    "memory": 128,
    "essential": true,
    "portMappings": [
        {
            "containerPort": 80
        },
        {
            "containerPort": 5858
        }
    ]
}]
    EOF
}

#################
## ECS Service 3 ##
#################
resource "aws_ecs_service" "ecs_service_3" {
    name            = "${var.name}-ecs-service-3"
    cluster         = module.ecs.this_ecs_cluster_id
    task_definition = aws_ecs_task_definition.task_defintion_3.arn
    desired_count = 1

    deployment_maximum_percent         = 100
    deployment_minimum_healthy_percent = 0

    launch_type = "EC2"

    load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group_3.arn
    container_name   = "ecs-result"
    container_port   = 80
    }

    depends_on = [ aws_lb_listener.web_listener_3 ]
}

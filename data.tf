data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "aws-linux-2" {
    most_recent = true

    filter {
        name   = "name"
        values = ["amzn2-ami-ecs-hvm*"]
    }

    filter {
        name   = "architecture"
        values = ["x86_64"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    
    owners = ["amazon", "self"]
}


data "aws_vpc" "main" {
    id = module.vpc.vpc_id
}

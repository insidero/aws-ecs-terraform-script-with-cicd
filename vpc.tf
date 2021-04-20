module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "2.44.0"

    name           = "${var.name}-ecs-vpc"
    cidr           = "10.0.0.0/16"
    azs            = ["us-east-2a", "us-east-2b"]
    public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnets = ["10.0.2.0/24","10.0.3.0/24"]
    
    enable_nat_gateway = true
    single_nat_gateway = true
    one_nat_gateway_per_az = false

    enable_dns_hostnames  = true

    tags = {
        "CreatedBy"       = "DevOps Team"
    }
}

resource "aws_security_group" "sg" {
    name   = "allow-all"
    vpc_id = module.vpc.vpc_id
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "CreatedBy"       = "DevOps Team"
    }
}
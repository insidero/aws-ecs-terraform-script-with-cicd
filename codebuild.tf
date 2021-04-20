resource "aws_codebuild_project" "codebuild_project_1" {
    name          = "${var.name}-build-project-1"
    description   = "${var.name} Build Project for test ECS application."
    build_timeout = "10"
    service_role  = aws_iam_role.codebuild_role.arn

    source {
        type            = "CODEPIPELINE"
        buildspec       = "buildspec-1.yml"
        git_clone_depth = 1

        git_submodules_config {
        fetch_submodules = false
        }
    }

    environment {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
        type                        = "LINUX_CONTAINER"
        image_pull_credentials_type = "CODEBUILD"
        privileged_mode             = true
    }


    vpc_config {
        vpc_id = module.vpc.vpc_id

        subnets = [
        module.vpc.private_subnets[0],
        module.vpc.private_subnets[1]
        ]

        security_group_ids = [
        aws_security_group.sg.id
        ]
    }

    artifacts {
        type = "CODEPIPELINE"
        artifact_identifier = "BuildArtifact"
    }

    logs_config {
        cloudwatch_logs {
        group_name  = "${var.name}-build-project-log-group"
        stream_name = "${var.name}-build-project-log-stream"
        }
    }

    cache {
        type  = "LOCAL"
        modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
    }

    tags = merge(
        var.additional_tags,
        {
            Name = "${var.name}-build-project-1"
        },
    )
}


resource "aws_codebuild_project" "codebuild_project_2" {
    name          = "${var.name}-build-project-2"
    description   = "${var.name} Build Project for test ECS application."
    build_timeout = "10"
    service_role  = aws_iam_role.codebuild_role.arn

    source {
        type            = "CODEPIPELINE"
        buildspec       = "buildspec-2.yml"
        git_clone_depth = 1

        git_submodules_config {
        fetch_submodules = false
        }
    }

    environment {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
        type                        = "LINUX_CONTAINER"
        image_pull_credentials_type = "CODEBUILD"
        privileged_mode             = true
    }


    vpc_config {
        vpc_id = module.vpc.vpc_id

        subnets = [
        module.vpc.private_subnets[0],
        module.vpc.private_subnets[1]
        ]

        security_group_ids = [
        aws_security_group.sg.id
        ]
    }

    artifacts {
        type = "CODEPIPELINE"
        artifact_identifier = "BuildArtifact"
    }

    logs_config {
        cloudwatch_logs {
        group_name  = "${var.name}-build-project-log-group"
        stream_name = "${var.name}-build-project-log-stream"
        }
    }

    cache {
        type  = "LOCAL"
        modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
    }

    tags = merge(
        var.additional_tags,
        {
            Name = "${var.name}-build-project-2"
        },
    )
}


resource "aws_codebuild_project" "codebuild_project_3" {
    name          = "${var.name}-build-project-3"
    description   = "${var.name} Build Project for test ECS application."
    build_timeout = "10"
    service_role  = aws_iam_role.codebuild_role.arn

    source {
        type            = "CODEPIPELINE"
        buildspec       = "buildspec-3.yml"
        git_clone_depth = 1

        git_submodules_config {
        fetch_submodules = false
        }
    }

    environment {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
        type                        = "LINUX_CONTAINER"
        image_pull_credentials_type = "CODEBUILD"
        privileged_mode             = true
    }


    vpc_config {
        vpc_id = module.vpc.vpc_id

        subnets = [
        module.vpc.private_subnets[0],
        module.vpc.private_subnets[1]
        ]

        security_group_ids = [
        aws_security_group.sg.id
        ]
    }

    artifacts {
        type = "CODEPIPELINE"
        artifact_identifier = "BuildArtifact"
    }

    logs_config {
        cloudwatch_logs {
        group_name  = "${var.name}-build-project-log-group"
        stream_name = "${var.name}-build-project-log-stream"
        }
    }

    cache {
        type  = "LOCAL"
        modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
    }

    tags = merge(
        var.additional_tags,
        {
            Name = "${var.name}-build-project-3"
        },
    )
}

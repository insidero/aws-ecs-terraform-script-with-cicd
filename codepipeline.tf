resource "aws_codepipeline" "codepipeline" {
    name     = "${var.name}-pipeline"
    role_arn = aws_iam_role.codepipeline_role.arn

    artifact_store {
        location = aws_s3_bucket.codepipeline_bucket.bucket
        type     = "S3"
    }

    stage {
        name = "Source"

        action {
        name             = "Source"
        category         = "Source"
        owner            = "AWS"
        provider         = "CodeStarSourceConnection"
        version          = "1"
        output_artifacts = ["SourceArtifacts"]
        namespace        = "SourceVariables"

        configuration = {
            ConnectionArn  = var.connection_arn
            FullRepositoryId = var.full_repository_id
            BranchName     = var.branch
            }
        }
    }

    stage {
        name = "Build"

        action {
        name             = "Build-1"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        version          = "1"
        input_artifacts  = ["SourceArtifacts"]
        output_artifacts = ["BuildArtifact1"]

        configuration = {
            ProjectName = aws_codebuild_project.codebuild_project_1.id
            }
        }

        action {
        name             = "Build-2"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        version          = "1"
        input_artifacts  = ["SourceArtifacts"]
        output_artifacts = ["BuildArtifact2"]

        configuration = {
            ProjectName = aws_codebuild_project.codebuild_project_2.id
            }
        }

        action {
        name             = "Build-3"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        version          = "1"
        input_artifacts  = ["SourceArtifacts"]
        output_artifacts = ["BuildArtifact3"]

        configuration = {
            ProjectName = aws_codebuild_project.codebuild_project_3.id
            }
        }
    }

    stage {
        name = "Deploy"

        action {
        name            = "Deploy-1"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "ECS"
        input_artifacts = ["BuildArtifact1"]
        version         = "1"
        run_order        = "1"

        configuration = {
            ClusterName = module.ecs.this_ecs_cluster_name
            ServiceName = aws_ecs_service.ecs_service_1.name
            FileName = "imagedefinitions.json"
            }
        }

        action {
        name            = "Deploy-2"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "ECS"
        input_artifacts = ["BuildArtifact2"]
        version         = "1"
        run_order        = "2"

        configuration = {
            ClusterName = module.ecs.this_ecs_cluster_name
            ServiceName = aws_ecs_service.ecs_service_2.name
            FileName = "imagedefinitions.json"
            }
        }

        action {
        name            = "Deploy-3"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "ECS"
        input_artifacts = ["BuildArtifact3"]
        version         = "1"
        run_order        = "3"

        configuration = {
            ClusterName = module.ecs.this_ecs_cluster_name
            ServiceName = aws_ecs_service.ecs_service_3.name
            FileName = "imagedefinitions.json"
            }
        }

    }

    tags = merge(
        var.additional_tags,
        {
            Name = "${var.name}-ecs-pipeline"
        },
    )

    depends_on = [aws_codebuild_project.codebuild_project_1]
}

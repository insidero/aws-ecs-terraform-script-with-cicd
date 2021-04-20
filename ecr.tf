resource "aws_ecr_repository" "repo_1" {
    name                 = "${var.name}-ecr-repo-1"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = false
    }

    tags = {
        "CreatedBy"       = "DevOps Team"
    }
}

resource "aws_ecr_repository" "repo_2" {
    name                 = "${var.name}-ecr-repo-2"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = false
    }

    tags = {
        "CreatedBy"       = "DevOps Team"
    }
}

resource "aws_ecr_repository" "repo_3" {
    name                 = "${var.name}-ecr-repo-3"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = false
    }

    tags = {
        "CreatedBy"       = "DevOps Team"
    }
}

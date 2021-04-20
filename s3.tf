#### Bucket for Codepipeline #####
resource "aws_s3_bucket" "codepipeline_bucket" {
    bucket_prefix = "${var.name}-codepipeline-${var.region}-"
    acl    = "private"
    force_destroy = true

    tags = var.additional_tags
}
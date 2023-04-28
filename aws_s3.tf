provider "aws" {
    region = var.aws_region
    access_key = var.access-key
    secret_key = var.secret-key
}

resource "aws_s3_bucket" "S3_standard_bucket" {
    bucket = "${var.bucket-name}"
    acl = "private"
    lifecycle_rule {
        id = "archive"
        enabled = true
        transition {
            days = 30
            storage_class = "STANDARD_IA"

        }
    }

    versioning {
        enabled = true
    }
    tags = {ENVIRONMENT: "QA"}
    
    server_side_encyption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = aws_kms_key.my_key.arn
                sse_algorithm = "aws:kms"
            }
        }
    }
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}
resource "aws_s3_bucket_metric" "enabling-metric" {
  bucket = var.bucket-name
  name = "EntireBucket"
}

resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = aws_s3_bucket.S3_standard_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "transfer.amazonaws.com"
        }
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.S3_standard_bucket.arn}/*",
          "${aws_s3_bucket.S3_standard_bucket.arn}"
        ]
      }
    ]
  })
}
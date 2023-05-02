# Create an AWS KMS customer master key (CMK)

resource "aws_kms_key_policy" "my_key_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "Allow Access to Key User"

        Effect = "Allow"
        Principal = {
          AWS = [
            aws_iam_user.iam_user.arn,
            aws_iam_role.s3_access_role.arn,
          ]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
        ]
        Resource = aws_kms_key.my_key.arn
      },
    ]
  })
}

resource "aws_kms_key" "my_key" {
  description             = "Sample KMS key"
  policy                  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_role.s3_access_role.arn
        }
        Action    = "kms:*"
        Resource  = "*"
      },
      {
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_user.iam_user.arn
        }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })
}

resource "aws_kms_grant" "my_key_grant" {
  name        = "my_key_grant"
  key_id      = aws_kms_key.my_key.id
  grantee_principal = aws_iam_user.iam_user.arn
  operations  = ["Decrypt"]
}

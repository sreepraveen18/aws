
provider "aws" {
  region = var.aws_region
}


# Create an SFTP server
resource "aws_transfer_server" "server_sftp" {
  identity_provider_type = "SERVICE_MANAGED"
  endpoint_type           = "PUBLIC"
  tags = {
    Name = "example-sftp-server"
  }
}

# Create an SFTP user
resource "aws_transfer_user" "server_sftp" {
  server_id = aws_transfer_server.server_sftp.id
  user_name = "sample_user"
  role      = aws_iam_role.sftp_role.arn
  home_directory = aws_s3_bucket.S3_standard_bucket.arn
}

# Create an SFTP server endpoint
resource "aws_transfer_server_endpoint" "example_sftp_endpoint" {
  server_id = aws_transfer_server.server_sftp.id
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id1
}



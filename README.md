# AWS Assesment
## Here are few steps to follow in order to complete the given task

* Step 1: Set up an SFTP server using Terraform for AWS Transfer for SFTP service. This service provides a fully managed SFTP service that can be used to securely transfer files to and from Amazon S3 buckets. Each agency can be given access to a specific S3 bucket through this service. Please find the file under the name aws_sftp.tf

* Step 2: Create S3 buckets, IAM roles and users and write the neccessary policies and give access to these buckets for the prepared IAM users/roles using AWS KMS. You can find the terraform file at aws_iam.tf, aws_kms.tf and aws_s3.tf. For security and redundency purpose fill out the credentials/region and variables in a variable.tf file.

* Step 3: Create a AWS CMK that will encrypt the data in the S3. Define an IAM policy that allows only the necessary permissions to the S3 bucket for the users and roles that require access. This IAM policy should follow the principle of least privilege and specify only the necessary permissions required to access the S3 bucket.

* Step 4: Setup cloudwatch to monitor these S3 buckets and trigger notifications when uploaded each time. Schedule a cron job to run every day so that it is run daily to check the upload process and if not to inform the administrator. Integrate this with slack so that you can get notification directly over slack.

* Step 5: To roll back and de-provision, run the command "Terraform destroy" to remove all the resources created using terraform.

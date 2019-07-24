locals {
  pagename              = "index.html"
  resources_folder_name = "resources"
  bucket_name           = "rmeis-resume-${terraform.workspace}"
}
resource "aws_s3_bucket" "site" {
  bucket = local.bucket_name
  acl    = "public-read"

  website {
    index_document = local.pagename
  }
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${local.bucket_name}/*"
      ]
    }
  ]
}
EOF
}
#resource "aws_s3_bucket_object" "root" {
#  bucket = aws_s3_bucket.maintenance.id
#  key = local.pagename
#  source = "site/${local.pagename}"
#
#}

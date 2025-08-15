provider "aws" {
    region= "us-east-1"
}

variable "bucket_name" {
    type = string
}

resource "aws_s3_bucket" "static_site_bucket" {
    bucket = "static-site-${var.bucket_name}"
}

resource "aws_s3_bucket_website_configuration" "static_site_config" {
    bucket = aws_s3_bucket.static_site_bucket.bucket    

    index_document {
        suffix = "index.html"
    }

   error_document  {
        key = "404.html"
    }
}

resource "aws_s3_bucket_public_access_block" "static_site_bucket" {
    bucket = aws_s3_bucket.static_site_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "static_site_bucket"{
    bucket = aws_s3_bucket.static_site_bucket.id
    rule {
        object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_acl" "static_site_bucket" {
    depends_on = [
        aws_s3_bucket_public_access_block.static_site_bucket,
        aws_s3_bucket_ownership_controls.static_site_bucket,
    ]

    bucket = aws_s3_bucket.static_site_bucket.id
    acl = "public-read"
}
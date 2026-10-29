terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version =  "~> 6.0"
    }
  }
}

provider "aws" {
    region = "ap-southeast-2"
  
}

resource "aws_s3_bucket" "my-bucket" {
    bucket = "myproject-${data.aws_caller_identity.current.account_id}"
  
}



resource "aws_iam_group" "s3_group" {

    name = "lab-s3-group"

  
}

resource "aws_iam_group_policy_attachment" "s3_full" {
    group= aws_iam_group.s3_group.name
    policy_arn= "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  
}

resource "aws_iam_user" "lab_user" {
    name = "lab-user"

  
}

resource "aws_iam_user_policy_attachment" "ec2_full" {
    user = aws_iam_user.lab_user.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  
}

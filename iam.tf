# Permissions live on a group, users join the group
resource "aws_iam_group" "readonly" {
  name = "${var.project_name}-readonly"
}

resource "aws_iam_group_policy_attachment" "ec2_readonly" {
  group      = aws_iam_group.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "s3_readonly" {
  group      = aws_iam_group.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_user" "lab_user" {
  name = var.iam_user_name
}

resource "aws_iam_user_group_membership" "lab_user" {
  user   = aws_iam_user.lab_user.name
  groups = [aws_iam_group.readonly.name]
}
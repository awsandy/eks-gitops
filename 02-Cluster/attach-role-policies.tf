resource "aws_iam_role_policy_attachment" "ssmcore" {
  role       = module.karpenter.aws_iam_instance_profile.this[0].role
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_role_policy_attachment" "cwserver" {
  role       = module.karpenter.aws_iam_instance_profile.this[0].role
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}



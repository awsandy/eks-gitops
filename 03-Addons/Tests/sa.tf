resource "kubernetes_service_account_v1" "secretsa" {
  metadata {
    name = "secretsa"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role_arn" = aws_iam_role.secretsa.arn
    }
  }
  automount_service_account_token = true 
}

resource "aws_iam_role" "secretsa" {
  name                  = "role-secretsa"
  force_detach_policies = true
  max_session_duration  = 3600
  path                  = "/"
  assume_role_policy    = data.aws_iam_policy_document.trust-secretsa.json
}


# policy is same as CloudWatchAgentServerPolicy
# except - includes Put RetentionPolicy - and doesn't have * for Resource
resource "aws_iam_policy" "secretsa" {
  name        = "secretsa"
  path        = "/"
  description = "policy for secrets mgr "
  policy = data.aws_iam_policy_document.secretsa.json
}

######## Policy attachment to IAM role ########

resource "aws_iam_role_policy_attachment" "secretsa-attach1" {
  role       = aws_iam_role.secretsa.name
  policy_arn = aws_iam_policy.secretsa.arn
}


data "aws_iam_policy_document" "secretsa" {
  statement {
    effect = "Allow" # the default
    actions = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
    ]
    resources = [format("arn:aws:secretsmanager:%s:%s:secret:*",data.aws_region.current.name,data.aws_caller_identity.current.account_id)]
  }
}

  data "aws_iam_policy_document" "trust-secretsa" {
  statement {
    effect = "Allow" # the default
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.example.arn]
    }
    condition {
        #test = "ForAnyValue:StringEquals"
        test = "StringEquals"
        variable = format("%s:aud",data.aws_iam_openid_connect_provider.example.url)
        values = ["sts.amazonaws.com"]
    }
    condition {
        #test = "ForAnyValue:StringEquals"
        test = "StringEquals"
        variable = format("%s:sub",data.aws_iam_openid_connect_provider.example.url)
        values = [format("system:serviceaccount:default:%s",kubernetes_service_account_v1.secretsa.metadata[0].name)]
    }
  }
}


data "aws_iam_openid_connect_provider" "example" {
  depends_on = [ module.eks, module.vpc]
  #url = "https://oidc.eks.eu-west-2.amazonaws.com/id/92689730BC26F44B10C02F4412A09911"
  url=  format("https://%s",module.eks.oidc_provider)
}


data "aws_eks_cluster" "example" {
  name = module.eks.cluster_name
}

#output "endpoint" {
#  value = data.aws_eks_cluster.example.endpoint
#}


# Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019.
#output "identity-oidc-issuer" {
#  value = data.aws_eks_cluster.example.identity[0].oidc[0].issuer
#}

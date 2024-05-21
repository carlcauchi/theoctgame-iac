#module "lb_role" {
#  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#
#  role_name                              = "demo_eks_lb"
#  attach_load_balancer_controller_policy = true
#
#  oidc_providers = {
#    main = {
#      provider_arn               = module.eks.oidc_provider_arn
#      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
#    }
#  }
#}
#
#resource "kubernetes_service_account" "service-account" {
#  metadata {
#    name      = "aws-load-balancer-controller"
#    namespace = "kube-system"
#    labels = {
#      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
#      "app.kubernetes.io/component" = "controller"
#    }
#    annotations = {
#      "eks.amazonaws.com/role-arn"               = module.lb_role.iam_role_arn
#      "eks.amazonaws.com/sts-regional-endpoints" = "true"
#    }
#  }
#}
#
#resource "helm_release" "alb-controller" {
#  name       = "aws-load-balancer-controller"
#  repository = "https://aws.github.io/eks-charts"
#  chart      = "aws-load-balancer-controller"
#  namespace  = "kube-system"
#  depends_on = [
#    kubernetes_service_account.service-account
#  ]
#
#  set {
#    name  = "region"
#    value = data.aws_region.current.name
#  }
#
#  set {
#    name  = "vpcId"
#    value = module.vpc-eucentral1.vpc_id
#  }
#
#  set {
#    name  = "serviceAccount.create"
#    value = "false"
#  }
#
#  set {
#    name  = "serviceAccount.name"
#    value = "aws-load-balancer-controller"
#  }
#
#  set {
#    name  = "clusterName"
#    value = module.eks.cluster_name
#  }
#}

module "eks_aws-load-balancer-controller" {
  source  = "akw-devsecops/eks/aws//modules/aws-load-balancer-controller"
  version = "2.6.11"
  cluster_name = var.cluster_name
  oidc_provider_arn =  module.eks.oidc_provider_arn
}
data "aws_availability_zones" "supported" {
  filter {
    name   = "zone-name"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
  state = "available"
}

data "aws_subnets" "filtered_public" {
  filter {
    name   = "tag:kubernetes.io/role/elb"
    values = ["1"]
  }

  filter {
    name   = "availability-zone"
    values = data.aws_availability_zones.supported.names
  }
}

# Create the EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "Three-tier-cloud"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.filtered_public.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

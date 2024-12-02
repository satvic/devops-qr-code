module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "satviks-cluster-eks"
  cluster_version = "1.31"

  cluster_endpoint_public_access  = true

  vpc_id                   = aws_vpc.my_vpc.id
  subnet_ids               = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  control_plane_subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]

  eks_managed_node_groups = {
    green = {
      instance_types = ["t3.medium"]
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
}
output "vpc_ALD_id" {
  value = aws_vpc.aws-ALD-vpc.id
  description = "Fetch the vpc id upon executing the plan"
}

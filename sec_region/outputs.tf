output "ALB_Link" {
  value = "http://${aws_lb.tf_campf_demo_alb.dns_name}"
}

output "VPC_ID" {
  value = aws_vpc.demo_vpc.id
}
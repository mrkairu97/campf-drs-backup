output "EC2_1_Instance" {
  value = aws_instance.ec2_1.id
}

output "EC2_2_Instance" {
    value = aws_instance.ec2_2.id
}

output "ALB_Link_Main" {
  value = "http://${aws_lb.tf_campf_demo_alb.dns_name}"
}

output "ALB_Link_Sec" {
  value = "http://${aws_lb.tf_campf_demo_alb_stg.dns_name}"
}

output "VPC_ID_Main" {
  value = aws_vpc.demo_vpc.id
}

output "VPC_ID_Staging" {
  value = aws_vpc.demo_vpc_staging.id
}

# output "VPC_ID_Sec" {
#   value = aws_vpc.demo_vpc_sec.id
# }
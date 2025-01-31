output "eks_security_group_id" {
  value = aws_security_group.eks_security_group.id
}


output "eks_execution_role_arn" {
  value = aws_iam_role.eks_execution_role.arn
}

output "eks_task_role_arn" {
  value = aws_iam_role.eks_task_role.arn
}

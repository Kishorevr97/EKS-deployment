output "patient_service_repo_url" {
  value = aws_ecr_repository.patient_service_repo.repository_url
}

output "appointment_service_repo_url" {
  value = aws_ecr_repository.appointment_service_repo.repository_url
}

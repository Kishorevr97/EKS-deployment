resource "aws_ecr_repository" "patient_service_repo" {
  name = "${var.environment}-patient-service-repo"
}

resource "aws_ecr_repository" "appointment_service_repo" {
  name = "${var.environment}-appointment-service-repo"
}

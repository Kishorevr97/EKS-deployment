resource "aws_ecr_repository" "patient_service" {
  name = "patient-service-repo"
  tags = {
    Name = "Patient Service Repository"
  }
}

resource "aws_ecr_repository" "appointment_service" {
  name = "appointment-service-repo"
  tags = {
    Name = "Appointment Service Repository"
  }
}

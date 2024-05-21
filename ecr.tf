resource "aws_ecr_repository" "web3app" {
  name = "web3app"
  image_scanning_configuration {
    scan_on_push = true
  }
}
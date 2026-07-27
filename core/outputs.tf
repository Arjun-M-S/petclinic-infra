# --- EKS ---
output "cluster_name" {
  description = "EKS cluster name — used by `aws eks update-kubeconfig` in CI"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded cluster CA cert, for kubeconfig / provider blocks"
  value       = module.eks.cluster_certificate_authority_data
}

# --- RDS ---
output "db_endpoint" {
  description = "RDS connection endpoint (host:port) for the app's DB env var"
  value       = aws_db_instance.default.endpoint
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.default.db_name
}

output "db_username" {
  description = "Master DB username"
  value       = aws_db_instance.default.username
}

output "db_password_secret_arn" {
  description = "Secrets Manager ARN holding the DB password — fetch this in CI/app, never the raw value"
  value       = aws_secretsmanager_secret.db_password.arn
}

# --- VPC ---
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

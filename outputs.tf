output "dashboard_public_ip" {
  description = "Public IP of dashboard-instance"
  value       = module.dashboard_instance.public_ip
}

output "counting_private_ip" {
  description = "Private IP of couting-instance"
  value       = module.counting_instance.private_ip
}
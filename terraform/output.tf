output "public-IP-of-server0" {
  value = aws_instance.server0.public_ip
}

output "public-IP-of-server1" {
  value = aws_instance.server1.public_ip
}

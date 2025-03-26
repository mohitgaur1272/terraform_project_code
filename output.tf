output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "jump_server_public_ip" {
  value = aws_instance.jump_server.public_ip
}

output "private_server_private_ips" {
  value = aws_instance.private_servers[*].private_ip
}

output "key_pair_name" {
  value = aws_key_pair.my_key.key_name
}

output "jump_security_group_name" {
  value = aws_security_group.jump_server_sg
}

output "private_security_group_name" {
    value = aws_security_group.private_server_sg
}

output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
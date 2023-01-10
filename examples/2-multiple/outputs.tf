resource "local_file" "private_key" {
  for_each = tls_private_key.this

  filename        = "${each.key}-private-key.pem"
  content         = each.value.private_key_pem
  file_permission = 400
}
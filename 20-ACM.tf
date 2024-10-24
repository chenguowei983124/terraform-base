resource "aws_acm_certificate" "vpn_server_cert" {
  private_key       = file("./files/ncchd-dpc-dev-server.key")
  certificate_body  = file("./files/ncchd-dpc-dev-server.crt")
  certificate_chain = file("./files/ca.crt")

  tags = {
    Name = "VPN Server Certificate"
  }
}

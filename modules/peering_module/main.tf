resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = var.vpc_id
  peer_owner_id = var.peering_accout_id
  peer_vpc_id   = var.peering_vpc_id
  auto_accept   = true

  tags = {
    Name = "${var.tag_name}-peering"
  }
}
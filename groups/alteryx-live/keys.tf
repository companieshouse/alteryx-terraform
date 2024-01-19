# ------------------------------------------------------------------------------
# Key Pair
# ------------------------------------------------------------------------------
resource "aws_key_pair" "alteryx_keypair" {
  key_name   = "${var.application}-${var.application_environment}"
  public_key = local.alteryx_ec2_data 
}

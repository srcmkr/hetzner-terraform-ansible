# ----------------------------------------
# add (existing) SSH key to login remotely
# ----------------------------------------
resource "hcloud_ssh_key" "default" {
  name = "public SSH Key"
  public_key = file("secrets/ssh.public")
}
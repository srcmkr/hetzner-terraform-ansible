resource "hcloud_server" "node1" {
 name           = "k8s-node-1"
 image          = "ubuntu-20.04"
 server_type    = "cx21"
 location       = "fsn1"
 labels = {
   "worker"     = "true"
 }
 ssh_keys       = [hcloud_ssh_key.default.name]
}
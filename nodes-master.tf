resource "hcloud_server" "master1" {
 name             = "k8s-master-1"
 image            = "ubuntu-20.04"
 location         = "fsn1"
 server_type      = "cx21"
 labels = {
   "clusterentry" = "true"
 }
 ssh_keys         = [hcloud_ssh_key.default.name]
}
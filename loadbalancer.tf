#
# smallest LB in Falkenstein
#
resource "hcloud_load_balancer" "load_balancer" {
  name                = "load_balancer"
  load_balancer_type  = "lb11"                    # Options: lb11, lb21, lb31
  location            = "fsn1"                    # Options: fsn1, nbg1, hel1
}

#
# LB uses Label as target
#
resource "hcloud_load_balancer_target" "load_balancer_target" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  type            = "label_selector"
  label_selector  = "clusterentry"
}

#
# HTTP Service for Ingress (map 80 to 30080)
#
resource "hcloud_load_balancer_service" "load_balancer_service_80" {
    load_balancer_id = hcloud_load_balancer.load_balancer.id
    protocol          = "http"
    listen_port       = "80"
    destination_port  = "30080"
}

#
# HTTPS Service for Ingress (map 443 to 30080)
#
resource "hcloud_certificate" "ssl_cert" {
  name = "SSL-Certificate"
  private_key = file("secrets/ssl.private")
  certificate = file("secrets/ssl.cert")
}

resource "hcloud_load_balancer_service" "load_balancer_service_443" {
    load_balancer_id = hcloud_load_balancer.load_balancer.id
    protocol = "https"
    listen_port = "443"
    destination_port = "30080"
    http {
      certificates = [ hcloud_certificate.ssl_cert.id ]
      redirect_http = true
    }
}

#
# Service for Kubernetes (loadbalance 6443 throughout all master nodes (have label "clusterentry"))
#
resource "hcloud_load_balancer_service" "load_balancer_service_6443" {
    load_balancer_id  = hcloud_load_balancer.load_balancer.id
    protocol          = "tcp"
    listen_port       = "6443"
    destination_port  = "6443"
}

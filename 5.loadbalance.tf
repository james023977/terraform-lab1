resource "google_compute_instance_group" "instance-group" {
  name    = var.vm_group_name
  zone    = var.zone
  network = google_compute_network.vpc.id
  #  subnetwork = google_compute_subnetwork.pub-sub.id

  instances = [
    google_compute_instance.vm.id,
  ]

  named_port {
    name = "www"
    port = 80
  }
}

# Frontend
resource "google_compute_global_address" "www_static_ip" {
  name = "www"
  #  purpose       = "PRIVATE_SERVICE_CONNECT"
  #  network       = google_compute_network.network.id
  address_type = "EXTERNAL"
}

resource "google_compute_managed_ssl_certificate" "default" {
  name = var.ssl

  managed {
    domains = ["www.cloud-ikeman.com."]
  }
}

resource "google_compute_target_http_proxy" "default" {
  name    = "test-proxy"
  url_map = google_compute_url_map.default.id
  #  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_url_map" "default" {
  name        = var.url_map_lb
  description = "a description"

  default_service = google_compute_backend_service.default.id

  host_rule {
    hosts        = ["sslcert.tf-test.club"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.default.id
    }
  }
}

resource "google_compute_backend_service" "default" {
  name        = var.backend
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [google_compute_http_health_check.default.id]
}

resource "google_compute_http_health_check" "default" {
  name               = "http-health-check"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = 80
}

#resource "google_compute_region_health_check" "default" {
#  depends_on = [google_compute_firewall.fw4]
#  provider = google-beta

#  region = "us-central1"
#  name   = "website-hc"
#  http_health_check {
#    port_specification = "USE_SERVING_PORT"
#  }
#}
#
#resource "google_compute_firewall" "fw1" {
##  provider = google-beta
#  name = "website-fw-1"
#  network = google_compute_network.default.id
#  source_ranges = ["10.1.2.0/24"]
#  allow {
#    protocol = "tcp"
#  }
#  allow {
#    protocol = "udp"
#  }
#  allow {
#    protocol = "icmp"
#  }
#  direction = "INGRESS"
#}
#
#resource "google_compute_firewall" "fw2" {
#  depends_on = [google_compute_firewall.fw1]
##  provider = google-beta
#  name = "website-fw-2"
#  network = google_compute_network.vpc.id
#  source_ranges = ["0.0.0.0/0"]
#  allow {
#    protocol = "tcp"
#    ports = ["22"]
#  }
#  target_tags = ["allow-ssh"]
#  direction = "INGRESS"
#}
#
#resource "google_compute_firewall" "fw3" {
#  depends_on = [google_compute_firewall.fw2]
##  provider = google-beta
#  name = "website-fw-3"
#  network = google_compute_network.vpc.id
#  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
#  allow {
#    protocol = "tcp"
#  }
#  target_tags = ["load-balanced-backend"]
#  direction = "INGRESS"
#}
#
#resource "google_compute_firewall" "fw4" {
#  depends_on = [google_compute_firewall.fw3]
##  provider = google-beta
#  name = "website-fw-4"
#  network = google_compute_network.default.id
#  source_ranges = ["10.129.0.0/26"]
#  target_tags = ["load-balanced-backend"]
#  allow {
#    protocol = "tcp"
#    ports = ["80"]
#  }
#  allow {
#    protocol = "tcp"
#    ports = ["443"]
#  }
#  allow {
#    protocol = "tcp"
#    ports = ["8000"]
#  }
#  direction = "INGRESS"
#}

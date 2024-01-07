resource "google_compute_network" "vpc" {
  project                 = var.project
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "pub-sub" {
  name                       = var.pub_sub_name
  ip_cidr_range              = var.ip_cidr_range
  network                    = google_compute_network.vpc.id
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  purpose                    = "PRIVATE"
  region                     = "asia-east1"
  stack_type                 = "IPV4_ONLY"
}
resource "google_compute_network_peering" "peering1" {
  name         = "peering1"
  network      = google_compute_network.vpc.self_link
  peer_network = google_compute_network.private_network.self_link
}

resource "google_compute_firewall" "allow-custom" {
  name    = "${var.vpc_name}-allow-custom"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
  direction     = "INGRESS"
  #  target_tags   = ["tag-allow-custom"]
  priority = 65534 # Adjust the priority based on your requirements
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.vpc_name}-allow-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  #  target_tags   = ["tag-fw-tcp22"]
  priority = 65534 # Adjust the priority based on your requirements
}

resource "google_compute_firewall" "allow-tcp80" {
  name    = var.fw_80_name
  network = google_compute_network.vpc.self_link # Adjust if using a custom network
  #  subnetwork = google_compute_subnetwork.chc103_private_sub01.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["target-for-firewall-tcp80"]
}

resource "google_compute_firewall" "allow-tcp8080" {
  name    = var.fw_8080_name
  network = google_compute_network.vpc.self_link # Adjust if using a custom network
  #  subnetwork = google_compute_subnetwork.chc103_private_sub01.id

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["target-for-firewall-tcp8080"]
}




resource "google_compute_router" "router" {
  name    = "regional-router"
  network = google_compute_network.vpc.self_link
  region  = var.region # Set your desired region

  # Enable dynamic routing
  #  dynamic_routing_mode = "REGIONAL"
}

resource "google_compute_address" "static-ip" {
  name   = "ip-demo"
  region = "asia-east1"
}


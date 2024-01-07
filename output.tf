output "vpc_id" {
  value = google_compute_network.vpc.id
}

#output "pub_sub_id" {
#  value = google_compute_subnetwork.pub-sub.id
#}

#output "subnet-2_id" {
#  value = google_compute_subnetwork.private_sub.id
#}

output "firewall_rules" {
  value = [google_compute_firewall.allow-tcp80.name, ]
}

output "router_id" {
  value = google_compute_router.router.id
}

#output "instance_ip" {
#  value = google_compute_instance.vm[0].access_config[0].nat_ip
#}


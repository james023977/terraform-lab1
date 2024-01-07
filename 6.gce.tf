resource "google_compute_instance" "vm" {
  name         = var.vm_name
  zone         = var.zone
  machine_type = "e2-micro"
  tags         = ["http-server", "https-server", "tag-fw-tcp80", "tag-fw-tcp22", "tag-fw-tcp8080"]
  #  tags = ["tag-fw-tcp80", "tag-fw-tcp22"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.pub-sub.id
    access_config {
      nat_ip = google_compute_address.static-ip.address
    }


    #    access_config {
    #      network_tier = "STANDARD"
    #    }
  }

  service_account {
    email  = "terraform-sa@terraform-lab1-408906.iam.gserviceaccount.com"
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  // Create a firewall rule to allow incoming HTTP traffic
  metadata = {
    foo = "bar"
  }

  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    sudo apt update
    sudo apt install nginx
    # Additional commands or configurations go here
  # Update package lists
  #sudo apt update
  #sudo apt upgrade -y

  # Install Docker
  #sudo apt install -y docker.io

  # Start and enable Docker
  #sudo systemctl start docker
  #sudo systemctl enable docker

  # Install Docker Compose
  #sudo curl -L "https://github.com/docker/compose/releases/download/latest/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  #sudo chmod +x /usr/local/bin/docker-compose

  # Set custom metadata
  #gcloud compute instances add-metadata $(hostname) --metadata KEY=VALUE

  #chmod +x startup-script.sh

  #gsutil cp startup-script.sh gs://chc103-demo01/

  #gcloud compute instances add-metadata vm-demo01 --metadata startup-script-url=gs://your-bucket/startup-script.sh

  #gcloud compute instances reset vm-demo01



    SCRIPT

  lifecycle {
    create_before_destroy = true
  }
}

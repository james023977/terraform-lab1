#resource "google_sql_database_instance" "db-instance" {
#  name             = "main-instance"
#  database_version = "MYSQL_8_0"
#  region           = var.region
#
#  settings {
#    # Second-generation instance tiers are based on the machine
#    # type. See argument reference below.
#    tier = "db-f1-micro"
#  }
#}

#resource "google_compute_network" "private-sub" {
#  #  provider = google-beta
#
#  name                       = "private"
#  ip_cidr_range              = "10.10.200.0/24"
#  network                    = google_compute_network.vpc.id
#  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
#  purpose                    = "PRIVATE"
#  region                     = "asia-east1"
#  stack_type                 = "IPV4_ONLY"
#}
#
#resource "google_compute_address" "static-private" {
#  #  provider = google-beta
#
#  name          = "private-ip-address"
#  purpose       = "VPC_PEERING"
#  address_type  = "INTERNAL"
#  prefix_length = 16
#  network       = google_compute_network.vpc.id
#}
#
#resource "google_service_networking_connection" "private-connect" {
#  #  provider = google-beta
#
#  network                 = google_compute_network.vpc.id
#  service                 = "servicenetworking.googleapis.com"
#  reserved_peering_ranges = [google_compute_address.static-private.name]
#}


resource "google_compute_network" "private_network" {
  #  provider = google-beta

  name = "private-network"
}

resource "google_compute_global_address" "private_ip_address" {
  #  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  #  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "db-instance" {
  #  provider = google-beta

  name                = "sql-demo-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = "MYSQL_8_0"
  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-custom-2-8192"
    ip_configuration {
      #      psc_config {
      #        psc_enabled               = true
      #        allowed_consumer_projects = ["allowed-consumer-project-name"]
      #      }
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.private_network.id
      enable_private_path_for_google_cloud_services = true
    }
    #    backup_configuration {
    #      enabled            = true
    #      binary_log_enabled = true
    #    }
    #      availability_type = "REGIONAL"
  }
}


resource "google_sql_user" "mysql_user" {
  name     = "google_sql_user"
  instance = google_sql_database_instance.db-instance.name
  password = "123456"
}

resource "google_sql_database" "mysql_db" {
  name     = "wordpress"
  instance = google_sql_database_instance.db-instance.name
}



#resource "google_sql_database_instance" "main" {
#  name             = "sql-demo"
#  database_version = "MYSQL_8_0"
#  settings {
#    tier    = "db-f1-micro"
#    ip_configuration {
#      psc_config {
#        psc_enabled = true
#        allowed_consumer_projects = ["allowed-consumer-project-name"]
#      }
#      ipv4_enabled = false
#    }
#    backup_configuration {
#      enabled = true
#      binary_log_enabled = true
#    }
#    availability_type = "REGIONAL"
#  }
#}



#resource "google_sql_database_instance" "db-instance" {
#  name             = var.db_name
#  database_version = "MYSQL_8_0"
#  region           = "asia-east1"
#  zone                = "asia-east1-a"
#  deletion_protection = false

#  settings {
#    tier = "db-n1-standard-1"

#    backup_configuration {
#      enabled = false
#    }
#    ip_configuration {
#      ipv4_enabled                                  = false
#      private_network                               = google_compute_network.chc103_vpc01.id
#      enable_private_path_for_google_cloud_services = true
#      require_ssl                                   = true
#      authorized_networks {
#        name = "default"
#      }
#    }
#  }
#  depends_on = [google_compute_instance.chc103_vm01]
#}


#resource "google_compute_global_address" "private_ip_address" {
#  provider = google-beta
#
#  name          = "private-ip-address"
#  purpose       = "VPC_PEERING"
#  address_type  = "INTERNAL"
#  prefix_length = 16
#  network       = google_compute_network.vpc.id
#}
#
#resource "google_service_networking_connection" "private_vpc_connection" {
#  network                 = google_compute_network.vpc.id
#  service                 = "servicenetworking.googleapis.com"
#  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
#}
#
#
#resource "google_sql_database_instance" "db-instance" {
#  provider = google-beta
#
#  name                = var.db_name
#  region              = var.region
#  database_version    = "MYSQL_8_0"
#  deletion_protection = false
#
#  depends_on = [google_service_networking_connection.private_vpc_connection]
#
#  settings {
#    #    tier = "db-f1-micro"	
#    tier = "db-n1-standard-1"
#    ip_configuration {
#      ipv4_enabled                                  = false
#      private_network                               = google_compute_network.vpc.id
#      enable_private_path_for_google_cloud_services = true
#    }
#  }
#}
#
#resource "google_sql_user" "mysql_user" {
#  name     = "username"
#  instance = google_sql_database_instance.db-instance.name
#  password = "abc123456"
#}
#
#resource "google_sql_database" "mysql_db" {
#  name     = "wordpress"
#  instance = google_sql_database_instance.db-instance.name
#}


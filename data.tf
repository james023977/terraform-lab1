# Declare the billing account data source
data "google_billing_account" "account" {
  billing_account = var.billing_account # Replace with your actual billing account ID
}

# Declare the project data source
data "google_project" "project" {
}

data "google_compute_default_service_account" "default" {
}

data "google_service_account_key" "mykey" {
  name            = google_service_account_key.mykey.name
  public_key_type = "TYPE_X509_PEM_FILE"
}

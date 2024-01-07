resource "google_service_account" "sa" {
  account_id   = var.sa_id
  display_name = var.sa_name
}

#resource "google_service_account_iam_member" "admin-account-iam" {
##  project = var.project
#  service_account_id = google_service_account.sa.name
#  role               = "roles/editor"
#  member             = var.user_email
#}
#import {
#  id = "projects/terraform-lab1-408906/serviceAccounts/demo-server@terraform-lab1-408906.iam.gserviceaccount.com  roles/editor user:james023977@gmail.com"
#  to = google_service_account_iam_member.admin-account-iam
#}
#
### Allow SA service account use the default GCE account
#resource "google_service_account_iam_member" "gce-default-account-iam" {
#  service_account_id = data.google_compute_default_service_account.default.name
#  role               = "roles/editor"
#  member             = "serviceAccount:${google_service_account.sa.email}"
#}

resource "google_project_iam_binding" "admin-account-iam" {
  #  service_account_id = data.google_compute_default_service_account.sa.name
  project = var.project
  role    = var.sa_role

  members = [
    var.user_email, "serviceAccount:${google_service_account.sa.email}"
  ]
}

#import {
#  id = "projects/{{project_id}}/serviceAccounts/{{service_account_email}} roles/editor"
#  to = google_service_account_iam_binding.admin-account-iam
#}


resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

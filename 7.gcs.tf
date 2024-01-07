resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket" "bucket" {
  name                        = "chc103-demo-${random_id.unique_suffix.hex}"
  location                    = var.location
  force_destroy               = true
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
  uniform_bucket_level_access = false
}



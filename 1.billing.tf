
resource "google_billing_budget" "budget" {
  billing_account = data.google_billing_account.account.id
  display_name    = "Example Billing Budget"
  amount {
    specified_amount {
      currency_code = "TWD"
      units         = "100"
    }
  }
  threshold_rules {
    threshold_percent = 0.5
  }
}

# Create the billing budget resource
#resource "google_billing_budget" "budget" {
#  billing_account = data.google_billing_account.account.id
#  display_name    = var.budget_name # Set the desired budget name
#
#  # Specify the projects for the budget filter
#  budget_filter {
#    projects = ["projects/${data.google_project.project.number}"]
#  }
#
#  # Set the budget amount
#  amount {
#    specified_amount {
#      currency_code = "TWD"
#      units         = var.budget_amount # Set the target amount
#    }
#  }
#
#  # Define threshold rules
#  threshold_rules {
#    threshold_percent = 0.5
#  }
#  #  threshold_rules {
#  #    threshold_percent = 1.0
#  #    spend_basis       = "FORECASTED_SPEND"
#  #  }
#
#  # Configure the notification channel for alerts
#  all_updates_rule {
#    monitoring_notification_channels = [
#      google_monitoring_notification_channel.notification_channel.id,
#    ]
#    disable_default_iam_recipients = true
#  }
#}
#
## Create the monitoring notification channel resource
#resource "google_monitoring_notification_channel" "notification_channel" {
#  display_name = "Example Notification Channel"
#  type         = "email"
#
#  # Set the email address for billing alerts
#  labels = {
#    email_address = "james023977@gmail.com" # Replace with the desired email address
#  }
#}


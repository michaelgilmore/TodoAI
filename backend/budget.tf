resource "aws_budgets_budget" "todo-cost-limits" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "50.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2023-04-05_20:00"

  notification {
    comparison_operator = "GREATER_THAN"
    threshold = 100
    threshold_type = "PERCENTAGE"
    notification_type = "FORECASTED"
    subscriber_email_addresses = ["todo@gilmore.cc"]
  }
}

resource "aws_sns_topic" "alteryx_sandbox" {
  name = "alteryx-sandbox"
}

resource "aws_sns_topic_subscription" "alteryx_sandbox_Subscription" {
  topic_arn = aws_sns_topic.alteryx_sandbox.arn
  for_each  = toset([local.sns_email])
  protocol  = "email"
  endpoint  = each.value

  depends_on = [
    aws_sns_topic.alteryx_sandbox
  ]
}

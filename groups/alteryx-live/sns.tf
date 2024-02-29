resource "aws_sns_topic" "alteryx_live" {
  name = "alteryx-live"
}

resource "aws_sns_topic_subscription" "alteryx_live_Subscription" {
  topic_arn = aws_sns_topic.alteryx_live.arn
  for_each  = toset([local.sns_email])
  protocol  = "email"
  endpoint  = each.value

  depends_on = [
    aws_sns_topic.alteryx_live
  ]
}

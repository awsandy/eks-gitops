resource "aws_route53_zone" "demo" {
  name = format("%s.%s",random_string.random.id,"demo.awsandy.people.aws.dev")
  #tags = {
  #  Environment = "dev"
  #}
}


resource "random_string" "random" {
  length           = 16
  special          = false
  lower = true
  upper = false
}






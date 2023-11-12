check:
acc=$(aws sts get-caller-identity --query Account --output text)
dig $acc.awsandy.people.aws.dev NS +short
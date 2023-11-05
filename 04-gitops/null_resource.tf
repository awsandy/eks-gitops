resource "null_resource" "flux-install" {
  triggers = {
    always_run = timestamp()
  }
  depends_on=[null_resource.sleep]
  provisioner "local-exec" {
    on_failure  = fail
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        ./flux-bootstrap.sh ${aws_iam_user_ssh_key.gitops.id} ${data.aws_ssm_parameter.cluster1_name.insecure_value}
        flux check
     EOT
  }
}

resource "null_resource" "flux-uninstall" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    on_failure  = fail
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        flux uninstall -s
     EOT
  }
}

resource "null_resource" "sleep" {
  triggers = {
    always_run = timestamp()
  }
  depends_on=[local_file.ssh_private_key,aws_codecommit_repository.gitops]
  provisioner "local-exec" {
    on_failure  = fail
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        sleep 30
     EOT
  }
}
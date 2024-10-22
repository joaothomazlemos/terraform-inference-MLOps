data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "auth" {}

locals {
  repository_url  = module.private_ecr.repository_url # created on the aws_ecr_repository resource on this module, passed by the ecr component
  repository_name = module.private_ecr.repository_name
  image_tag       = var.ecr_image_tag
  image_files     = fileset("${var.image_source}", "**") # this will get all the files inside the image_source directory. even if it is a subdirectory.
  image_hashes    = [for file in local.image_files : filesha1("${var.image_source}/${file}")]
  combined_hash   = sha1(join("", local.image_hashes))

}

#var environment = could be prod or dev
#var image_source = the source of the image that is specified on the input of the hcl file.

resource "null_resource" "build_and_push_lambda" {
  provisioner "local-exec" {
    command = <<EOF
        aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.repository_url}
        docker build --platform linux/amd64 -t ${local.repository_url}:${local.image_tag} ${var.image_source}
        docker push ${local.repository_url}:${var.ecr_image_tag}
    EOF
  }


  # Add a trigger so that this resource is executed whenever any file under the image source directory changes
  triggers = {
    # Triggers if any file under the image source directory changes ( like a code inside a .py file)
    image_source_sha1 = local.combined_hash
    image_source      = var.image_source
    environment       = local.image_tag
  }
}

data "aws_ecr_image" "latest_image" {
  repository_name = local.repository_name
  image_tag       = local.image_tag

  depends_on = [null_resource.build_and_push_lambda]
}

output "image_files" {
  value = local.image_files

}

output "image_source" {
  value = var.image_source

}

output "working_directory" {
  value = path.cwd

}
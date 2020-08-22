provider "cloudinit" {}

data "template_file" "init_script" {
  template = file(var.CLOUDINIT_SCRIPT)
}

data "template_file" "helloworld_http_server_script" {
  template = file(var.INITIAL_SCRIPT)
}

data "template_cloudinit_config" "cloudinit" {
  gzip = false
  base64_encode = false

  # part {
  #   filename = "init.cfg"
  #   content_type = "text/cloud-config"
  #   content = "data.template_file.init_script.rendered"
  # }

  part {
    content_type = "text/x-shellscript"
    content = "data.template_file.helloworld_http_server_script.rendered"
  }
}

# output "init_script" {
#   value = data.template_file.init_script.rendered
# }

# output "cloudinit" {
#   value = data.template_cloudinit_config.cloudinit.rendered
# }

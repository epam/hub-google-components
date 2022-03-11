data "google_service_account" "vm" {
  account_id = var.service_account
}

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 7.4.0"

  name_prefix = var.hostname_prefix
  subnetwork  = var.subnetwork
  service_account = {
    email  = data.google_service_account.vm.email
    scopes = ["cloud-platform"]
  }
  disk_type            = var.disk_type
  machine_type         = var.machine_type
  region               = var.region
  source_image         = var.image
  source_image_project = var.image_project
  tags = compact([
    var.hostname_prefix,
    var.nat_router_name,
  ])
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 7.4.0"

  project_id        = var.project
  region            = var.region
  target_size       = var.target_size
  hostname          = var.hostname_prefix
  instance_template = module.instance_template.self_link
  subnetwork        = var.subnetwork
  named_ports = [{
    name = "http",
    port = var.port
  }]
}

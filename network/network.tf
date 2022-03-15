module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0.0"

  project_id              = var.project
  network_name            = var.name
  auto_create_subnetworks = var.autocreate_subnets

  subnets = var.autocreate_subnets ? [] : [{
    subnet_name              = var.name
    subnet_ip                = var.cidr
    subnet_region            = var.region
    subnet_private_access    = "true"
  }]

  firewall_rules = [
    {
      name        = "${var.name}-allow-ssh"
      direction   = "INGRESS"
      description = "Allow ssh connection"
      # The Identity Aware Proxy CIDR for TCP forwarding and tunnel SSH through IAP
      # Via Cloud Console vM instance ssh button or
      # Cloud Shell: gcloud compute ssh NAME_OF_VM_INSTANCE --tunnel-through-iap
      ranges = ["35.235.240.0/20"]
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}

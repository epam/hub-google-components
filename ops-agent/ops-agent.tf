
data "google_compute_zones" "available" {
  region = var.region
}

module "agent_policy" {
  source     = "terraform-google-modules/cloud-operations/google//modules/agent-policy"
  version    = "~> 0.2.3"

  project_id = var.project
  # This ID must start with ops-agents-, contain only lowercase letters, numbers, and hyphens, end with a number or a letter, be between 1-63 characters, and be unique within the project.
  policy_id  = "ops-agents-policy-${var.hostname_prefix}"
  agent_rules = [
    {
      type               = "logging"
      version            = "current-major"
      package_state      = "installed"
      enable_autoupgrade = true
    },
    {
      type               = "metrics"
      version            = "current-major"
      package_state      = "installed"
      enable_autoupgrade = true
    },
  ]
  zones = data.google_compute_zones.available.names
  group_labels = [
    {
      hostname = var.hostname_prefix
    }
  ]
  os_types = [
    {
      short_name = var.os_name
      version    = var.os_version
    },
  ]
}

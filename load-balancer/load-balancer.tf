module "load_balancer" {
  source  = "GoogleCloudPlatform/lb-http/google"
  version = "~> 6.2.0"

  project           = var.project
  name              = var.name
  target_tags       = [var.name]
  firewall_networks = [var.network]

  ssl                             = true
  use_ssl_certificates            = var.ssl_certificate != ""
  ssl_certificates                = [var.ssl_certificate]
  managed_ssl_certificate_domains = var.ssl_certificate != "" ? [] : [var.domain_name]

  https_redirect = true
  create_address = true

  backends = {
    default = {
      description                     = null
      protocol                        = "HTTP"
      port                            = 80
      port_name                       = "http"
      timeout_sec                     = 10
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      affinity_cookie_ttl_sec         = null
      security_policy                 = null
      session_affinity                = null
      connection_draining_timeout_sec = null

      health_check = {
        check_interval_sec  = null
        healthy_threshold   = null
        unhealthy_threshold = null
        host                = null
        logging             = null
        timeout_sec         = null
        # FIXME: request pass in case of Wordpress. Due to 301|302 responce codes leads to unhealthy status
        request_path = "/readme.html"
        port         = 80
      }

      log_config = {
        enable      = false
        sample_rate = null
      }

      groups = [
        {
          group                        = var.instance_group
          balancing_mode               = null
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}

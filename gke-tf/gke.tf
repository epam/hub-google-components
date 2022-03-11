
resource "google_container_cluster" "primary" {
  name     = var.name
  location = var.location
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.name}-default"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count
  
  node_config {
    preemptible  = true
    machine_type = var.machine_type
  }
}


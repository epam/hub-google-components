output "subnetwork" {
    value = module.vpc.subnets_self_links[0]
}

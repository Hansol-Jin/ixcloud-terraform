provider "openstack" {
  alias = "cluster"
  auth_url = "https://orrc.ixcloud.net:5000/v3"
  user_name = "jhs313@kinx.net"
  password = "Zmffkdnem123!"
  tenant_id = "278a4630247442af8c5fb2d473bf4942"
  user_domain_name = "Default"
  region      = "RegionOne"
}

module "cluster" {
  source = "./resource"
  providers = {
    openstack = openstack.cluster
  }
  key = "os_dev"
  net = var.net
  subnet = var.subnet
  vm1 = var.vm1
  vm2 = var.vm2
  vip = var.vip
  zone_name = var.zone_name
  tenant_ids = var.tenant_ids
}

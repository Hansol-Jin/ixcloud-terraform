resource "openstack_networking_network_v2" "network" {
  name = var.net
}
resource "openstack_networking_subnet_v2" "subnet" {
  name      = var.subnet
  network_id = openstack_networking_network_v2.network.id
  dns_nameservers = [
           "8.8.8.8",
           "8.8.4.4",
        ]
}

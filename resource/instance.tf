data "openstack_images_image_v2" "ubuntu_2004" {
  name = "Ubuntu_20.04-x86_64"
}

resource "openstack_compute_instance_v2" "haproxy_1" {
  availability_zone = "nova"
  name        = "private-haproxy-01"
  flavor_name = "2Core2GB"
  key_pair    = var.key

  block_device {
    uuid	= data.openstack_images_image_v2.ubuntu_2004.id
    source_type	= "image"
    volume_size	= 50
    boot_index	= 0
    destination_type      = "volume"
    delete_on_termination = true
  }
  network {
    port           = openstack_networking_port_v2.haproxy_1.id
  }
}

# Create network port
resource "openstack_networking_port_v2" "haproxy_1" {
  network_id     = openstack_networking_network_v2.network.id
  admin_state_up = true
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet.id
    ip_address = cidrhost(openstack_networking_subnet_v2.subnet.cidr,var.vm1)
  }
  allowed_address_pairs {
    ip_address = cidrhost(openstack_networking_subnet_v2.subnet.cidr,var.vip)
  }
}

resource "openstack_compute_instance_v2" "haproxy_2" {
  availability_zone = "nova"
  name        = "private-haproxy-02"
  flavor_name = "2Core2GB"
  key_pair    = var.key

  block_device {
    uuid	= data.openstack_images_image_v2.ubuntu_2004.id
    source_type	= "image"
    volume_size	= 50
    boot_index	= 0
    destination_type      = "volume"
    delete_on_termination = true
  }
  network {
    port           = openstack_networking_port_v2.haproxy_2.id
  }
}

# Create network port
resource "openstack_networking_port_v2" "haproxy_2" {
  network_id     = openstack_networking_network_v2.network.id
  admin_state_up = true
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet.id
    ip_address = cidrhost(openstack_networking_subnet_v2.subnet.cidr,var.vm2)
  }
  allowed_address_pairs {
    ip_address = cidrhost(openstack_networking_subnet_v2.subnet.cidr,var.vip)
  }
}

resource "openstack_networking_port_v2" "haproxy_vip" {
  network_id     = openstack_networking_network_v2.network.id
  admin_state_up = true
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet.id
    ip_address = cidrhost(openstack_networking_subnet_v2.subnet.cidr,var.vip)
  }
}

#!/bin/sh
echo "Enter the Tenant network name :" 
read netname
echo ""
echo "Enter the Tenant network ID  :"
read netid
echo ""


echo "Enthr the Tenant subnet name :"
read subnetname
echo ""
echo "Enthr the Tenant subnet ID :"
read subnetid
echo ""

echo "Enter VM1 4th octet number :"
echo "ex)192.168.10.XX "
read vm1
echo ""

echo "Enter VM2 4th octet number :"
read vm2
echo ""

echo "Enter VIP 4th octet number :"
read vip
echo ""

terraform import -var net="$netname" -var subnet="$subnetname" -var vm1='' -var vm2='' -var vip='' module.cluster.openstack_networking_network_v2.network $netid
terraform import -var net="$netname" -var subnet="$subnetname" -var vm1='' -var vm2='' -var vip='' module.cluster.openstack_networking_subnet_v2.subnet $subnetid

terraform apply -var net="$netname" -var subnet="$subnetname" -var vm1=$vm1 -var vm2=$vm2 -var vip=$vip

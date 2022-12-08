# terraform-iks
Terraform으로 Openstack 프로젝트내에 k8s provisioner와 노드 생성  

### HAproxy에 등록된 IP에서만 가능  
구성할 존의 haproxy iptables에 terraform host등록  

### terraform 설치
```
# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
# apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# apt install terraform`
```

## 구성 방법
`git clone https://[github_token]@github.com/kinxnet/terraform-iks.git`  

### env파일 및 key 생성  
`openrc`
```
## openstack openrc settings ##
export USER_GITHUB_TOKEN="<GITHUB_TOKEN>"
export ANSIBLE_VAULT_KEY="<VAULT_KEY>"
export IX_ENDPOINT_DOMAIN="dgrp1.kinxcloud.net"
export OS_AUTH_URL=${K8S_AUTH_URL:-"https://${IX_ENDPOINT_DOMAIN}:5000/v3"}
export OS_NETWORK_URL=${K8S_NETWORK_URL:-"https://${IX_ENDPOINT_DOMAIN}:9696/v2.0"}
export HOME="/root"
export IXK8S_RC_FILE=$IXK8S_RC_FILE
export IXK8S_INVENTORY_PATH="/root/ixInventory"
export KUBESPRAY_PATH="/root/kubespray"
export IXDEVOPS_PATH="/root/ixdevops"
export OS_USERNAME=<user_id>
export OS_PASSWORD=<user_password>
export OS_TENANT_NAME=<project_name>
export OS_TENANT_ID=<project_id>
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_REGION_NAME=RegionOne
export OS_IDENTITY_API_VERSION=3
if [ -s `curl -s http://169.254.169.254/latest/meta-data/hostname` ]
then
export TF_VAR_remote_host="211.196.205.71/32"
else
export TF_VAR_remote_host="`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`/32"
fi
```

**private key file 생성**  
`vi ./key/os_dev.pem`  
`chmod 400 ./key/os_dev.pem`  

### Provider 설정

`main.tf`
```
module "k8s" {
  source = "./resource"
  key = "os_dev"
  client_name = "<Prefix_name>"
}
```

### Terraform  
terraform 초기화  
`terraform init`

Terraform 노드 배포  
`terraform apply -var 'cluster_state=0'`
생성되는 리소스 확인 후 `yes`

### cluster 설치 이후  
워커노드 및 vpn노드에 iks-mgmt 인터페이스 attach  
`terraform apply -var 'cluster_state=1'`
Outputs에 나온 commnad `terraform import openstack_networking_port_v2.vpn_iks <UUID>` 복사

### vpn노드의 iks인터페이스 allowed address pair설정  
`cd add-ips`  
`terraform init`  
`terraform import openstack_networking_port_v2.vpn_iks <UUID>`  
`terrafrom apply`  

# ixcloud-terraform

# ixcloud-terraform
Terraform으로 Openstack 컨트롤

### `main.tf` 파일 수정 
| Parameter | values | description |
|---|---|---|
| **provider.openstack.cluster** |   |   |
| auth_url | `https://pcrc.ixcloud.net:5000/v3` | os auth endpoint |
| user_name | `cloudop@kinx.net` | 구성할 계정 |
| password | `<USER PASSWORD>` | 구성할 계정 패스워드 |
| tenant_id | `<TENANT ID>` | 구성할 테넌트 ID |

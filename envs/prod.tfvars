env = "prod"
region = "us-west-2"
vpc_name = "project_vpc"
vpc_subnet = "172.29.32.0/19"
private_subnets = ["172.29.32.0/21","172.29.40.0/21"]
public_subnets = ["172.29.48.0/21","172.29.56.0/21"]
enable_natgateway = true
enable_vpngateway = false
count_eip_nat = 1
owner_tag = "Project DevOps Team"
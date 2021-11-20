# ============== Terraform Configuration =============#
terraform {
    required_providers {
        aws = {
           source  = "registry.terraform.io/hashicorp/aws"
           version = "~> 3.64.2"
          }
       }
   }

# ============= AWS configuration =====================#

provider "aws" {
  profile     = var.aws_profile
  region      = var.aws_region
  }


# ==================== Modules ========================#

#EC2 key Pair
module "EC2_key_pair" {
source = "./modules/EC2_key_pair"
}

module "SSH_SG" {
  source                   = "terraform-aws-modules/security-group/aws//modules/ssh"
  name                     = "SSH-SG-terraform-demo"
  description              = "SSH-SG-terraform-demo"
  vpc_id                   = module.vpc-networking.vpc.vpc_id
  ingress_cidr_blocks      = ["IP1/32","IP2/32"]
  use_name_prefix          = false
  auto_ingress_with_self   = []
}

#nginx Instances
resource "aws_instance" "terraform-nginx" {
  ami                         = var.ami
  instance_type               = var.instance_type
  count                       = length(var.file_list)
  subnet_id                   = module.vpc-networking.vpc.private_subnets[0]
  key_name                    = "terraform-demo"
  vpc_security_group_ids      = [module.SSH_SG.security_group_id]
  provisioner "remote-exec" {
    inline = [
      "sudo touch /root/${element(var.file_list, count.index)}",
      "sudo apt update -y && sudo apt install -y nginx",
    ]

    connection {
    host        = self.private_ip
    agent       = false
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/terraform-demo.pem")
  }
}
tags = {
    "Name" = "terraform-nginx-${count.index+1}"
  }
}


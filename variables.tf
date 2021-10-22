#################
# Security group
#################
variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "create_sg" {
  description = "Whether to create security group"
  type        = bool
  default     = true
}

variable "security_group_id" {
  description = "ID of existing security group whose rules we will manage"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "name" {
  description = "Name of security group - not required if create_group is false"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_with_self" {
  description = "List of ingress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_ipv6_cidr_blocks" {
  description = "List of ingress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all ingress rules"
  type        = list(string)
  default     = []
}

variable "ingress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all ingress rules"
  type        = list(string)
  default     = []
}

########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_self" {
  description = "List of egress rules to create where 'self' is defined"
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_ipv6_cidr_blocks" {
  description = "List of egress rules to create where 'ipv6_cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "List of IPv6 CIDR ranges to use on all egress rules"
  type        = list(string)
  default     = ["::/0"]
}

variable "egress_prefix_list_ids" {
  description = "List of prefix list IDs (for allowing access to VPC endpoints) to use on all egress rules"
  type        = list(string)
  default     = []
}


#rules
variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers (from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml):
  # All = -1, IPV4-ICMP = 1, TCP = 6, UDP = 17, IPV6-ICMP = 58
  default = {
    rdp-tcp = [3389, 3389, "tcp", "Remote Desktop"]
    rdp-udp = [3389, 3389, "udp", "Remote Desktop"]
    all-all       = [-1, -1, "-1", "All protocols"]  #engress for SG
    custom-161-udp = [161, 161, "udp", "custom-161-udp"]
    custom-162-udp = [162, 162, "udp", "custom-162-udp"]
    custom-5721-tcp = [5721, 5721, "tcp", "custom-5721-tcp"]
    custom-8081-tcp = [8081, 8081, "tcp", "custom-8081-tcp"]
    custom-8888-tcp = [8888, 8888, "tcp", "custom-8888-tcp"]
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    https-443-tcp  = [443, 443, "tcp", "HTTPS"]

    all-tcp       = [-1, -1, "tcp", "all tcp"]
    all-udp       = [-1, -1, "udp", "all udp"]
  }
}
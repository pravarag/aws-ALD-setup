# --------------------------
# Required Params
# You must provider a value for each of these params
# --------------------------


variable "region" {
  default = "us-east-1"
}

variable "availabilityZone" {
  default = "us-east-1a"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}

variable "subnetPublicCIDRblock" {
  default = "10.0.0.0/24"
}

variable "subnetPrivateCIDRblock" {
    default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = true
}

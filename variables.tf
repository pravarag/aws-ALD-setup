# --------------------------
# Required Params
# You must provider a value for each of these params
# --------------------------


variable "public_subnet_id" {
  description = "The public subnet id under aws-ALD-vpc"
  type = string
}

variable "vpc_id" {
  description = "The vpc id of the default vpc"
  type = string
}

variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-2 = "ami-0430580de6244e02e"
    us-east-1 = "ami-0261755bbcb8c4a84"
  }
}

variable "instance_count" {
  default = 1 # Specify the desired number of instances
}

variable "USER" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "192.168.100.21"
}
variable "aws_region" {
  default     = "us-east-1"
  description = "aws region where our resources going to create choose"
  #replace the region as suits for your requirement
}
variable "aws_ami" {
  default     = "ami-0b0af3577fe5e3532"
  description = "aws linux ami"
}

variable "az1" {
  default     = "us-east-1a"
  description = "aws linux ami"
}

variable "az2" {
  default     = "us-east-1b"
  description = "aws linux ami"
}

variable "istance_type" {
  default     = "t2.micro"
  description = "aws istance type"
}

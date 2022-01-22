variable "aws_region" {
  default     = "ap-south-1"
  description = "aws region where our resources going to create choose"
  #replace the region as suits for your requirement
}
variable "aws_ami" {
  default     = "ami-0af25d0df86db00c1"
  description = "aws linux ami"
}

variable "az1" {
  default     = "ap-south-1a"
  description = "aws linux ami"
}
variable "az2" {
  default     = "ap-south-1b"
  description = "aws linux ami"
}

variable "istance_type" {
  default     = "t2.micro"
  description = "aws istance type"
}
provider "aws" {

}

variable "AWS_REGION" {
	type = string
}

variable "AMIS" {
	type = map(string) 
	default = {
		eu-central-1 = "my ami"
	}
}

resource "aws_instance" "example1" {
	ami	= var.AMIS[var.AWS_REGION]
	instance_type = "t2.micro"
}

resource "aws_instance" "example2" {
	ami	= var.AMIS[var.AWS_REGION]
	instance_type = "t2.micro"
}

resource "aws_instance" "example3" {
	ami	= var.AMIS[var.AWS_REGION]
	instance_type = "t2.micro"
}

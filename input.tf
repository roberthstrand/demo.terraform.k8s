variable "name" {
	default = "demo-terraform-k8s"
}
variable "location" {
	default = "West Europe"
}
variable tags {
	default = {
		environment = "demo"
		source      = "terraform"
	}
}
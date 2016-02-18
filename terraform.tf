provider "azure" {
  publish_settings = "${file("/var/lib/jenkins/credentials.publishsettings")}"
}

resource "azure_hosted_service" "default" {
    name = "${var.hosted_service_name}"
    location = "${var.location}"
    ephemeral_contents = false
}

resource "azure_instance" "default" {
  hosted_service_name = "${azure_hosted_service.default.name}"
  storage_service_name = "${var.storage_service_name}"
  name = "${var.instance_name}"
  image = "${var.image}"
  size = "${var.size}"
  location = "${var.location}"
  virtual_network = "${var.virtual_network_name}"
  subnet = "${var.subnet}"
  username = "${var.username}"
  password = "${var.password}"

  endpoint {
    name = "SSH"
    protocol = "tcp"
    public_port = 22
    private_port = 22
  }

}

variable location {}
variable hosted_service_name {}
variable instance_name {}
variable image {}
variable size {}
variable username {}
variable password {}
variable storage_service_name {}
variable virtual_network_name {}
variable subnet {}

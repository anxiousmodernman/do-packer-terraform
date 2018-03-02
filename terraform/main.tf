# Variable declarations
variable "do_token" {}
variable "centos_base_image_id" {}

# Tell Terraform to use DO's API
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a droplet, node1
resource "digitalocean_droplet" "node1" {
    # name is what shows up in DO console
    name = "node1"
    region = "sfo2"
    image = "${var.centos_base_image_id}"
    size = "512mb"
}

# node1's floating IP
resource "digitalocean_floating_ip" "node1_fip" {
  droplet_id = "${digitalocean_droplet.node1.id}"
  region     = "${digitalocean_droplet.node1.region}"
}

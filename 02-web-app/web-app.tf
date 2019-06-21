variable "do_token" {}
variable "ssh_pub_key_path" {}
variable "ssh_prv_key_path" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "default" {
  name        = "Default SSH key"
  public_key  = "${file(var.ssh_pub_key_path)}"
} 

resource "digitalocean_droplet" "web" {
  image       = "ubuntu-18-04-x64"
  name        = "web-app"
  region      = "fra1"
  size        = "s-1vcpu-1gb"
  ssh_keys    = ["${digitalocean_ssh_key.default.fingerprint}"]
  depends_on  = ["digitalocean_ssh_key.default"]
  
  provisioner "remote-exec" {
    script  = "provision.sh"

    connection {
      type        = "ssh"
      host        = "${digitalocean_droplet.web.ipv4_address}"
      user        = "root"
      private_key = "${file(var.ssh_prv_key_path)}"
    }
  }
}
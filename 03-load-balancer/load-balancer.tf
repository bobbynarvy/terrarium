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

resource "digitalocean_droplet" "lb-back" {
  image       = "ubuntu-18-04-x64"
  name        = "backend-app"
  region      = "fra1"
  size        = "s-1vcpu-1gb"
  ssh_keys    = ["${digitalocean_ssh_key.default.fingerprint}"]
  depends_on  = ["digitalocean_ssh_key.default"] 
  count       = 5 

  provisioner "remote-exec" {
    script  = "provision.sh"

    connection {
      type        = "ssh"
      host        = "${self.ipv4_address}"
      user        = "root"
      private_key = "${file(var.ssh_prv_key_path)}"
    }
  }
}

resource "digitalocean_loadbalancer" "load-balancer" {
  name        = "terrarium-lb"
  region      = "fra1"

  forwarding_rule {
    entry_protocol  = "http"
    entry_port      = 80

    target_protocol = "http"
    target_port     = 80
  }

  droplet_ids = "${digitalocean_droplet.lb-back[*].id}"
}

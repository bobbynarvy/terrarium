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

resource "digitalocean_droplet" "db" {
  image       = "ubuntu-18-04-x64"
  name        = "mongo-db-server"
  region      = "fra1"
  size        = "s-1vcpu-1gb"
  ssh_keys    = ["${digitalocean_ssh_key.default.fingerprint}"]
  depends_on  = ["digitalocean_ssh_key.default"] 
  count       = 3 

  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt install -y mongodb"
    ]

    connection {
      type        = "ssh"
      host        = "${self.ipv4_address}"
      user        = "root"
      private_key = "${file(var.ssh_prv_key_path)}"
    }
  }

  # store ip address in a file that can be will be used by
  # the client to form a db cluster
  provisioner "local-exec" {
    command = "echo ${self.ipv4_address} >> db_ips.txt" 
  }
}
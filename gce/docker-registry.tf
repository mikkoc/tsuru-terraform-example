/* Docker Registry */
resource "google_compute_instance" "docker-registry" {
  name = "docker-registry"
  machine_type = "n1-standard-1"
  zone = "${var.gce_zone}"
  disk {
    image = "${var.os_image}"
  }
  network_interface {
    network = "${google_compute_network.network1.name}"
  }
  metadata {
    sshKeys = "${var.user}:${file(\"${var.ssh_key_path}")}"
  }
  service_account {
    scopes = [ "compute-ro", "storage-ro", "userinfo-email" ]
  }
  depends_on = [ "google_compute_network.network1" ]
  tags = [ "private" ]
}

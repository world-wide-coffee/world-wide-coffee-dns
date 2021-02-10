resource "google_dns_managed_zone" "root" {
  name     = "world-wide-coffee"
  dns_name = "world-wide.coffee."

  dnssec_config {
    kind          = "dns#managedZoneDnsSecConfig"
    non_existence = "nsec3"
    state         = "on"

    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 2048
      key_type   = "keySigning"
      kind       = "dns#dnsKeySpec"
    }
    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 1024
      key_type   = "zoneSigning"
      kind       = "dns#dnsKeySpec"
    }
  }
}

resource "google_dns_record_set" "developer" {
  name = "developer.${google_dns_managed_zone.root.dns_name}"
  type = "TXT"
  ttl  = 300

  managed_zone = google_dns_managed_zone.root.name

  rrdatas = ["test"]
}

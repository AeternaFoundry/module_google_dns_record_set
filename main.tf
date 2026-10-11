resource "google_dns_record_set" "dns_record_sets" {
  for_each = var.dns_record_sets

  managed_zone    = each.value.managed_zone
  name            = each.value.name
  type            = each.value.type
  deletion_policy = each.value.deletion_policy
  project         = each.value.project
  rrdatas         = each.value.rrdatas
  ttl             = each.value.ttl

  dynamic "routing_policy" {
    for_each = each.value.routing_policy != null ? [each.value.routing_policy] : []
    content {
      enable_geo_fencing = routing_policy.value.enable_geo_fencing
      dynamic "geo" {
        for_each = routing_policy.value.geo != null ? routing_policy.value.geo : []
        content {
          dynamic "health_checked_targets" {
            for_each = geo.value.health_checked_targets != null ? [geo.value.health_checked_targets] : []
            content {
              external_endpoints = health_checked_targets.value.external_endpoints
              dynamic "internal_load_balancers" {
                for_each = health_checked_targets.value.internal_load_balancers != null ? health_checked_targets.value.internal_load_balancers : []
                content {
                  ip_address         = internal_load_balancers.value.ip_address
                  ip_protocol        = internal_load_balancers.value.ip_protocol
                  load_balancer_type = internal_load_balancers.value.load_balancer_type
                  network_url        = internal_load_balancers.value.network_url
                  port               = internal_load_balancers.value.port
                  project            = internal_load_balancers.value.project
                  region             = internal_load_balancers.value.region
                }
              }
            }
          }
          location = geo.value.location
          rrdatas  = geo.value.rrdatas
        }
      }
      health_check = routing_policy.value.health_check
      dynamic "primary_backup" {
        for_each = routing_policy.value.primary_backup != null ? [routing_policy.value.primary_backup] : []
        content {
          dynamic "backup_geo" {
            for_each = primary_backup.value.backup_geo
            content {
              dynamic "health_checked_targets" {
                for_each = backup_geo.value.health_checked_targets != null ? [backup_geo.value.health_checked_targets] : []
                content {
                  external_endpoints = health_checked_targets.value.external_endpoints
                  dynamic "internal_load_balancers" {
                    for_each = health_checked_targets.value.internal_load_balancers != null ? health_checked_targets.value.internal_load_balancers : []
                    content {
                      ip_address         = internal_load_balancers.value.ip_address
                      ip_protocol        = internal_load_balancers.value.ip_protocol
                      load_balancer_type = internal_load_balancers.value.load_balancer_type
                      network_url        = internal_load_balancers.value.network_url
                      port               = internal_load_balancers.value.port
                      project            = internal_load_balancers.value.project
                      region             = internal_load_balancers.value.region
                    }
                  }
                }
              }
              location = backup_geo.value.location
              rrdatas  = backup_geo.value.rrdatas
            }
          }
          enable_geo_fencing_for_backups = primary_backup.value.enable_geo_fencing_for_backups
          primary {
            external_endpoints = primary_backup.value.primary.external_endpoints
            dynamic "internal_load_balancers" {
              for_each = primary_backup.value.primary.internal_load_balancers != null ? primary_backup.value.primary.internal_load_balancers : []
              content {
                ip_address         = internal_load_balancers.value.ip_address
                ip_protocol        = internal_load_balancers.value.ip_protocol
                load_balancer_type = internal_load_balancers.value.load_balancer_type
                network_url        = internal_load_balancers.value.network_url
                port               = internal_load_balancers.value.port
                project            = internal_load_balancers.value.project
                region             = internal_load_balancers.value.region
              }
            }
          }
          trickle_ratio = primary_backup.value.trickle_ratio
        }
      }
      dynamic "wrr" {
        for_each = routing_policy.value.wrr != null ? routing_policy.value.wrr : []
        content {
          dynamic "health_checked_targets" {
            for_each = wrr.value.health_checked_targets != null ? [wrr.value.health_checked_targets] : []
            content {
              external_endpoints = health_checked_targets.value.external_endpoints
              dynamic "internal_load_balancers" {
                for_each = health_checked_targets.value.internal_load_balancers != null ? health_checked_targets.value.internal_load_balancers : []
                content {
                  ip_address         = internal_load_balancers.value.ip_address
                  ip_protocol        = internal_load_balancers.value.ip_protocol
                  load_balancer_type = internal_load_balancers.value.load_balancer_type
                  network_url        = internal_load_balancers.value.network_url
                  port               = internal_load_balancers.value.port
                  project            = internal_load_balancers.value.project
                  region             = internal_load_balancers.value.region
                }
              }
            }
          }
          rrdatas = wrr.value.rrdatas
          weight  = wrr.value.weight
        }
      }
    }
  }
}


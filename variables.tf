variable "dns_record_sets" {
  description = <<EOT
Map of dns_record_sets, attributes below
Required:
    - managed_zone
    - name
    - type
Optional:
    - deletion_policy
    - project
    - rrdatas
    - ttl
    - routing_policy (block):
        - enable_geo_fencing (optional)
        - geo (optional, block):
            - health_checked_targets (optional, block):
                - external_endpoints (optional)
                - internal_load_balancers (optional, block):
                    - ip_address (required)
                    - ip_protocol (required)
                    - load_balancer_type (optional)
                    - network_url (required)
                    - port (required)
                    - project (required)
                    - region (optional)
            - location (required)
            - rrdatas (optional)
        - health_check (optional)
        - primary_backup (optional, block):
            - backup_geo (required, block):
                - health_checked_targets (optional, block):
                    - external_endpoints (optional)
                    - internal_load_balancers (optional, block):
                        - ip_address (required)
                        - ip_protocol (required)
                        - load_balancer_type (optional)
                        - network_url (required)
                        - port (required)
                        - project (required)
                        - region (optional)
                - location (required)
                - rrdatas (optional)
            - enable_geo_fencing_for_backups (optional)
            - primary (required, block):
                - external_endpoints (optional)
                - internal_load_balancers (optional, block):
                    - ip_address (required)
                    - ip_protocol (required)
                    - load_balancer_type (optional)
                    - network_url (required)
                    - port (required)
                    - project (required)
                    - region (optional)
            - trickle_ratio (optional)
        - wrr (optional, block):
            - health_checked_targets (optional, block):
                - external_endpoints (optional)
                - internal_load_balancers (optional, block):
                    - ip_address (required)
                    - ip_protocol (required)
                    - load_balancer_type (optional)
                    - network_url (required)
                    - port (required)
                    - project (required)
                    - region (optional)
            - rrdatas (optional)
            - weight (required)
EOT

  type = map(object({
    managed_zone    = string
    name            = string
    type            = string
    deletion_policy = optional(string)
    project         = optional(string)
    rrdatas         = optional(list(string))
    ttl             = optional(number)
    routing_policy = optional(object({
      enable_geo_fencing = optional(bool)
      geo = optional(list(object({
        health_checked_targets = optional(object({
          external_endpoints = optional(list(string))
          internal_load_balancers = optional(list(object({
            ip_address         = string
            ip_protocol        = string
            load_balancer_type = optional(string)
            network_url        = string
            port               = string
            project            = string
            region             = optional(string)
          })))
        }))
        location = string
        rrdatas  = optional(list(string))
      })))
      health_check = optional(string)
      primary_backup = optional(object({
        backup_geo = list(object({
          health_checked_targets = optional(object({
            external_endpoints = optional(list(string))
            internal_load_balancers = optional(list(object({
              ip_address         = string
              ip_protocol        = string
              load_balancer_type = optional(string)
              network_url        = string
              port               = string
              project            = string
              region             = optional(string)
            })))
          }))
          location = string
          rrdatas  = optional(list(string))
        }))
        enable_geo_fencing_for_backups = optional(bool)
        primary = object({
          external_endpoints = optional(list(string))
          internal_load_balancers = optional(list(object({
            ip_address         = string
            ip_protocol        = string
            load_balancer_type = optional(string)
            network_url        = string
            port               = string
            project            = string
            region             = optional(string)
          })))
        })
        trickle_ratio = optional(number)
      }))
      wrr = optional(list(object({
        health_checked_targets = optional(object({
          external_endpoints = optional(list(string))
          internal_load_balancers = optional(list(object({
            ip_address         = string
            ip_protocol        = string
            load_balancer_type = optional(string)
            network_url        = string
            port               = string
            project            = string
            region             = optional(string)
          })))
        }))
        rrdatas = optional(list(string))
        weight  = number
      })))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.dns_record_sets : (
        v.routing_policy == null || (v.routing_policy.primary_backup == null || (length(v.routing_policy.primary_backup.backup_geo) >= 1))
      )
    ])
    error_message = "Each backup_geo list must contain at least 1 items"
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}


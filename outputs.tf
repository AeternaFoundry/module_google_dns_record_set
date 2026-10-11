output "dns_record_sets_id" {
  description = "Map of id values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no id are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.id if v.id != null && length(v.id) > 0 }
}
output "dns_record_sets_deletion_policy" {
  description = "Map of deletion_policy values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no deletion_policy are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.deletion_policy if v.deletion_policy != null && length(v.deletion_policy) > 0 }
}
output "dns_record_sets_managed_zone" {
  description = "Map of managed_zone values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no managed_zone are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.managed_zone if v.managed_zone != null && length(v.managed_zone) > 0 }
}
output "dns_record_sets_name" {
  description = "Map of name values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no name are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.name if v.name != null && length(v.name) > 0 }
}
output "dns_record_sets_project" {
  description = "Map of project values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no project are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.project if v.project != null && length(v.project) > 0 }
}
output "dns_record_sets_routing_policy" {
  description = "Map of routing_policy values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no routing_policy are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => one(v.routing_policy) if v.routing_policy != null && length(v.routing_policy) > 0 }
}
output "dns_record_sets_rrdatas" {
  description = "Map of rrdatas values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no rrdatas are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.rrdatas if v.rrdatas != null && length(v.rrdatas) > 0 }
}
output "dns_record_sets_ttl" {
  description = "Map of ttl values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no ttl are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.ttl if v.ttl != null }
}
output "dns_record_sets_type" {
  description = "Map of type values across all dns_record_sets, keyed the same as var.dns_record_sets except keys with no type are omitted"
  value       = { for k, v in google_dns_record_set.dns_record_sets : k => v.type if v.type != null && length(v.type) > 0 }
}


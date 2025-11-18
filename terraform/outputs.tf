output "cluster_name" {
    value = google_container_cluster.primary.name
}

output "cluster_region" {
    value = google_container_cluster.primary.location
}
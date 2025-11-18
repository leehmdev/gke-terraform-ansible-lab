variable "project_id" {
    type    = string
    description = "GCP project ID"
}

variable "region" {
    type    = string
    default = "asia-northeast1"
}

variable "cluster_name" {
    type    = string
    default = "demo-gke-cluster"
}


variable "vke_label" {
  default = "main"
}

variable "k8_version" {
  default = "v1.35.0+1"
}

variable "region" {
  default = "ewr"
}

variable "np_label" {
  default = "main"
}

variable "np_plan" {
  default = "vc2-1c-2gb"
}

variable "np_node_quantity" {
  default = 3
}

variable "np_min_nodes" {
  default = 1
}

variable "np_max_nodes" {
  default = 3
}

variable "np_auto_scale" {
  default = true
}

variable "root_domain_name" {
  description = "Root domain you want to set up a certificate for (i.e. example.com)."
  type        = string
}

variable "alternative_names" {
  description = "Alternative names for the certificate (i.e. *.example.com)."
  type        = list(string)
  default     = []
}

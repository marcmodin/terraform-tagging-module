variable "context" {
  description = "The context to use for the tags"
  type = any
}

variable "tags" {
  description = "The tags to apply to the resources"
  type    = any
  default = {}
}

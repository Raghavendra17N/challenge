variable "rules" {
    description = "list of custom rules definations"
    default = []
    type = list(object({
        project = string
        network = string
        name = string
        direction = string
        metadata = string
        priority = number
        ranges = list(string)
        source_tags = list(string)
        source_service_accounts = list(string)
        target_tags = list(string)
        target_service_accounts  = list(string)
        allow = list(object({
            protocol = string
            ports = list(string)
        }))
        deny = list(object({
            protocol = string
            ports = list(string)
        }))
    }))
}
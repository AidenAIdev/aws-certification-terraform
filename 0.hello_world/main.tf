variable "greeting" {
  type = string
    default = "Hello, World!"
}
variable "welcome" {
    type = string
    default = "Welcome to terraform"
  
}

output "output" {
    value = "${var.greeting}, ${var.welcome}"
  
}
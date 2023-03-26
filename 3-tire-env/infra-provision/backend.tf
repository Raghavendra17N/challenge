terraform {
  backend "gcs" {
    bucket = "charged-muse-376504-iac-tf-state"
    prefix = "env/three-tire-env"
  }
}
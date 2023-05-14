terraform {
  backend "gcs" {
    bucket = "bkt-tfstate-aps-chat" 
    prefix = "terraform/state"
  }
}
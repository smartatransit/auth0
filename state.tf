terraform {
  backend "remote" {
    organization = "smartatransit"
    workspaces {
      name = "auth0"
    }
  }

  required_providers {
    auth0 = "= 0.6"
  }
}

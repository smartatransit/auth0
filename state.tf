terraform {
  backend "remote" {
    organization = "smartatransit"
    workspaces {
      name = "auth0"
    }
  }
}

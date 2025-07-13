variable "repos" {
    type = map(
        object(
            {
                description = string
                visibility = string
            }
        )
    )
}

variable "constant_files" {
    type = list(
        object(
            {
                git_path = string
                local_path = string
            }
        )
    )
}

variable "repo_files" {
    type = list(
        object(
            {
                repo_name = string
                git_path = string
                local_path = string
            }
        )
    )
}

variable "landing_branch_name" {
  type = string
  default = "landing"
}

variable "github_token" {
  sensitive = true
  type = string
}

variable "github_owner" {
  sensitive = true
  type = string
}
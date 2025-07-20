variable files_to_upload {
    type = list(
        object(
            {
                local_path = string
                git_path = string
                overwrite_on_create = bool
            }
        )
    ) 
}

variable "landing_branch_name" {
    type = string
    default = "landing"
}

variable "repo_name" {
    type = string
}
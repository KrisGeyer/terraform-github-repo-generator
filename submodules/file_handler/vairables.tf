variable files_to_upload {
    type = list(
        object(
            {
                repo_name = string
                local_path = string
                git_path = string
            }
        )
    ) 
}

variable "landing_branch_name" {
    type = string
}
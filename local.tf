locals {
    constant_files = flatten(
        [
            for repo_name, repo in var.repos: 
            [
                for file_details in var.constant_files: 
                {
                    repo_name = repo_name
                    git_path = file_details.git_path
                    local_path = file_details.local_path
                    overwrite_on_create = file_details.overwrite_on_create
                }
            ]
        ]
    )
    repo_files = flatten(
        [
            for repo_name, repo in var.repos: 
            [
                for file_details in var.repo_files: {
                    repo_name = file_details.repo_name
                    git_path = file_details.git_path
                    local_path = file_details.local_path
                }
                if repo_name == file_details.repo_name
            ]
        ]
    )
}
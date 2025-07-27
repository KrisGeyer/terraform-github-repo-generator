locals {
  repo_files = flatten(
    [
        for file_details in var.repo_files : {
          git_path            = file_details.git_path
          local_path          = file_details.local_path
          overwrite_on_create = file_details.overwrite_on_create
        }
    ]
  )
}
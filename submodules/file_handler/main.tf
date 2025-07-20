resource "github_repository_file" "files" {
  for_each    =   { 
    for file_instructions in var.files_to_upload : file_instructions.git_path => file_instructions
  }
  repository = var.repo_name
  branch =  var.landing_branch_name
  content = file(each.value.local_path)
  file = each.value.git_path
  overwrite_on_create = each.value.overwrite_on_create
}
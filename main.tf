resource "github_repository" "repo" {
  for_each    = var.repos
  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility
  auto_init              = false
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = false
}

resource "github_branch" "landing_branch" {
  for_each    = var.repos
  repository = github_repository.repo[each.key].name
  branch = var.landing_branch_name
}

module "upload_constant_files" {
    source = "./submodules/file_handler"
    files_to_upload = local.constant_files
    landing_branch_name = var.landing_branch_name
    depends_on = [ github_repository.repo ]
}

module "upload_repo_files" {
    source = "./submodules/file_handler"
    files_to_upload = local.repo_files
    landing_branch_name = var.landing_branch_name
    depends_on = [ github_repository.repo ]
}
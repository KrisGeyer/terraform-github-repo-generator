resource "github_repository" "repo" {
  name                   = var.repo_name
  description            = var.repo_description
  visibility             = var.visibility
  auto_init              = true
  delete_branch_on_merge = true
  has_issues             = true
  has_wiki               = false
}

resource "github_branch" "landing_branch" {
  repository = github_repository.repo.name
  branch     = var.landing_branch_name
  depends_on = [github_repository.repo]
}

resource "github_repository_file" "upload_repo_files" {
  for_each = {for file_instance in local.repo_files : "${file_instance.git_path}_${file_instance.local_path}" => file_instance}
  repository = var.repo_name
  file = each.value.git_path
  content = file(each.value.local_path)
  overwrite_on_create = each.value.overwrite_on_create
  branch = var.landing_branch_name
  depends_on          = [github_repository.repo, github_branch.landing_branch]
}

module "generate_notes_pages" {
  source              = "./submodules/notes_generator"
  repo_name = var.repo_name
  notes_root_folder = var.notes_root_folder
  file_map     = var.notes_file_map
  landing_branch_name = var.landing_branch_name
  depends_on          = [github_repository.repo, github_branch.landing_branch]
}
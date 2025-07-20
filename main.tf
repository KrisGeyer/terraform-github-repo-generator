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

module "upload_repo_files" {
  source              = "./submodules/file_handler"
  repo_name = github_repository.repo.name
  files_to_upload     = local.repo_files
  landing_branch_name = var.landing_branch_name
  depends_on          = [github_repository.repo, github_branch.landing_branch]
}

module "generate_notes_pages" {
  source              = "./submodules/notes_generator"
  repo_name = var.repo_name
  notes_root_folder = var.notes_root_folder
  file_map     = var.file_map
  landing_branch_name = var.landing_branch_name
  depends_on          = [github_repository.repo, github_branch.landing_branch]
}
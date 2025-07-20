/*resource "github_repository_file" "files" {
  for_each    =   { 
    for file_instructions in var.files_to_upload : "${file_instructions.repo_name}_${file_instructions.git_path}" => file_instructions
  }
  repository = var.repo_name
  branch =  var.landing_branch_name
  content = file(each.value.local_path)
  file = each.value.git_path
  overwrite_on_create = each.value.overwrite_on_create
}
*/

resource "github_repository_file" "file" {
  for_each = { for idx, item in local.files : idx => item }
  repository = var.repo_name
  branch =  var.landing_branch_name
  file = "${var.notes_root_folder}/${each.value.topic}/${each.value.sub_topic}/notes.md"
  content = templatefile("/submodules/notes_generator/notes.tpl", {
    topic     = each.value.topic
    sub_topic = each.value.sub_topic
    links     = each.value.links
    }
  )
}
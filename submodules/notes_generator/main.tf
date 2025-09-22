resource "github_repository_file" "file" {
  for_each = { for idx, item in local.files : idx => item }
  repository = var.repo_name
  branch =  var.landing_branch_name
  file = "${var.notes_root_folder}/${each.value.topic}/${each.value.sub_topic}/notes.md"
  content = templatefile("notes.tpl", {
    topic     = each.value.topic
    sub_topic = each.value.sub_topic
    links     = each.value.links
    }
  )
}
output "file_uploaded" {
    description = "The files uploaded."
    value = var.files_to_upload
}

output "number_files_uploaded"{
    description = "number of files uploaded"
    value = length(github_repository_file.files)
}
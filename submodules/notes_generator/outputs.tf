

output "number_files_uploaded"{
    description = "number of files uploaded"
    value = length(github_repository_file.file)
}
provider "github" {
  token = var.github_token
  owner = var.github_owner
}

run "add_repo" {
    module {
        source = "./submodules/file_handler"
    }
    command = plan

    variables {
        files_to_upload = [
            {
                git_path = "a_git_path"
                local_path = "./tests/repositories/hello.txt"
                repo_name = "to_add"
                overwrite_on_create = true
            }
        ]
    }

    assert {
        
        condition = contains(
            [
                for outer_file in github_repository_file.files : (
                    outer_file.file
                )
            ]
        , "a_git_path"
        )
        error_message = "Failed to generate the files."
    }

    assert {
        condition = length(github_repository_file.files) == 1
        error_message = "expected to see a file appropriate filtering across the repos. Only 1 file should be uploaded"
    }
}
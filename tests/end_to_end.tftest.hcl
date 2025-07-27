provider "github" {
  token = var.github_token
  owner = var.github_owner
}

run "add_repo" {
    module  {
        source = "./"
    }
    
    command = plan

    variables {
        repo_name = "to_add"
        repo_description = "a description"
        visibility = "private"
        notes_root_folder = "notes_root_folder"

        notes_file_map = {
            "notes_1":{
                "notes_2": {
                    "links": {
                        "notes_3": {
                        "link": "https://a_link"
                        "type": "tutorial"
                        }
                    }
                }
            }
        }
        repo_files = [
            {
                git_path = "a_git_path_copy"
                local_path = "./tests/repositories/hello.txt"
                overwrite_on_create = false
            },
            {
                git_path = "another_git_path"
                local_path = "./tests/repositories/hello.txt"
                overwrite_on_create = false
            }
        ]
    }

    assert {
        condition = github_repository.repo.name == "to_add"
        error_message = "Expected to_add as a repo name."
    }

    assert {
        condition = github_repository.repo.visibility == "private"
        error_message = "Expected visibility as private."
    }


    assert {
        condition = contains(
            [
                for file in github_repository_file.upload_repo_files : (
                    "${file.file}"
                )
            ]
        , "another_git_path")
      error_message = "expected to see a file for the repository which is "
    }

    assert {
        condition = length(github_repository_file.upload_repo_files) == 2
        error_message = "expected to see a file appropriate filtering across the repos. Only 1 file should be uploaded"
    }
}
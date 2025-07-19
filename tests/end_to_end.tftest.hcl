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
        repos = {
            "to_add" : {
                description = "a description"
                visibility = "private"
            }
        }
        constant_files = [
            {
                git_path = "a_git_path"
                local_path = "./tests/repositories/hello.txt"   
                overwrite_on_create = false
            }
        ]
        repo_files = [
            {
                git_path = "a_git_path_copy"
                local_path = "./tests/repositories/hello.txt"
                repo_name = "to_add"
                overwrite_on_create = false
            },
            {
                git_path = "another_git_path"
                local_path = "./tests/repositories/hello.txt"
                repo_name = "to_add"
                overwrite_on_create = false
            },
            {
                git_path = "yet_another_git_path"
                local_path = "./tests/repositories/hello.txt"
                repo_name = "not_to_add"
                overwrite_on_create = false
            }
        ]
    }

    assert {
        condition = contains(
            [
                for repo in github_repository.repo : (
                    "${repo.name}_${repo.visibility}"
                )
            ]
        , "to_add_private")
        error_message = "Expected to_add as a repo name."
    }

    assert {
        condition = contains(
            [
                for file in module.upload_constant_files.file_uploaded : (
                    "${file.repo_name}_${file.local_path}_${file.git_path}"
                )
            ]
        , "to_add_./tests/repositories/hello.txt_a_git_path")
        error_message = "Failed to generate the constant_files variables."
    }

    assert {
        condition = contains(
            [
                for file in module.upload_repo_files.file_uploaded : (
                    "${file.repo_name}_${file.local_path}_${file.git_path}"
                )
            ]
        , "to_add_./tests/repositories/hello.txt_another_git_path")
      error_message = "expected to see a file for the repository which is "
    }

    assert {
        condition = module.upload_repo_files.number_files_uploaded == 2
        error_message = "expected to see a file appropriate filtering across the repos. Only 1 file should be uploaded"
    }
}
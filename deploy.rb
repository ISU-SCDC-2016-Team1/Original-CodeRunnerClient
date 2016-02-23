require './util.rb'

def deploy_c project, runner, mode = :normal
  user = get_user
  identity = get_identity
  proj_url = get_project_url project
  runner = get_runner runner

  set_ssh_command "ssh -i #{identity} #{user}@#{runner} "

  forward_identity runner

  ssh "mkdir deploy", mode

  ssh "cd deploy && git clone #{proj_url}", mode

  delete_forwarded_identity
end

def clean_c project, runner
  runner = get_runner runner
  set_ssh_command "ssh -i #{get_identity} #{get_user}@#{runner} "

  ssh "cd deploy & rm -rf #{project}"
end

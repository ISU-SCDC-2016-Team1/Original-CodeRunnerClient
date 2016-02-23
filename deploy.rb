require './util.rb'

def deploy project, runner, mode = :normal
  user = get_user
  identity = get_identity
  proj_url = get_project_url project

  set_ssh_command "ssh -i #{identity} #{user}@#{runner} "

  forward_identity runner

  ssh "mkdir deploy", mode

  ssh "cd deploy && git clone #{proj_url}", mode

  delete_forwarded_identity
end

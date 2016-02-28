require 'util'

def build_c project, runner, mode = :normal
  runner = get_runner runner
  set_ssh_command "ssh -i #{@config.key} #{get_user}@#{runner} "

  ssh "cd deploy/#{project} && sh .build", mode
end

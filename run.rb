require 'util.rb'

def run_c project, runner, mode = :normal
  runner = get_runner runner
  set_ssh_command "ssh -i #{@config.key} #{get_user}@#{runner} ", project

  ssh "cd deploy/#{project} && sh .run", mode
end

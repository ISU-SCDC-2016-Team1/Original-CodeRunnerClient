require './util.rb'

def run project, runner, mode = :normal
  set_ssh_command "ssh -i #{get_identity} #{get_user}@#{runner} "

  ssh "cd deploy/#{project} && sh .run", mode
end

require './util.rb'

def build project, runner, mode = :normal
  set_ssh_command "ssh -i #{get_identity} #{get_user}@#{runner} "

  ssh "cd deploy/#{project} && sh .build", mode
end

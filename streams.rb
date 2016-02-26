require 'util.rb'

def get_stdin project, runner
  runner = get_runner runner
  default_ssh_command runner, project
  
  ssh "cat ~/deploy/#{project}-stdin"
end

def get_stdout project, runner
  runner = get_runner runner
  default_ssh_command runner, project
  
  ssh "cat ~/deploy/#{project}-stdout"
end

def get_stderr project, runner
  runner = get_runner runner
  default_ssh_command runner, project
  
  ssh "cat ~/deploy/#{project}-stderr"
end

def send_stdin project, runner, stdin_filename
  runner = get_runner runner
  cmd = "scp -i #{get_identity} #{stdin_filename} #{get_user}@#{runner}:~/deploy/#{project}-stdin"

  if fork
    Process.wait
  else
    exec cmd
  end
end

require './util.rb'

def get_stdin project, runner
  default_ssh_command runner
  
  ssh "cat ~/deploy/stdin"
end

def get_stdout project, runner
  default_ssh_command runner
  
  ssh "cat ~/deploy/stdout"
end

def get_stderr project, runner
  default_ssh_command runner
  
  ssh "cat ~/deploy/stderr"
end

def send_stdin project, runner, stdin_filename
  cmd = "scp -i #{get_identity} #{stdin_filename} #{get_user}@#{runner}:~/deploy/stdin"

  if fork
    Process.wait
  else
    exec cmd
  end
end

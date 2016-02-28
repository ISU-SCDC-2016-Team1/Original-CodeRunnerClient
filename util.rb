require 'config'

def get_user
  ENV["USER"]
end

def get_keyfile
  @config.keyfile.gsub(/%username%/, ENV["RUSER"])
end

def get_identity
  @config.keydir + get_keyfile
end

def get_gitserver
  @config.gitserver
end

def get_gituser
  @config.gituser.gsub(/%username%/, ENV["RUSER"])
end

def get_runner runner
  @config.runners[runner.to_s]
end

def get_project_url project
  "git@#{get_gitserver}:#{get_gituser}/#{project}.git"
end

def set_ssh_command cmd, project = "default"
  @ssh_project = project
  @ssh_cmd = cmd
end

def ssh cmd, option = :normal
  cr_stdout = "~/deploy/#{@ssh_project}-stdout"
  cr_stderr = "~/deploy/#{@ssh_project}-stderr"
  cr_stdin = "~/deploy/#{@ssh_project}-stdin"

  redir_snippet = "> #{cr_stdout} 2> #{cr_stderr} < #{cr_stdin}"

  ssh "touch #{cr_stdin}" if option == :redirect

  cmd = @ssh_cmd + "'" + cmd + "'" if option == :normal
  cmd = @ssh_cmd + "'" + cmd + " #{redir_snippet}'"  if option == :redirect
  cmd = @ssh_cmd + "'" + cmd + " > /dev/null 2> /dev/null'" if option == :silent

  if fork
    Process.wait
  else
    exec(cmd)
  end
end

def forward_identity runner
  cmd = "scp -i #{@config.key} #{get_identity} #{get_user}@#{runner}:.ssh/id_rsa"

  if fork
    Process.wait
  else
    exec(cmd)
  end
end

def delete_forwarded_identity
  ssh "mv .ssh/id_rsa /tmp/id_to_be_deleted"
end

def default_ssh_command runner, project
  set_ssh_command "ssh -i #{@config.key} #{ENV["USER"]}@#{runner} ", project
end

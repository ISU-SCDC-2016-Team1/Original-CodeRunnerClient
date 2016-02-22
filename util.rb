require './config.rb'

def get_user
  @config.username
end

def get_keyfile
  @config.keyfile.gsub(/%username%/, get_user)
end

def get_identity
  @config.keydir + get_keyfile
end

def get_gitserver
  @config.gitserver
end

def get_gituser
  @config.gituser
end

def get_runner runner
  @config.runners [runner.to_s]
end

def get_project_url project
  "git@#{get_gitserver}:#{get_gituser}/#{project}.git"
end

def set_ssh_command cmd
  @ssh_cmd = cmd
end

def ssh cmd, option = :normal
  cmd = @ssh_cmd + "'" + cmd + "'" if option == :normal
  cmd = @ssh_cmd + "'" + cmd + " > ~/cr_stdout 2> ~/cr_stderr" if option == :redirect
  cmd = @ssh_cmd + "'" + cmd + " > /dev/null 2> /dev/null" if option == :redirect
  
  if fork
    Process.wait
  else
    exec(cmd)
  end
end

def forward_identity runner
  cmd = "scp #{get_identity} #{get_user}@#{runner}:.ssh/id_rsa"

  if fork
    Process.wait
  else
    exec(cmd)
  end
end

def delete_forwarded_identity
  ssh "mv .ssh/id_rsa /tmp/id_to_be_deleted"
end

require 'core'

IRB.conf[:PROMPT][:CRCONSOLE] = {
  :AUTO_INDENT => true,
  :PROMPT_I => "~> ",
  :PROMPT_C => ">",
  :PROMPT_s => ">",
  :RETURN => ""
}

def print_prompt
  $stdout.write @project unless @project.nil?
  $stdout.write " => " unless @runner.nil? or @project.nil?
  $stdout.write @runner + " " unless @runner.nil?
end

print_prompt

IRB.conf[:PROMPT_MODE] = :CRCONSOLE

def runner r
  @runner = r
  print_prompt
end

def project p
  @project = p
  print_prompt
end

def setargs args
  unless args.nil?
    @project = args.keys.first.to_s
    @runner = args.values.first.to_s
    @same = args
  end
end

def deploy args = nil, redir = :normal
  setargs args
  deploy_c @project, @runner, redir
  print_prompt
end

def clean args = nil, redir = :normal
  setargs args
  clean_c @project, @runner
  print_prompt
end

def run args = nil, redir = :redirect
  setargs args
  run_c @project, @runner, redir
  print_prompt
end

def build args = nil, redir = :normal
  setargs args
  build_c @project, @runner, redir
  print_prompt
end

def stdout args = nil
  setargs args
  get_stdout @project, @runner
  print_prompt
end

def stderr args = nil
  setargs args
  get_stdout @project, @runner
  print_prompt
end

def do_get_stdin args = nil
  setargs args
  get_stdin @project, @runner
  print_prompt
end

def stdin filename = nil, args = nil
  return do_get_stdin @args if filename.nil?

  setargs args
  send_stdin @project, @runner, filename
  print_prompt
end

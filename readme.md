# CodeRunner Framework

## Note: SSH Keys

CodeRunner depends on SSH keys provided by keyescrow. Before you can use
CodeRunner to deploy projects to the runners, you must run
~~~
keyescrow get -t /tmp
~~~
to load your SSH keys.

## Functions
CodeRunner supports the following functions

- deploy: Deploy a project on a runner
- build: Build a project on a runner
- run: Run a project on a runner
- clean: Delete a project from a runner
- stdout: Display standard output from previous run
- stderr: Display standard output from previous run
- stdin: Display or send standard input

## Syntax
The CodeRunner syntax is as follows:
~~~
<command> :<project> => :<runner>
~~~

For example, to deploy, build, and run the project 'test1' to the runner 'runner1',

~~~
deploy :test1 => :runner1
build :test1 => :runner1
run :test1 => :runner1
~~~

CodeRunner remembers the project and runner from previous commands. This
is specified on the prompt. The previous commands could be shortened to the following:

~~~
deploy :test1 => :runner1
build
run
~~~

## Streams
By default, CodeRunner redirects standard input and output to files.
After running a project, the command 'stdout' can be used to view standard output.
The 'stderr' command does the same for standard error.

### Standard Input
The 'stdin' command, without additional arguments, simply prints the 
standard input that was provided to the run. Running the stdin command 
'stdin "filename", :project => :runner' or 'stdin "filename"', if
crconsole has remembered the current project and runner, will send the 
local file 
<filename> to the remote server and use it as standard in.

~~~
# Upload /tmp/my_input and set it as standard input
stdin "/tmp/my_input", :test1 => :runner1
~~~

To run the 'stdin' command long, form (ie. not using a remembered project
and runner from a previous command), you must specify the filename as 'nil'
(no quotes). For example,
~~~
stdin nil, :test => :runner1
~~~
is the same as
~~~
stdin
~~~
if the console remembers :test and :runner1 from previous commands.

# Project Configuration
CodeRunner requires two files to exist in the root of the project: a run configuration
and a build configuration. The files are named '.run' and '.build', respectively.
Each file is a simple shell script, executed with the 'sh' utility when
the 'build' and 'run' CodeRunner commands are used.

# Deploying
- Copy coderunner.conf to /etc/coderunner/coderunner.conf
- Copy crconsole to somewhere in $PATH, preferably /usr/bin
- Copy all .rb files to /usr/lib/coderunner/

# Examples
~~~
crconsole
# Deploy a project to a runner
~> deploy :test1 => :runner1

# Build the project on the runner
# Note that after the first command, the promp
# will change to represent the "remembered" parameters.
test1 => runner1 ~> build
# Equivalent to 'build :test1 => :runner1'

# Run the project on the runner
test1 => runner1 ~> run
# Equivalent to 'run :test1 => :runner1'

# Print the standard output then standard error of the run
test1 => runner1 ~> stdout
test1 => runner1 ~> stderr
# These can also be specified long-form as
# 'stdout :test1 => :runner1'

# Upload a new file (stored locally as test-stdin.txt) 
# to use as standard input
test1 => runner1 ~> stdin "test-stdin.txt"
# This is equivalent to long-form 'stdin "test-stdin.txt", :test1 => :runner1'

# Print the standard input that is being used currently
test1 => runner1 ~> stdin
# This is equivalent to 'stdin nil, :test1 => :runner1'
# Note the slightly different syntax.

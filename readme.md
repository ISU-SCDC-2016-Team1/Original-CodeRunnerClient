# CodeRunner Framework

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
standard input that was provided to the run. Running a full stdin command 
'stdin :<project> => :<runner>, <filename>' will send the local file 
<filename> to the remote server and use it as standard in.

# Project Configuration
CodeRunner requires two files to exist in the root of the project: a run configuration
and a build configuration. The files are named '.run' and '.build', respectively.
Each file is a simple shell script, executed with the 'sh' utility when
the 'build' and 'run' CodeRunner commands are used.

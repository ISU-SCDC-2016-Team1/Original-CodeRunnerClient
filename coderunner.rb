#! /usr/bin/env ruby

# CodeRunner command-line client

def usage
  puts "Usage:    cr deploy <project> <runner>"
  puts "          cr run <project> <runner>"
  puts "          cr clean <project> <runner>"
end

if ARGV.size != 3
  usage
  exit
end

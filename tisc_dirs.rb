#!/usr/bin/env ruby

# a wrapper for TISC to run stuff in multiple directories, and catch errors and failures.

# for each directory relative to this one, do the runs
# fork a call to tisc with the input file (flex? by default)
# monitor the output of tisc to look for the ERROR output
# also watch for core dump
# On completion, write out the output to an output.log in the runs directory

require 'pty'
require 'pathname'

# Command to run in each directory
# 'tisc flex' by default
cmd = 'tisc flex'

# get a list of all directories relative to where we're being run
# The current working dir, relative to where you start
working_dir = Dir.pwd
dirs = Pathname.new(working_dir).children.select(&:directory?)

dirs.each do |directory|
  start_time = Time.now
  puts '======================================================='
  puts "TISC'ing in #{directory} started at #{start_time}"
  puts '======================================================='
  begin
    Dir.chdir(directory)
    PTY.spawn(cmd) do |out, stdin, pid|
      begin
        out.each do |line|
          # printing the output so that it can be seen
          puts line
          # if the line starts with ERROR, we need to kill the thing
          if line.start_with?('ERROR')
            # kill the PID
            puts 'Terminating because errors detected!'
            `kill #{pid}`
          end
        end
      rescue Errno::EIO
        # probably just means it's done with output
      end
    end
  rescue PTY::ChildExited
    puts 'Completed but no output'
  end
  puts '======================================================='
  puts "Finished in #{directory} took #{Time.now - start_time} seconds"
  puts '======================================================='

end
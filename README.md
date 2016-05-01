# TISC wrapper

Need to work around some of the limitations of the existing TISC software located here:
https://github.com/danigeos/tisc

The goal is to be able to queue up multiple directories of runs, and go through them all.
Handling errors and failures, so that batch runs can be accomplished.

## `tisc_dirs.rb` How to execute

Download it, put it somewhere. call it with `ruby /path/to/tisc_dirs.rb` in one level up from where you want to
go through all the directories. It will then, for each directory in the current working directory, execute `tisc flex`
terminating the process if errors are detected, and continuing even if it coredumps.

All of the output is put into the terminal, so you can still see what's going on via scrollback.

If the output gets too long, you can execute it like so: `ruby /path/to/tisc_dirs.rb | tee output.log` and then 
you'll get the output sent to a log file as well as on the console, so you can review the output later.

## TODO list
- [X] some kind of working directory structure
- [ ] Pass through TISC command line params
- [ ] Ubuntu workaround for GMT calls
- [X] Catch coredump errors
- [X] Handle error output, and terminate run
- [ ] convert the PS output to a PDF

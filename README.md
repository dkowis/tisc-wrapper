# TISC wrapper

Need to work around some of the limitations of the existing TISC software located here:
https://github.com/danigeos/tisc

The goal is to be able to queue up multiple directories of runs, and go through them all.
Handling errors and failures, so that batch runs can be accomplished.

## TODO list
- [ ] some kind of working directory structure
- [ ] Pass through TISC command line params
- [ ] Ubuntu workaround for GMT calls
- [ ] Catch coredump errors
- [ ] Handle error output, and terminate run
- [ ] convert the PS output to a PDF

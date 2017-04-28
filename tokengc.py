#!/usr/bin/python
import sys


## Add your gitlab token once downloaded and copied to a non GIT folder
TOKEN = ''

comm = 'git clone https://gitlab-ci-token:'
args = sys.argv[1:]
addendum = args[0][19:]

print(comm + TOKEN + addendum)

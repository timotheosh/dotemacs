#!/bin/bash

# Repos to be checked out and then built with make.
repobuilds=" \
https://github.com/alexott/cedet.git \
https://github.com/pinard/Pymacs.git \
"
# Repos that just need to be retrieved.
repos=" \
https://github.com/timotheosh/inferior-cling.git \
https://github.com/python-rope/ropemacs.git \
"

# Run python setup.py on these directories (after they have been
# downloaded above)

pythonsetup="\
Pymacs \
ropemacs \
"

snippetrepos=" \
https://github.com/AndreaCrotti/yasnippet-snippets.git \
https://github.com/jonatkinson/yasnippet-licenses.git \
"

function gitclone {
  DIRECTORY=$1
  REPO=$2
  mkdir -p $DIRECTORY
  pushd $DIRECTORY
  git clone $REPO
  popd
}

function makerepo {
  DIRECTORY=$1
  mkdir -p $DIRECTORY
  pushd $DIRECTORY
  make all
  popd
}

function run-py-setup {
  DIRECTORY=$1
  mkdir -p $DIRECTORY
  pushd $DIRECTORY
  sudo python setup.py install
  popd
}

function curlprog {
  DIRECTORY=$1
  URL=$2
  mkdir -p $DIRECTORY
  pushd $DIRECTORY
  curl -O $URL
  popd
}

for x in $repobuilds $repos;do
  gitclone programs $x 
done

for x in $repobuilds; do
  DIR=programs/$(basename https://github.com/alexott/cedet.git|sed -e 's/\.git$//')
  makerepo $DIR
done

for x in $snippetrepos;do
  gitclone yasnippets $x
done

for x in $pythonsetup;do
  run-py-setup $x
done

echo "Repos retrieved and ready."
exit 0

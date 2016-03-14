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
https://github.com/timotheosh/aws-el.git \
https://github.com/ensime/ensime-server.git \
https://github.com/fukamachi/kindly-mode.git \
https://github.com/timotheosh/cbible.git \
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

function directoryname {
  echo $(basename $1|sed -e 's/\.git$//')
}

for x in $repos;do
  DIR=programs/$(directoryname $x)
  if [[ ! -d $DIR ]];then
    gitclone programs $x
    echo ""
  fi
done

for x in $repobuilds;do
  DIR=programs/$(directoryname $x)
  if [[ ! -d $DIR ]];then
    gitclone programs $x
    echo ""
    makerepo $DIR
  fi
done

for x in $snippetrepos;do
  DIR=yasnippets/$(directoryname $x)
  if [[ ! -d $DIR ]];then
    gitclone yasnippets $x
  fi
done

for x in $pythonsetup;do
  DIR=programs/$(directoryname $x)
  if [[ ! -d $DIR/build/lib.linux-x86_64-2.7 ]];then
    run-py-setup $DIR
  fi
done

echo "Repos retrieved and ready."
exit 0

#!/bin/bash

# Repos to be checked out and then built with make.
repobuilds=" \
https://github.com/pinard/Pymacs.git \
"
# Repos that just need to be retrieved.
repos=" \
https://github.com/emacsmirror/edi-mode.git \
https://github.com/python-rope/ropemacs.git \
https://github.com/ensime/ensime-server.git \
https://github.com/fukamachi/kindly-mode.git \
https://github.com/wallyqs/ob-racket.git \
https://github.com/timotheosh/inferior-cling.git \
https://github.com/timotheosh/aws-el.git \
https://github.com/timotheosh/cbible.git \
https://github.com/clojure-emacs/clj-refactor.el.git \
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

java_repos_maven=" \
https://github.com/jdee-emacs/jdee-server.git \
"

function get_shampoo_gst {
  PACKAGE=shampoo-gst-0.0.1
  DIRECTORY=programs/shampoo
  if [[ ! -e $DIRECTORY ]];then
    pushd programs
    wget -c http://dmitrymatveev.co.uk/shampoo/files/${PACKAGE}.tgz
    tar xvzf ${PACKAGE}.tgz
    rm -f ${PACKAGE}.tgz
    cd shampoo
    gst-package -t ~/.st package.xml
    popd
  fi
}

function get_cedet {
  DIRECTORY=programs/cedet
  if [[ ! -e $DIRECTORY ]];then
    git clone http://git.code.sf.net/p/cedet/git ${DIRECTORY}
    pushd ${DIRECTORY}
    make
    popd
  fi
}

function install_powerline_fonts {
  DIRECTORY=$HOME/.local/share/fonts
  TEMP=/tmp/${USER}-powerline-font-install
  if [[ ! -e $DIRECTORY/Ubuntu\ Mono\ derivative\ Powerline.ttf ]];then
    rm -rf ${TEMP}
    git clone https://github.com/powerline/fonts.git ${TEMP}
    pushd ${TEMP}
    ./install.sh
    popd
    rm -rf ${TMP}
  fi
}

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
  python setup.py build
  python setup.py install --user
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

# Install cedet
get_cedet

# Install powerline patch fonts
install_powerline_fonts

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

for x in $java_repos_maven;do
  DIR=programs/$(directoryname $x)
  if [[ ! -d $DIR ]];then
    gitclone programs $x
    cd ${DIR}
    mvn clean package
  fi
done

get_shampoo_gst

echo "Repos retrieved and ready."
exit 0

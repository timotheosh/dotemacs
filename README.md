dotemacs
========

My ever-evolving emacs configuration

My object with this has been to write an Emacs configuration that is
modular, and easy to maintain, all the while, include all the features
I find useful for dat-to-day programming and writing.

I've removed all dependencies with Cask, and rely on use-package.

To use just run:
```shell
git clone https://github.com/timotheosh/dotemacs.git $HOME/.emacs.d
cd $HOME/.emacs.d
./getprograms.sh
```

Then start up Emacs. If using the ansible mode (on by default), it
will give warnings as ansible-mode has not been properly prefixed by
its author. There is a risk of global name clashes, that are hopefully
adverted by deferred loading.
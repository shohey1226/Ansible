#!/bin/bash

export PLENV_ROOT=~/.plenv

if [[ ! -e $PLENV_ROOT ]];then
   # 1
   git clone git://github.com/tokuhirom/plenv.git $PLENV_ROOT

   grep 'plenv/bin' ~/.bash_profile 
   if [[ $? -ne 0 ]]
   then
     # 2
     echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> $HOME/.bash_profile
     # 3
     echo 'eval "$(plenv init -)"' >> $HOME/.bash_profile
   fi	
   # 4
   $SHELL -l

   # 5
   git clone git://github.com/tokuhirom/Perl-Build.git $PLENV_ROOT/plugins/perl-build/
   plenv install 5.18.2
 
   # 6
   plenv rehash

   # 5.18.2 we use
   plenv global 5.18.2 
   # and cpanm
   plenv install-cpanm
   cpanm install Carton
fi


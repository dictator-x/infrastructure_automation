#!/bin/bash
yum upate -y
yum install epel-release -y
yum install git -y
yum install wget -y
yum install stress -y
yum install bind-utils -y
yum install telnet -y

# install Node.js 14
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
yum install nodejs -y

# install vim8
yum install gcc make ncurses ncurses-devel -y
yum install ctags tcl-devel ruby ruby-devel lua lua-devel luajit luajit-devel python python-devel perl perl-devel -y
yum install perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed -y
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp
make install
cd -

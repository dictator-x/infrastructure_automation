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
cd /tmp
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp
make install
cd /

# Install zsh
cd /tmp
yum install -y git make ncurses-devel gcc autoconf man yodl
git clone https://github.com/zsh-users/zsh.git
cd zsh
./Util/preconfig
./configure
make -j 20 install
command -v zsh | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)" "centos"
cd /

# install oh-my-zsh
cd /tmp
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git /home/centos/.oh-my-zsh/custom/themes/powerlevel9k

# install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions /home/centos/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/centos/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions /home/centos/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search /home/centos/.oh-my-zsh/custom/plugins/zsh-history-substring-search

# install bat
wget https://github.com/sharkdp/bat/releases/download/v0.15.3/bat-v0.15.3-x86_64-unknown-linux-musl.tar.gz
mkdir bat
tar -xzvf bat-v0.15.3-x86_64-unknown-linux-musl.tar.gz -C bat --strip-components 1
mv ./bat/bat /usr/local/bin

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/.fzf
/tmp/.fzf/install --all


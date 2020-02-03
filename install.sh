printf "$BLUE"
printf "Do you want to copy over dot files? y/n"
read response
if [ "$response" == "y" ]; then
	rm ~/.*rc
	rm ~/.*conf
	ln -s ~/.oh-my-zsh/.*rc $HOME
	ln -s ~/.oh-my-zsh/.*conf $HOME
fi
gem install colorls
mkdir ~/bin/
git submodule update --init --recursive
ln -s $ZSH/custom/plugins/wenv/wenv ~/bin/wenv
chmod +x ~/bin/wenv
mkdir -p $WENV_CFG/wenvs

ln -s $ZSH/custom/plugins/wenv/{template,extensions} "$WENV_CFG"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

unameOut="$(uname -s)"
case "${unameOut}" in
        Linux*) echo "setup install of taskwarrior and tmux";;
        Darwin*)
		brew install task
		brew install tmux
		brew cask install background-music
	;;
        MINGW*)  echo "setup isntall of taskwarrior and tmux";;
esac

mkdir $HOME/.task/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "$BLUE"
printf "Do you want to copy over dot files? y/n"
read response
if [ "$response" == "y" ]; then
	rm $HOME/.*rc
	rm $HOME/.*conf
	ln -s $HOME/.oh-my-zsh/.*rc $HOME
	ln -s $HOME/.oh-my-zsh/.*conf $HOME
fi
mkdir $HOME/bin/
cp custom/bin/* $HOME/bin/.
git submodule update --init --recursive
ln -s $ZSH/custom/plugins/wenv/wenv $HOME/bin/wenv
chmod +x $HOME/bin/wenv
mkdir -p $WENV_CFG/wenvs

ln -s $ZSH/custom/plugins/wenv/{template,extensions} "$WENV_CFG"
git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
sh $HOME/.vim_runtime/install_awesome_vimrc.sh

pip install virtualenvwrapper
git clone git://github.com/mbrubeck/compleat.git
curl -sSL https://get.haskellstack.org/ | sh
cd compleat && make install

unameOut="$(uname -s)"
case "${unameOut}" in
        Linux*) echo "setup install of taskwarrior and tmux"
            sudo apt-get install ansiweather tmux python taskwarrior bash-completion ruby-full
            sudo gem install colorls
            ;;
        Darwin*)
		brew install task
		brew install tmux
		brew cask install background-music
        gem install colorls
	;;
        MINGW*)  echo "setup isntall of taskwarrior and tmux";;
esac

mkdir $HOME/.task/
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

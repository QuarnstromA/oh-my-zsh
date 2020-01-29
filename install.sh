printf "$BLUE"
printf "Do you want to copy over dot files? y/n"
read response
if [ "$response" == "y" ]; then
	rm ~/.*rc
	rm ~/.*conf
	ln -s ~/.oh-my-zsh/.*rc $HOME
	ln -s ~/.oh-my-zsh/.*conf $HOME
fi

mkdir ~/bin/
git submodule update --init --recursive
ln -s $ZSH/custom/plugins/wenv/wenv ~/bin/wenv
chmod +x ~/bin/wenv
mkdir -p $WENV_CFG/wenvs

ln -s $ZSH/custom/plugins/wenv/{template,extensions} "$WENV_CFG"

unameOut="$(uname -s)"
case "${unameOut}" in
        Linux*) echo "setup install of taskwarrior and tmux";;
        Darwin*)
		brew install task
		brew install tmux
	;;
        MINGW*)  echo "setup isntall of taskwarrior and tmux";;
esac

mkdir $HOME/.task/

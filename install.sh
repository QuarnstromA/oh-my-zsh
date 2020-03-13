

dot_files()
{
	printf ${BLUE}"Do you want to copy over dot files? y/n"${RESET}
	read response
	if [ "$response" == "y" ]; then
		rm $HOME/.*rc
		rm $HOME/.*conf
		ln -s $HOME/.oh-my-zsh/.*rc $HOME
		ln -s $HOME/.oh-my-zsh/.*conf $HOME
	fi
}

init()
{
	dot_files
	git submodule update --init --recursive
	create_dirs
	copy_files
}

create_dirs()
{
	mkdir $HOME/bin/
	chmod +x $HOME/bin/wenv
	mkdir -p $WENV_CFG/wenvs
	mkdir $HOME/.task/
}

copy_files()
{
	cp custom/bin/* $HOME/bin/.
	ln -s $ZSH/custom/plugins/wenv/wenv $HOME/bin/wenv
}

install_compleat()
{
	git clone git://github.com/mbrubeck/compleat.git
	curl -sSL https://get.haskellstack.org/ | sh
	cd compleat && make install
	rm -rf compleat
}

install()
{
	ln -s $ZSH/custom/plugins/wenv/{template,extensions} "$WENV_CFG"
	git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
	sh $HOME/.vim_runtime/install_awesome_vimrc.sh
	echo "set nu" >> ~/.vimrc
	pip install virtualenvwrapper
	install_compleat
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
}

install_host_specific
{
	unameOut="$(uname -s)"
	case "${unameOut}" in
        Linux*)
            sudo apt-get install ansiweather tmux python taskwarrior bash-completion ruby-full
            sudo gem install colorls
		;;
        Darwin*)
			brew install task
			brew install tmux
			brew cask install background-music
			gem install colorls
		;;
        MINGW*)
        	echo "setup isntall of taskwarrior and tmux"
		;;
	esac
}


echo ${RED}"Setting "${BLUE}"up "${YELLOW}"Custom "${GREEN}"ZSH"${RESET}
init
install
install_host_specific

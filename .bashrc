source ~/.workrc
export LS_OPTIONS=-aGhlp
export PATH=$PATH:~/.local/bin/:~/bin/
export AWS_PROFILE=default
export ANT_HOME=/Users/anthony.quarnstrom/bin/ant
export PATH=$PATH:$ANT_HOME/bin
export BAT_THEME="zenburn"
alias python=/usr/local/bin/python3
alias pip=pip3
alias sshh=ssh-connect
alias cat=bat

env=~/.ssh/agent.env
#(ansiweather&)

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running; then
    agent_load_env
fi

# if your keys are not stored in ~/.ssh/id_rsa or ~/.ssh/id_dsa, you'll need
# to paste the proper path after ssh-add
if ! agent_is_running; then
    agent_start
    ssh-add ~/.ssh/bbcom-mac
elif ! agent_has_keys; then
    ssh-add ~/.ssh/bbcom-mac
fi

unset env

aws-login()
{
	aws-adfs login --adfs-host=sts.bodybuilding.com/adfs/ls/IdpInitiatedSignOn.aspx --authfile=/Users/anthony.quarnstrom/.auth/adfs --profile=default
	export AWS_PROFILE=default

	aws ecr get-login --region us-west-2 | sed -e 's/-e none//' | source /dev/stdin
}


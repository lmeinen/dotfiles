# place custom functions here (can e.g. be used for custom aliases)

function dlogs() {
	remote=$1
	container=$2
	connect ub

	trap '__vpn_cleanup 2' SIGINT

	DOCKER_HOST=ssh://$remote docker logs -f -n 100 $container | bat --paging=never -l log
}

# Set up a cleanup function to be triggered upon script exit
__vpn_cleanup()
{
    SIGNAL=$1

    if nmcli con show --active | grep --quiet -E 'wireguard\s+ub' ; then
	    disconnect ub;
    fi

    # when this function was called due to receiving a signal
    # disable the previously set trap and kill yourself with
    # the received signal
    if [ -n "$SIGNAL" ]
    then
        trap $SIGNAL
        kill -${SIGNAL} $$
    fi
}

function up_and_down() {
    echo "Setting up VPN connection..."
    connect ub
    echo ""

    if nmcli con show --active | grep --quiet -E 'wireguard\s+ub' ; then
        echo "Tearing down VPN connection..."
	    disconnect ub
    fi
}

function volley_fr() {
	pushd $HOME/repos/asvz-bot/src
	source $HOME/repos/asvz-bot/src/.venv/bin/activate
	python $HOME/repos/asvz-bot/src/asvz_bot.py training \
		--weekday "Fr" \
  		--start-time "19:15" \
  		--trainer "Lucy Haller" \
  		--level "Fortgeschrittene" \
  		--facility "Sport Center Polyterrasse" \
  		45743
	deactivate
	popd
}

function volley_mo() {
	pushd $HOME/repos/asvz-bot/src
	source $HOME/repos/asvz-bot/src/.venv/bin/activate
	python $HOME/repos/asvz-bot/src/asvz_bot.py training \
		--weekday "Mo" \
  		--start-time "18:00" \
  		--trainer "Kai Zeglen" \
  		--level "Mittlere" \
  		--facility "Sport Center Hönggerberg" \
  		45743
	deactivate
	popd
}

function pretty() {
	python -m json.tool < $1 | bat -l json
}

function gobra_cleanup() {
	bash 
}

function gobra_cleanup() {
	bash $ADEM/gobra-post.sh
}

function gobra() {
	ADEM="$HOME/uni/thesis/adem-gobra"

	if [[ "$*" == *"--help"* || "$*" == *"-h"* ]]
	then
    		java -jar -Xss128m $HOME/repos/gobra/target/scala-2.13/gobra.jar \
			--help
		return
	fi

	trap gobra_cleanup EXIT

	if [ ! -d /tmp/gobra_out ]; then
		mkdir /tmp/gobra_out
	fi

	bash $ADEM/gobra-pre.sh

	java -jar -Xss128m $HOME/repos/gobra/target/scala-2.13/gobra.jar \
		--gobraDirectory /tmp/gobra_out \
		--include $ADEM $ADEM/gobstubs \
		--module github.com/adem-wg/adem-proto/ \
		--noStreamErrors \
		--parallelizeBranches \
		--z3Exe /usr/bin/z3 \
		--onlyFilesWithHeader \
		--projectRoot $ADEM/pkg \
		--recursive \
		"${@:1}"
}

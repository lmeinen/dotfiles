# place custom functions here (can e.g. be used for custom aliases)

function stopwatch() {
	start=$(date +%s)
	while true; do
 		time="$(($(date +%s) - $start))"
 		printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
	done
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

# Switch alacritty between light and dark mode
function dark() {
        ln -fs $HOME/.config/alacritty/themes/solarized_dark.toml $HOME/.config/alacritty/themes/_active.toml
        touch $HOME/.config/alacritty/alacritty.toml
}

function light() {
        ln -fs $HOME/.config/alacritty/themes/solarized_light.toml $HOME/.config/alacritty/themes/_active.toml
        touch $HOME/.config/alacritty/alacritty.toml
}

function layout_vert_a() {
	swaymsg 'output eDP-1 pos 0 1200' ; swaymsg 'output DP-1 pos 0 0'
}

#!/bin/sh

nocolor() { sed -e "$(printf 's/\033%s//g' '\[[0-9;]*[mK]')"; }

case "$0" in
	(*'/nocolor.sh') nocolor ;;
esac

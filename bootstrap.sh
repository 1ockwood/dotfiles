#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# Make sure repo is up to date
git pull origin master;

# Copy fonts to system folder
rsync --exclude ".DS_Store" -avh --no-perms fonts/. ~/Library/Fonts/

function doIt() {
	rsync --exclude ".git/" \
		--exclude "apps/" \
		--exclude "fonts/" \
		--exclude ".DS_Store" \
		--exclude ".apps" \
		--exclude ".macos" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

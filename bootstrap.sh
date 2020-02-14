#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# Make sure repo is up to date
git pull origin master;

# Copy fonts to system folder
rsync --exclude ".DS_Store" -avh --no-perms resources/fonts/. ~/Library/Fonts/

function copy_files() {
	rsync --exclude ".git/" \
    --exclude "helpers/" \
    --exclude "resources/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	copy_files;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copy_files;
	fi;
fi;
unset copy_files;

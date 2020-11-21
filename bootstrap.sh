#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

# Make sure repo is up to date
git pull origin master

copy_files() {
  # Copy dotfiles
  rsync --exclude ".git/" \
  --exclude ".nvm/" \
  --exclude "helpers/" \
  --exclude ".DS_Store" \
  --exclude "bootstrap.sh" \
  --exclude "README.md" \
  -avh --update --no-perms . ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]
then
  copy_files
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    copy_files
  fi
fi

unset copy_files

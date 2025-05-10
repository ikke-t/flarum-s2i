#!/bin/sh

[ -z "$(ls -A $HOME/storage)" ] && \
  tar xzvf /var/tmp/s2i-volume-save.tgz -C $HOME 'storage/*' || \
  echo "Storage not empty, skip restore"
[ -z "$(ls -A $HOME/public/assets)" ] && \
  tar xzvf /var/tmp/s2i-volume-save.tgz -C $HOME 'public/assets/*' || \
  echo  "Assets not empty, skip restore"

echo "You can find build time files for volumes in /var/tmp/s2i-volume-save.tgz."
echo "E.g. after installing new plugins or update, you might want to apply"
echo "those to run time using tar xzvf /var/tmp/s2i-volume-save.tgz -C $HOME."

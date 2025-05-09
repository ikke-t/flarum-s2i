#!/bin/sh

[ "$(ls -A $HOME/storage)" ] && tar xzf /var/tmp/s2i-volume-save.tgz -C $HOME storage 
[ "$(ls -A $HOME/public/assets)" ] && tar xzf /var/tmp/s2i-volume-save.tgz -C $HOME public/assets


#!/sbin/sh
#
# This leverages the loki_patch utility created by djrbliss
# See here for more information on loki: https://github.com/djrbliss/loki
#
#Extracts boot.img from patched file

/tmp/loki/loki_tool unlok /tmp/boot.lok /tmp/boot.img || exit 1
exit 0

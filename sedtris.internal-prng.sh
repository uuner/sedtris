#!/usr/bin/env bash
# Bash script to make playing Sedtris more comfortable.
# It presses "enter" automatically once in a second and after
# every player's move.
#
# It also creates a random seed for the internal PRNG to improve gameplay.
#
# Based on playsed.sh by Aurelio Marinho Jargas http://sed.sf.net/grabbag/scripts/playsed.sh.txt

mytime="`date +%s`"

IFS=''
CMD=''
TMP=''

cat /dev/urandom | tr -dc "01" | fold -w 18 | head -1 > seed.txt

export LC_ALL="C"
(while true;
do
  read -s -t 1 -n 1 TMP
  RES=$?
  CMD="$CMD$TMP"
  if [ "$CMD" == '' ]
  then
    read -s -n 1 TMP; CMD="$CMD$TMP";
    if [ "$CMD" == '[' ]
    then
      read -s -n 1 TMP; CMD="$CMD$TMP";
    fi
  fi
  if [ $RES -eq 0 ]
  then
    echo "$CMD"
  fi
  CMD=''
  TMP=''
  mytimenew="`date +%s`"
  if [ "$mytimenew" != "$mytime" ]
  then
    echo
	mytime=$mytimenew
  fi
done) | cat seed.txt - | sed -nf `dirname $0`/sedtris.sed

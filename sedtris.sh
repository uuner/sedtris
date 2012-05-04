#!/usr/bin/env bash
# Bash script to make playing Sedtris more comfortable.
# It presses "enter" automatically once in a second and after
# every player's move. It also adds an invisible random input 
# to improve randomness.
#
# Based on playsed.sh by Aurelio Marinho Jargas http://sed.sf.net/grabbag/scripts/playsed.sh.txt

mytime="`date +%s`"

IFS=''
CMD=''
TMP=''

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

  	let "temp=($RANDOM/10)%7"
	if [ $temp == 1 ]
	then
		echo $temp
	else
		echo
	fi
	mytime=$mytimenew
  fi
done) | sed -nf `dirname $0`/sedtris.sed

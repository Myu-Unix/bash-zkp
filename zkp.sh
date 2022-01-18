#!/bin/bash

var0=BlueBall
var1=RedBall
trust=0 # Base trust starts at 0 (on a 100 scale)
good_answer=0

while [ 1 ]
do
echo && echo
echo "Trust : $trust/100"
echo "Alice doesn't know which ball is Blue and which is Red, only if she swapped them or not"
echo "Alice will first pick a ball at random and reveal it to you"
myrand=$(( $RANDOM % 2 ))
#echo $myrand

if [ $myrand -eq 0 ]
then
 echo "--> $var0"
else
  echo "--> $var1"
fi

echo "Alice will now **swap or not swap** the ball and reveal it to you"
myrand2=$(( $RANDOM % 2 ))

if [ $myrand2 -eq 0 ]
then
 swapped=0
 if [ $myrand -eq 0 ]
 then
   echo "--> $var0"
 else
   echo "--> $var1"
 fi
else
  swapped=1
 if [ $myrand -eq 0 ]
 then
   echo "--> $var1"
 else
   echo "--> $var0"
 fi
fi

echo "Did Alice swap the balls ? (0 = no, 1 = yes)"
read answer
#echo Answer : $answer
#echo swapped : $swapped
if [ $answer == $swapped ]
then
  echo "Alice agrees, trust improved"
  ((good_answer++))
  trust=$((100-(100/($good_answer*2))))
else
  echo "Alice disagrees, trust decreases"
  if [ $good_answer -eq 0 ]
  then
    echo # nothing, we already at 0
  else
  ((good_answer--))
  trust=$((100-(100/($good_answer*2))))
  fi
fi

if [ $trust -ge 99 ]
then
  echo "Proof achieved, Alice trust you that you can differenciate the 2 balls"
  echo "but you never revealed which is which to her, only if she swapped them"
  exit 0
fi
done

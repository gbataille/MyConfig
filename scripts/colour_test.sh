#!/bin/zsh
echo "\e[1;37;40mColors and modes\e[0;37;40m"
echo ""

echo "\e[1;37;40mNormal\e[0;37;40m"
x=0
for i in {30..37}; do
    for a in {40..47}; do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
    done
    echo ""
done
echo ""
echo "\e[1;37;40mBright\e[0;37;40m"
x=1
for i in {30..37}; do
    for a in {40..47}; do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
    done
    echo ""
done
echo ""
echo "\e[1;37;40mDim\e[0;37;40m"
x=2
for i in {30..37}; do
    for a in {40..47}; do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
    done
    echo ""
done
echo ""
echo "\e[1;37;40mUnderlined\e[0;37;40m"
x=4
for i in {30..37}; do
    for a in {40..47}; do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
    done
    echo ""
done
echo ""
echo "\e[1;37;40mBlink\e[0;37;40m"
x=5
for i in {30..37}; do
    for a in {40..47}; do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
    done
    echo ""
done
echo ""
echo "\e[1;37;40mReverse\e[0;37;40m"
x=7
for i in {30..37}; do
    for a in {40..47}; do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
    done
    echo ""
done

echo ""
echo "\e[1;37;40m256 colors mode\e[0;37;40m"
for i in {0..32} ; do
  for j in {1..8} ; do
    (( k = i * 8 + j ))
    echo -ne "\x1b[38;5;${k}mcolour${k} "
  done
  echo ""
done
echo ""

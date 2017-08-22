# Installs all the listed packages needed for python numerical
# solving of mathematical problems, the fenics FEM-solver as well 
#as everything needed for the creation of latex files.
#
# Also installs the oh-my-zsh which is a nice shell for ubuntu, but require
# some config files (available in this repo) to be placed in home-folder.
# Theese come with some standard settings for vim and zsh.
# Please remove the corresponding lines if this is not of interest.

#!/bin/bash
sudo_stat=sudo_status.txt
log=NotInstalled.txt

apt_install() {
  sudo apt-get -y install $1
  if [ $? -ne 0 ]; then
    echo "could not install $1 - abort"
    echo "$1 not installed" >> log
  fi
}

echo $$ >> $sudo_stat
trap 'rm -f $sudo_stat >/dev/null 2>&1' 0
trap "exit 2" 1 2 3 15

sudo_me() {
 while [ -f $sudo_stat ]; do
  echo "checking $$ ...$(date)"
  sudo -v
  sleep 60
 done &
}

echo "=setting up sudo heartbeat="
sudo -v
sudo_me

# Custom Repositorys
sudo add-apt-repository -y ppa:fenics-packages/fenics

sudo apt-get -y update --fix-missing
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

# Personal
apt_install wallch
apt_install lm-sensors
apt_install rar
apt_install unity-tweak-tool
apt_install trash-cli
apt_install cowsay
apt_install fortune

# Compilers
apt_install gcc
apt_install g++
apt_install f2c

# Version control system tools
apt_install git
apt_install meld

# Python
apt_install ipython
apt_install bpython
apt_install python-dev
apt_install python-numpy
apt_install python-sympy
apt_install python-scipy
apt_install python-pytest
apt_install python-progressbar
apt_install python-pip
apt_install cython
apt_install swig
apt_install gmsh
apt_install fenics

# Plotting and visualization programs
apt_install paraview
apt_install mayavi2
apt_install python-matplotlib
apt_install gimp

# LaTeX
apt_install texlive
apt_install texlive-extra-utils
apt_install texlive-latex-base
apt_install texlive-latex-recommended
apt_install texlive-latex-extra
apt_install texlive-math-extra
apt_install texlive-font-utils

# Cleanup
sudo apt-get -y autoclean
sudo apt-get -y autoremove

# finish sudo loop
rm $sudo_stat
echo "Everything went smoothly, Check log for things that did not install"

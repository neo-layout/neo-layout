#!/bin/sh
# installing the neo_yaml-dependencies: python >= 3.0, pyyaml >= 3.08
cd ~
# sudo pacman -Sy python3 # arch linux example
wget http://pyyaml.org/download/pyyaml/PyYAML-3.08.tar.gz
tar xzf PyYAML-3.08.tar.gz
rm PyYAML-3.08.tar.gz
# svn co http://svn.pyyaml.org/pyyaml/trunk PyYAML-3.08 # alternative to the 3
# commands above
cd PyYAML-3.08
sudo python3 setup.py install
cd ..
rm -r PyYAML-3.08

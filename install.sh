#!/bin/bash
clear
echo "
#################################################################
# SLIM-TWEAK install script, by William Rueger (furryfixer)
# You must run with sudo or as ROOT! By installing this software,
# you are accepting the benefits and limitations of the 
# GPL 3 license. 
#################################################################"
echo "
Do you wish to continue?

Press [y/n] and <ENTER>."
read yn
[[ $yn != [Yy] ]] && exit 1
# user must be root
if [ "$(id -u)" != "0" ]; then
   echo "Installation must be run as root. Exiting" 1>&2
   exit 1
fi
echo "Installing slim-tweak...
"
if [[ ! -f slim-tweak || ! -f slim-untweak ]]; then
	echo "install.sh must be run from within directory
containing BOTH slim-tweak and slim-untweak.
One or both files not found in $(pwd). Run 
install.sh from directory containing them.
  
Exiting...
"
	exit 1
fi
# Check PATH
if grep -q "/usr/local/bin" <<< $PATH; then
	prefix="/usr/local/bin"
	mkdir -p /usr/local/bin
else
	echo "
\"/usr/local/bin\" is not in System \$PATH
Executable files will be placed in \"/usr/bin\" instead.

Press <Enter> key to continue."
read a
	prefix="/usr/bin"
fi
echo "
Copying new files..."
cp -v slim-tweak $prefix/
cp -v slim-untweak $prefix/
chmod -v 0744 $prefix/slim-tweak
chmod -v 0744 $prefix/slim-untweak
echo "
slim-tweak installation sucessfully completed.

Run from terminal window or console by typing
\"sudo slim-tweak\".

You may reverse mods made by slim-tweak by running
the included \"slim-untweak\" script. 

To uninstall, run \"slim-untweak\" first, then simply
remove slim-tweak and slim-untweak files
from /usr/local/bin or /usr/bin
"

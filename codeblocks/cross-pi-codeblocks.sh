#!/bin/bash
echo "   "
echo "Code::Blocks install alternatives:"
echo "   0: Quit, do nothing"
echo "   1: Install from Ubuntu repository (fast, but old version) + generate Code::Blocks config"
echo "   2: Build from source code (slower, but up to date version)  + generate Code::Blocks config"
echo "   3: Generate Code::blocks config only"
echo "   "
echo "   Warning: any existing Code::Blocks config will be backed up and replaced"
echo "   "
read -p "Your choice [0..3]? " choice
INSTALL_OPTION=0;
case "$choice" in 
  1 ) INSTALL_OPTION=1 ;;
  2 ) INSTALL_OPTION=2 ;;
  3 ) INSTALL_OPTION=3 ;;
  * ) echo "Cancelling" ;;
esac

case $INSTALL_OPTION in
   1 ) sudo apt-get install codeblocks codeblocks-contrib ;;
   2 ) source ./cross-pi-cb-build-from-source.sh ;;
   3 ) : ;;
   * ) echo "Not installing Code::Blocks" ; exit 0 ;;
esac 


if (( INSTALL_OPTION > 0 )) ; then

   #install codeblocks configuration file with preconfigured cross-compiler
   mkdir -p $HOME/.config
   mkdir -p $HOME/.config/codeblocks
   CONFIG_FILE=$HOME/.config/codeblocks/default.conf 

   echo " "
   echo "Creating Code::Blocks config file"
    
   # Check to see if we need to back up any existing config file
	if [ -f "$CONFIG_FILE" ]; then
      current_time=`date "+%Y%m%d_%H%M%S"`
      CONFIG_BACKUP="default_$current_time.config"	

      echo " "
      echo    "*** Code::Blocks config file already exists: $CONFIG_FILE"
      echo -n "    Creating backup copy: " cp -v $CONFIG_FILE $CONFIG_BACKUP
      echo " "
	fi
	
	cp ./default_template.conf  $CONFIG_FILE
	
	# replace /home/ABCD with current user name in $CONFIG_FILE
	FROM="/home/ABCD"
	TO="$HOME"
	sed -i "s#$FROM#$TO#g" $CONFIG_FILE	 
   
   echo " "
   echo "New configuration created: $CONFIG_FILE"
   echo "Code::Blocks is now configured to use cross-compiler"
fi

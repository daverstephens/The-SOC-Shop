#!/bin/bash

################################################################################
#CONSTANTS
################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

################################################################################
#FUNCTIONS
################################################################################

function red_text(){ #string
	echo -e "\e[0;31m""$1""\e[0m"
}

function green_text(){ #string
	echo -e "\e[0;32m""$1""\e[0m"
}

function bold_text(){
	echo -e "\e[1m""$1""\e[0m"
}

function Selector(){ #CONTENTSTRING $CONTENTARRAY
	#simple function to give you selection menu
	#with minor error checking.
	local INITVAL=0
	unset X

	while [[ $X != 1 ]]; do
		local ARRAYINDEX=$INITVAL
		echo -e $1
		for i in ${!2}; do
			local ARRAYINDEX=$[$ARRAYINDEX+1]
			echo $ARRAYINDEX - $i
		done
		echo -e "\nPlease select the appropriate numeric option."
		read INPUT
		local LOCALINPUT=$INPUT
		unset INPUT

		if [[ $LOCALINPUT -gt $INITVAL ]] && [[ $LOCALINPUT -le $ARRAYINDEX ]]; then X=1
		else red_text "Please select a valid option.\n"; fi
	done
	local LOCALINPUT=$[$LOCALINPUT-1] #the array starts at 0, so we have to account for that.
	return $LOCALINPUT
}	

function CheckDependency(){ #PROGRAMNAME
	local EXITVAL=1

	echo -e "Checking Dependencies..."
	
	for i in $@; do
		which $i > /dev/null
		if [[ $? != 0 ]]; then 
			red_text "You do not have $i installed.\n"
			local MISSINGDEP=1
		fi
	done
	
	#this is convoluted, but it the return value should always start as a fail 
	#and becomes positive.
	if [[ $MISSINGDEP != 1 ]]; then 
		local EXITVAL=0

		echo -e "Dependencies met."
	fi 
	
	if [[ $EXITVAL == 1 ]]; then
		echo -e "Please fix the missing dependencies\n"		
		red_text "The script will now exit."
		exit
	fi
}

function HTMLMakeIndex(){ #$FULLINDEXPATH
	echo "<html>" > $1
	echo -e "\t<body>" >> $1
}

function HTMLTableOpen(){ #$FULLINDEXPATH
	echo -e "\t\t<table>" >> $1
}

function HTMLHeading(){ #$FULLINDEXPATH $CONTENT
	echo -e "\t\t<h1>$2</h1>" >> $1
}

function HTMLParagraph(){ #$FULLINDEXPATH $CONTENT
	echo -e "\t\t<p>$2</p>" >> $1
}

function HTMLTableClose(){ #$FULLINDEXPATH
	echo -e "\t\t</table>" >> $1
}

function HTMLTableRow(){ #$FULLINDEXPATH $CONTENTTITLE $CONTENTS
	#creates a table row
	echo -e "\t\t\t<tr>" >> $1
	echo -e "\t\t\t\t<td>$2</td>" >> $1
	echo -e "\t\t\t\t<td>$3</td>" >> $1
	echo -e "\t\t\t</tr>" >> $1
}

function HTMLCloseIndex(){ #$FULLINDEXPATH
	echo -e "\t</body>" >> $1
	echo "</html>" >> $1
}

function ReadIsInt(){ #INPUT
	local X=1
	if [[ $1 =~ ^-?[0-9]+$ ]]; then local X=0; 
	else 
		red_text "Please enter a number."
		echo "Press any key to continue..."
		read
		clear
	fi
	return $X
}

function UsageInstructions(){ #ARGS #EXPECTEDARGS #WELCOMETEXT #EXPECTEDARGNAMES
	#Quick and dirty check to ensure the script is at least provided 
	#with the right number of arguments.
	if [[ $1 != $2 ]]; then 
		echo "Usage: $0 $4"	
		exit
	else
		bold_text $3
	fi
}


################################################################################
#USAGE EXAMPLES
################################################################################

#red_text "hello world"
#green_text "hello world"

###Selection Screen

#IFS=$'\n'
#STR="Test string"
#ARR[${#ARR[@]}]="array value 1"
#ARR[${#ARR[@]}]="array value 2"

#Selector $STR ARR[@]

###Dependency Checker.

#PROGRAM="/bin/bash0r"
#PROGRAM[${#PROGRAM[@]}]="/bin/bash9r"
#PROGRAM[${#PROGRAM[@]}]="/bin/bash"
#CheckDependency ${PROGRAM[@]}

#UsageInstructions $# 1 "this is my program" '$INCIDENT $ANALYST $DATE'


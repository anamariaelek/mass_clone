#! /bin/sh
# This file is for pushing graded assignments to GitHub Classroom repositories
# It will add all new files and commit them with a given message
# It requires the folder name and a message


if [[ $# -ne 2 ]] && [[ $# -ne 1 ]];
	then
	echo "This script requires 2 parameters."
	echo "1. The name of the folder that the assignments are in."
	echo "2. Optionally, the commit message."
	echo "   If not provided, the default message is ""Graded [date] [time]""."
else
	if [[ $# -ne 2 ]]; 
		then
		date=`date +%m-%d-%Y`
		time=`date +%H:%M:%S`
		message="Graded $date $time"
	else
		message=$2
	fi
	assignment=$1
	for f in ../${assignment}/*; do
		if [[ -d "$f" ]]; then
			cd $f
			if [[ -d .git ]]; then
				echo ""
				echo "$f git status:"
				git status
				echo ""
				echo "Staging changes in $f:"
				git add -A
				git commit -m "$message"
			else
				echo "Skipping directory $f - not a git repo."
			fi
			cd ..
		elif [[ -f "$f" ]]; then
			echo "Skipping file $f."
		fi
	done
fi


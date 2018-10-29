#! /bin/sh
# This file is for pushing graded assignments to GitHub Classroom repositories
# It will push local commits to remote specified by the user
# It requires the folder name and the remote name


if [[ $# -ne 2 ]] && [[ $# -ne 1 ]] ;
	then
	echo "This script requires following parameters."
	echo "1. The folder name the assignments are in."
	echo "2. Optionally, the remote name to push to - if omitted, the default is origin"
else
	assignment=$1
	for f in ../${assignment}/*; do
		if [[ -d "$f" ]]; then
			cd $f
			if [[ -d .git ]] ; then
				echo "Pushing commits in $f"
				git push $remote ${2:-origin}
			else
				echo "Skipping directory $f - not a git repo."
			fi
			cd ..
		elif [[ -f "$f" ]]; then
			echo "Skipping file $f."
		fi
	done
fi

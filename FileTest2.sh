#!/bin/sh
folder="$HOME"/mydir/git-sources
echo "$folder"
if [ ! -d "$folder" ]
then
	echo "create folder"
	mkdir $folder
fi
cd $folder
printf "Gitsource: "
read -r gitsource
git clone "$gitsource"
unset gitsource
echo "Done!"
echo "*******************"
foldercopy="$HOME"/mydir/copy
if [ ! -d "$foldercopy" ]
then
	echo "create foldercopy"
	mkdir $foldercopy
fi

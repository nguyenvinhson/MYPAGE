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
echo "copy source git"
cp -R $folder $foldercopy
echo "Done copy!"
resources="https://github.com/nguyenvinhson/demo-create-project.git"
foldertemp=${resources##*/}
project=${foldertemp%.*}
echo "$project"
cd $folder
cd $project
echo "create file"
vi filename.sh
echo "copy source git"
cp -R $folder $foldercopy
echo "Done copy!"
resources="https://github.com/nguyenvinhson/demo-create-project.git"
foldertemp=${resources##*/}
project=${foldertemp%.*}
echo "$project"
cd $folder
cd $project
echo "create file"
vi filename.sh
echo "copy source git"
cp -R $folder $foldercopy
echo "Done copy!"
resources="https://github.com/nguyenvinhson/demo-create-project.git"
foldertemp=${resources##*/}
project=${foldertemp%.*}
echo "$project"
cd $folder
cd $project
echo "create file"
vi filename.sh

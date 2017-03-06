#!/bin/sh
backup_dir=env_backup_`date +%Y%m%d%H%M%S`
echo $backup_dir
mkdir ${HOME}/${backup_dir}

make_backup ()
{
    if [ -e "$1" ]
    then
	mv -v "$1" ${HOME}/${backup_dir}/
    fi
}

make_backup ${HOME}/.Xresources
make_backup ${HOME}/.emacs
make_backup ${HOME}/.fvwm
make_backup ${HOME}/.conkyrc

cp -v ./.Xresources ${HOME}/.Xresources
cp -v ./.emacs ${HOME}/.emacs
cp -v ./.conkyrc ${HOME}/.conkyrc
ln -s `pwd` ${HOME}/.fvwm


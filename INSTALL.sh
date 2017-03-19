#!/bin/sh
BASEDIR=`dirname $(readlink -f $0)`
BACKUPDIR=env_backup_`date +%Y%m%d%H%M%S`

echo $BACKUPDIR
mkdir ${HOME}/${BACKUPDIR}

make_backup ()
{
    if [ -e "$1" ]
    then
	mv -v "$1" ${HOME}/${BACKUPDIR}/
    fi
}

install_component ()
{
    if [ -e "$1" ]
    then
	cp -rv $1 $2
    fi

}

make_backup ${HOME}/.Xresources
make_backup ${HOME}/.emacs
make_backup ${HOME}/.fvwm
make_backup ${HOME}/.conkyrc

mkdir ${HOME}/.fvwm
mkdir ${HOME}/.fvwm/icons
mkdir ${HOME}/.fvwm/backgrounds

install_component ${BASEDIR}/.Xresources ${HOME}/.Xresources
install_component ${BASEDIR}/.emacs ${HOME}/.emacs
install_component ${BASEDIR}/.conkyrc ${HOME}/.conkyrc
install_component ${BASEDIR}/scripts ${HOME}/.fvwm/
install_component ${BASEDIR}/config ${HOME}/.fvwm/

chmod u+x ${HOME}/.fvwm/scripts/*

if [ ! -d ${HOME}/.fonts ]
then
    mkdir ${HOME}/.fonts
fi

wget https://fontlibrary.org/assets/downloads/lcd/0bbb50971deb300331139c65b16b37c8/lcd.zip -O ${HOME}/.fonts/lcd.zip
wget https://fontlibrary.org/assets/downloads/xolonium/e00c124f3e1b130e5ec2a7eee2f4f1b8/xolonium.zip -O ${HOME}/.fonts/xolonium.zip

for i in ${HOME}/.fonts/*.zip
do
    unzip "$i" -d ${HOME}/.fonts/
done

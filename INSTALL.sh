#!/bin/sh
BASEDIR=`dirname $(readlink -f $0)`
BACKUPDIR=env_backup_`date +%Y%m%d%H%M%S`
E_NODEST=95

if [ -z "$1" ]
then
    DESTINATION=${HOME}
else
    DESTINATION=$1
fi

echo $BACKUPDIR
echo $DESTINATION

if [ ! -d $DESTINATION ]
then
    echo "Destination directory $DESTINATION not found"
    exit $E_NODEST
fi

mkdir ${DESTINATION}/${BACKUPDIR}

make_backup ()
{
    if [ -e "$1" ]
    then
	mv -v "$1" ${DESTINATION}/${BACKUPDIR}/
    fi
}

install_component ()
{
    if [ -e "$1" ]
    then
	cp -rv $1 $2
    fi

}

make_backup ${DESTINATION}/.Xresources
make_backup ${DESTINATION}/.emacs
make_backup ${DESTINATION}/.fvwm
make_backup ${DESTINATION}/.conkyrc

mkdir ${DESTINATION}/.fvwm
mkdir ${DESTINATION}/.fvwm/icons
mkdir ${DESTINATION}/.fvwm/backgrounds

install_component ${BASEDIR}/.Xresources ${DESTINATION}/.Xresources
install_component ${BASEDIR}/.emacs ${DESTINATION}/.emacs
install_component ${BASEDIR}/.conkyrc ${DESTINATION}/.conkyrc
install_component ${BASEDIR}/scripts ${DESTINATION}/.fvwm/
install_component ${BASEDIR}/config ${DESTINATION}/.fvwm/

chmod u+x ${DESTINATION}/.fvwm/scripts/*

if [ ! -d ${DESTINATION}/.fonts ]
then
    mkdir ${DESTINATION}/.fonts
fi

wget https://fontlibrary.org/assets/downloads/lcd/0bbb50971deb300331139c65b16b37c8/lcd.zip -O ${DESTINATION}/.fonts/lcd.zip
wget https://fontlibrary.org/assets/downloads/xolonium/e00c124f3e1b130e5ec2a7eee2f4f1b8/xolonium.zip -O ${DESTINATION}/.fonts/xolonium.zip
wget https://fontlibrary.org/assets/downloads/pfennig/8b5fa73ca4cf4cfa42d21b9f73f6060b/pfennig.zip -O ${DESTINATION}/.fonts/pfennig.zip
wget https://fontlibrary.org/assets/downloads/libertinus-sans/1123c9f83b4e5c15919633f318094b1c/libertinus-sans.zip -O ${DESTINATION}/.fonts/libertinus-sans.zip
wget https://fontlibrary.org/assets/downloads/liberation-sans/2b246ab94ea322ca5282dfd1a39c36ec/liberation-sans.zip -O ${DESTINATION}/.fonts/liberation-sans.zip

for i in ${DESTINATION}/.fonts/*.zip
do
    unzip "$i" -d ${DESTINATION}/.fonts/
done

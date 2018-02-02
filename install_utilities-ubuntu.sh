add-apt-repository ppa:webupd8team/java
add-apt-repository ppa:pipelight/stable
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E0F72778C4676186
wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
apt-get update
apt-get upgrade
apt-get install synaptic ubuntu-restricted-extras vlc hplip vim oracle-java7-installer adobe-flashplugin build-essential checkinstall cdbs devscripts dh-make fakeroot libxml-parser-perl check avahi-daemon wine playonlinux netflix-desktop -y

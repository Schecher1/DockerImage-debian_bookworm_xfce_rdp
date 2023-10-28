#set default values if the environment variables are not provided
ENV USER_PASSWORD=changeme

#use the debian bookworm image
FROM debian:bookworm

#update all package directories
RUN apt update 

#install all needed programs like 
#XFCE for UI 
#xrdp for connecting via RemoteDesktop
#dbus-x11 for that you can connect to the desktop at all (otherwise the connection will crash after login)
#xfce4-goodies for the Xfce4 Desktop Environment (https://packages.debian.org/de/sid/xfce4-goodies)
RUN apt install -y xrdp xfce4 dbus-x11 

#install usefull tools like: nano, wget, curl and sudo
RUN apt install -y nano wget curl sudo

#FIX: removed the annoying screen "Plugin "Power Manager Plugin" unexpectedly left the panel, do you want to restart it?"
RUN apt remove xfce4-power-manager-plugins -y

#clean up
RUN apt clean && apt autoremove -y

#create default user called "user", with password "changeme" if nothing was provided (ENV)
RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $USER_PASSWORD) user

#copy files
COPY /data/startScript.sh /usr/local/bin/startScript.sh
COPY /data/xrdp.ini /etc/xrdp/
COPY /data/config /home/user/.config

#make the start script runable
RUN chmod +x /usr/local/bin/startScript.sh

#set the perm for the user to the .conf folder
RUN chown user: /home/user/.config
RUN sudo setfacl -R -m u:user:rwx /home/user/.config

#expose the RDP port
EXPOSE 3389

#start the start script and run the container
ENTRYPOINT ["/usr/local/bin/startScript.sh"]

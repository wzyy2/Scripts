https://www.digitalocean.com/community/tutorials/how-to-set-up-vnc-server-on-debian-8



tightvncserver
apt-get install  xfonts-base
export DISPLAY=:1.0


#tigervnviewer
#tigervnc-common

while true
do
	vncviewer 192.168.31.236:1 DesktopSize=1024x768 QualityLevel=5 passwd=/root/.vnc/passwd
  sleep 20
done

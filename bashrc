
PATH=/home/chen/bin:$PATH
PATH=/home/chen/bin/patman:$PATH
alias checkf='~/kernel-3.14/scripts/checkpatch.pl --strict -f '
alias linf='~/kernel-3.14/scripts/Lindent '

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
DEBEMAIL="jacob2.chen@rock-chips.com"
DEBFULLNAME="Jacob Chen"
export DEBEMAIL DEBFULLNAME
alias gitj='gitk -n 10000 '

export PATH=/home/chen/bin/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu/bin:$PATH

[user]
	name = Jacob Chen
	email = jacob2.chen@rock-chips.com
[alias]
	st = status
	ci = commit
	br = branch
	co = checkout
	cp = cherry-pick
[color]
	ui = auto
[sendemail]
	from = Jacob Chen <jacob2.chen@rock-chips.com>
	smtpserver = smtp.gmail.com
	smtpuser = jacobchen110@gmail.com
	envelopesender = jacobchen110@gmail.com
	smtpencryption = tls
	smtppass = * 
	smtpserverport = 587
	smtpdebug = 1
	chainreplyto = false
[http]
	cookiefile = /home/chen/.gitcookies
[gitreview]
	username = jacob2.chen
	username = jacob2.chen
[push]
	default = simple

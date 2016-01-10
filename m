Content-Type: multipart/mixed; boundary="===============6786748253975328970=="
MIME-Version: 1.0
From: Andrea Furin <andrea.furin@slacky.it>
Subject: Re: ERROR:Reject SCO: Agent not registered. HSP vs A2DP in Debian8
Date: Sun, 10 Jan 2016 15:22:38 +0000
Message-ID: <loom.20160110T162103-945@post.gmane.org>
In-Reply-To: <55DC2B87.7020901@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6786748253975328970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've found a way to use pc like an headset with Android phone (for making
callings).
!!! I've use pulseaudio from jessie-backports: I don't know how much this
takes risks ;-) !!!

In /etc/apt/sources.list add:

deb http://ftp.jp.debian.org/debian/ jessie-backports main contrib non-free
deb-src http://ftp.jp.debian.org/debian/ jessie-backports main contrib non-=
free

$ sudo apt-get update
$ sudo apt-get install pulseaudio=3D7.1-2~bpo8+1 pulseaudio-utils=3D7.1-2~b=
po8+1 \
    pulseaudio-module-x11=3D7.1-2~bpo8+1
pulseaudio-module-bluetooth=3D7.1-2~bpo8+1 \
    libpulse-mainloop-glib0=3D7.1-2~bpo8+1 libpulsedsp=3D7.1-2~bpo8+1
libpulse0=3D7.1-2~bpo8+1 \
    libpulse0:i386=3D7.1-2~bpo8+1

create a file (with same ownership of /var/lib/gdm3) (create directories if
necessary)
/var/lib/gdm3/.config/pulse/client.conf

autospawn =3D no
daemon-binary =3D /bin/true

[http://www.gem.mydns.jp/daitei/linux/jessie/bt-headset/]


Install "ofono"

in /etc/pulse/default.pa =

modify the line:
load-module module-bluetooth-discover
in:
load-module module-bluetooth-discover headset=3Dofono

Restart pulseaudio:
killall -9 pulseaudio
(is not necessary "pulseaudio --start" because from pulseaudio 6 it will
restart automatically)

For now it seems that:
- if in /etc/pulse/default.pa you have add "headset=3Dofono" you will have =
the
headset;
- if not you will have a2dp (restart pulseaudio every time).

Good luck


--===============6786748253975328970==--


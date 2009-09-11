Content-Type: multipart/mixed; boundary="===============3422972855017354199=="
MIME-Version: 1.0
From: mgwpub@gmail.com
Subject: Re: TI Calypso Driver
Date: Fri, 11 Sep 2009 19:10:35 +0300
Message-ID: <4AAA767B.8090206@gmail.com>
In-Reply-To: <200909032332.51432.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3422972855017354199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Simply insert the following lines into modem.conf to enable this device:
> [calypso]
> Driver=3Dcalypso
> Device=3D/dev/ttySAC0

thanks for the driver. I tried to use it via network, but I dont see =

dbus object pathes for the device.

I use pty [1] on my workstation and netcat on the freerunner to forward =

the at-commands. I can use /dev/pts/3 with cu to send at commands, but =

ofono doesnt show the object path for the modem.

Best regards.


[1]http://svn.openmoko.org/trunk/src/host/qemu-neo1973/pty.c

--===============3422972855017354199==--


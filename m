Content-Type: multipart/mixed; boundary="===============2631763671322226429=="
MIME-Version: 1.0
From: Bo <bothebobo@gmail.com>
Subject: basic connection howto
Date: Tue, 01 Sep 2015 19:34:48 +0000
Message-ID: <loom.20150901T213104-390@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2631763671322226429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
Seems that there takes some fiddling to connect =

my cellular dongle to the ofono framework.

My issue is i quickly looked at the man pages =

to see how to create the link between =

ofono my device.

The man pages mention that: =


"oFono is controlled through D-Bus; =

for example, one can tell ofonod to send =

AT commands over /dev/rfcomm0 by calling =

the D-Bus method org.ofono.at.Manager.Create"

So as any developer would do, I built my dbus command:
dbus-send --system --print-reply =

--dest=3Dorg.ofono / org.ofono.at.Manager.Create
string:"dev:/dev/ttyUSB0" string:"at"

I had already done my typical marshalling of  my device like so:
usb_modeswitch -v 1199 -p 0025
rmmod usbserial
modprobe usbserial vendor=3D0x1199 product=3D0x0025
which correspond to the sierra-wireless 598u

HOWEVER, there is no command called org.ofono.at.Manager.Create. =

I quickly see that the man page was created in 2009...
Quickly peeking through the test scripts =

I don't find anything that sounds familiar, =

took a peek in list-modems and enable-modem.... =

Also there is no examples to find in the docs to follow.

I also have conman installed, but not really sure who does what here. =

Who is controlling the device? =

Where do i give someone my =

golden /dev/ttyUSB0 string so it all magically works?

Thanks all!
Bo


--===============2631763671322226429==--


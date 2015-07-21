Content-Type: multipart/mixed; boundary="===============8323279396997788828=="
MIME-Version: 1.0
From: Mylene JOSSERAND <mylene.josserand@openwide.fr>
Subject: [info] modem data disconnection
Date: Tue, 21 Jul 2015 13:31:42 +0200
Message-ID: <55AE2D9E.6080106@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8323279396997788828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,


I have some questions about ofono and the data disconnection.

With debug information, after that my modem is online (connected to network=
 via ppp0 interface), when I go back to offline (by setting online property=
 to false), I can see that the modem network connection is down with :
ofonod[1039]: Modem: < ~\377}#\300!}%}#} }$\205r~

and PPP interface is removed :
ofonod[1039]: udevng.c:remove_device() /sys/devices/virtual/net/ppp0

I searched how ofono stops the modem connection, with escape sequence for e=
xample, but ofono does not seem to use it during offline sequence.

How does ofono handles it ?
How ofono (or gatppp, maybe ?) puts the modem network connection down (if i=
t does) ?


Thank you in advance,

Best regards,

Mylene


--===============8323279396997788828==--


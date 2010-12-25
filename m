Content-Type: multipart/mixed; boundary="===============3020102567493016888=="
MIME-Version: 1.0
From: Michael 'Mickey' Lauer <mickey@vanille-media.de>
Subject: Using the N900 modem via USB
Date: Sat, 25 Dec 2010 18:18:15 +0000
Message-ID: <1293301087.5809.3.camel@opal>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3020102567493016888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

we're trying to develop a 3rd party software that
runs on the N900 and talks to the modem. To make
developing more efficient, we try to forward the
modem via USB and develop on a PC. For some reason
we can't seem to get the phonet0 -> upnlink0 forwarding
to work.

tcpdump shows our request packets sent from the PC
arriving on upnlink0, but nothing responds. Apparantly
there is a missing link that connects phonet0 to upnlink0.

The software works fine directly on the device, however
it would be helpful to get forwarding work as well.
Note that running Maemo the forwarding works. What
are we missing?

Thanks,

M. Lauer.



--===============3020102567493016888==--


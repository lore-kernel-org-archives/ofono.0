Content-Type: multipart/mixed; boundary="===============2307553560353677528=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: oFono gets multiplexer support
Date: Thu, 15 Oct 2009 16:16:57 -0500
Message-ID: <200910151616.58076.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2307553560353677528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Just to let you know the initial support for multiplexing has been added to =

oFono.  The multiplexer infrastructure is fully customizable through the us=
e =

of drivers.  Two drivers are currently supported, GSM 27.010 Basic and =

Advanced modes.

The multiplexer is implemented in gatmux in the gatchat library.  GAtMux =

provides a simple interface, and returns a fully functional GIOChannel for =

each multiplexer port.  Thus it can easily be integrated with the existing =

GAtChat functionality, or used to read / write raw information (e.g. ppp =

frames)

This will allow oFono to implement everything in the main oFono process, an=
d =

not resort to a separate multiplexer daemon.  The calypso modem plugin has =

been updated to take advantage of 4 multiplexer channels.

Regards,
-Denis

--===============2307553560353677528==--


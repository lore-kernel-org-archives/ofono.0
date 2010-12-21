Content-Type: multipart/mixed; boundary="===============8751364130404283890=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: Failed to create CAIF socket for AT
Date: Wed, 22 Dec 2010 00:22:11 +0100
Message-ID: <AANLkTimAQbJFh91BMLQHUN1o4sJcQqmuhkgGz6Z+EZ-S@mail.gmail.com>
In-Reply-To: <COL106-W31BF5D57E4F7B7C4D521C9F61A0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8751364130404283890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kris,

> I am trying to understand CAIF protocol implementation in OFono.=C2=A0 I =
am
> getting "Failed to create CAIF socket for AT" when i am trying to enable =
my
> modem.

Maybe the easies way to check if you have CAIF running is to try out
unit/test-caif.
It will try to open a CAIF Socket to the modem and send an AT command.


You need to do the following to get the CAIF serial interface up:

1) Run a user space program to configure your serial cable and insert
the CAIF line discipline.
(You'll find a really old sample of ldiscd.c here:
http://patchwork.ozlabs.org/patch/34179/ perhaps
you could get this to work? Please ignore all the other stuff in this
patch, it is completely obsolete).
Please note that you have to run as root in order to install the ldisc.

2) If this is succesfull you will get a new network interface called
"cf<ttyname>" representing
the CAIF Link Layer. You need to set this interface in state "up"
(e.g. sudo ifconfig cf<ttyname> up).

You should now be able to connect CAIF sockets, and run unit/test-caif.

If Marcel accepts the patch I send for plugin/stemgr.c then this is
the best way to start
the STE modem. I will post a python-script simulating the Modem Init
Daemon when the stemgr is accepted.

Regards,
Sjur

--===============8751364130404283890==--


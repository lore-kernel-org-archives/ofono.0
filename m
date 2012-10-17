Content-Type: multipart/mixed; boundary="===============1715744366435982737=="
MIME-Version: 1.0
From: Markus Hubig <mhubig@imko.de>
Subject: oFono support for the Telit GC864-QUAD V2 serial port GSM/GPRS modem
Date: Wed, 17 Oct 2012 13:28:52 +0200
Message-ID: <20121017112852.GA32058@macbook.imko>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1715744366435982737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello @all,

I'm new here and I'm in the process of developing a Embedded Linux datalogg=
er
appliance. At the moment I'm evaluating the modem part of it, and we are
looking forward to use the Telit GC864-QUAD V2 serial port GSM/GPRS modem w=
ith
oFono.

Unfortunately I couldn't find much "getting started" information for oFono,=
 but
by reading throughout the old posts on this list I gathered at least some.
Please correct me if I get things wrong:

1. The one-and-only way to tell oFono to use a modem is by udev rules like
   this:

    KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"calypso"

2. Serial port GPRS modems like the Telit GC864 are not supported
   out-of-the-box, so one has to write a special modem driver for it.

3. Since this modem supports CMUX multiplexing with the 3GPP 27.010 standar=
d,
   I can use 'GAtMux' like it's done in 'plugins/calypso.c'.

4. There is a telit modem driver, but this is only for the UC864 UMTS modem
   which is connected via USB.

So in order to write a driver to support the GC864, what would be a good
starting point? Add support for serial port CMUX to the telit driver?

Looking forward for some advice ...

Cheers, Markus

--===============1715744366435982737==--


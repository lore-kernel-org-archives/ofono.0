Content-Type: multipart/mixed; boundary="===============3395581331324724924=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Comments about ofono-0.4 release
Date: Wed, 02 Sep 2009 20:56:24 -0700
Message-ID: <1251950184.1266.142.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3395581331324724924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

since we had so much movement in the source code, I went ahead and
tagged a new version. So welcome our 0.4 release.

The internal modem driver and feature frameworks got a whole re-write,
but I am not going into that details here. Go and join the IRC if you
really care about it ;)

With this release the generic_at driver is gone and replaced by modem
configuration driver and a separate one for phone simulator. So the file
you wanna look at is /etc/ofono/modem.conf now. It lets you specify
various modems and which driver they are suppose to be used. The file is
pretty self explanatory.

In addition the phone simulator driver, we now have a working driver for
the Android/HTC G1 devices. And an initial driver for the Ericsson MBM
laptop cards that at least adds support for SMS text messaging.

The daemon can also now be built with udev support. This is by default
enabled, but can be disabled if required or the target platform doesn't
use udev. The udev support will extend the modem configuration file and
allow for dynamic modem configuration. We are not there yet at this
point of time, but should be getting there pretty soon.

And as an extra goody, I converted to a full non-recursive build system
which should speed up everything and also allow the linker to do a
better job in stripping unused symbols. The biggest advantage of course
is when using automake-1.11, it looks way more sexy now :)

Regards

Marcel



--===============3395581331324724924==--


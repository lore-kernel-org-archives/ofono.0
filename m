Content-Type: multipart/mixed; boundary="===============5231768281711533924=="
MIME-Version: 1.0
From: contact@dsiekmeier.de
Subject: Connection lost on Embedded Linux system
Date: Mon, 21 Oct 2019 08:31:40 +0000
Message-ID: <20191021083140.2603.65659@new-ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5231768281711533924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am currently working with oFono for a wireless modem on an Embedded Linux.
Things are working okay if the signal strength is quite good. Nevertheless,=
 if I alter
the signal strength by for example removing the antenna, my device often co=
mes
into a strange state:

For debugging I am using mainly "dbus-send" to see the current information =
about
oFono. Sometimes the device is registered in the network, I have an IP adre=
ss and
a fairly good signal strength (40-60). But doing a ping request does not wo=
rk (no
outgoing traffic),

If I restart oFono manually, everything is working fine again. Is there any=
 known bug
regarding some blocking state changes or something like this? Are there kno=
wn
limitations using connman and oFono together?

Kind Regards
--===============5231768281711533924==--


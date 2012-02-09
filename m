Content-Type: multipart/mixed; boundary="===============1795075132746569473=="
MIME-Version: 1.0
From: Robyn Minkler <rminkler@gmail.com>
Subject: dbus error while trying to enable hfp connection with smartphone
Date: Thu, 09 Feb 2012 11:41:47 -0800
Message-ID: <1328816507.14667.5.camel@Ostrea-Edulis.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1795075132746569473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm trying to get ofono, telepathy-ring and empathy set up so that I can
make and receive calls on my fedora 16 laptop. =


The list-modems script shows my phone, but I get a dbus error when I try
to run enable-modems. More information below. =


Does anyone have any suggestions about how I might debug this?

This is with:
dbus 1.4.10
ofono 1.3

./list-modems
[ /hfp/889FFAEA6A1B_78471DBB098C ]
    Name =3D Nexus S
    Powered =3D 0
    Lockdown =3D 0
    Interfaces =3D =

    Online =3D 0
    Features =3D =


./enable-modem
Connecting modem /hfp/889FFAEA6A1B_78471DBB098C...
Traceback (most recent call last):
  File "./enable-modem", line 20, in <module>
    modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)
  File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 68, in
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 140, in
__call__
    **keywords)
  File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 630,
in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.ofono.Error.Failed: Operation failed



--===============1795075132746569473==--


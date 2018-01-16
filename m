Content-Type: multipart/mixed; boundary="===============8457077261236152109=="
MIME-Version: 1.0
From: Engelbert Torremans <engelbert@torremans.com>
Subject: Problem with dialstring ##21#
Date: Tue, 16 Jan 2018 13:50:18 +0100
Message-ID: <e80f263e-eb06-a0ed-f877-c752cd6e5718@torremans.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8457077261236152109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All,

I am looking for some help in trying to fix this problem I am =

experiencing when using Ofono on a RaspberryPi in "carkit/HFP mode".

Currently I can make calls (originate and terminate) and audio is fine =

in combination with Bluez5 etc. also.

But I cannot disable CallForwarding via the dial-number command.

Enabling CFU via **21*destination-number# is working fine.

Trying to disable CFU via ##21# gives below error. Doing the same via =

the keypad on the mobile phone works fine.

I have the impression that somwhere this ##21# is not processed =

correctly but where? In ofono or in DBUS or?

Any clues?

Thanks,

Engelbert

pi(a)rpi-x:~/xgen/ofono $ ./dial-number BT-MAC-ADDRESS ##21#
Using modem /hfp/org/bluez/hci0/dev_BT-MAC-ADDRESS
Traceback (most recent call last):
 =C2=A0 File "./dial-number", line 40, in <module>
 =C2=A0=C2=A0=C2=A0 path =3D vcm.Dial(number, hide_callerid)
 =C2=A0 File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 70, in =

__call__
 =C2=A0=C2=A0=C2=A0 return self._proxy_method(*args, **keywords)
 =C2=A0 File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 145, in =

__call__
 =C2=A0=C2=A0=C2=A0 **keywords)
 =C2=A0 File "/usr/lib/python3/dist-packages/dbus/connection.py", line 651, =

in call_blocking
 =C2=A0=C2=A0=C2=A0 message, timeout)
dbus.exceptions.DBusException: org.ofono.Error.InvalidFormat: Argument =

format is not recognized


--===============8457077261236152109==--


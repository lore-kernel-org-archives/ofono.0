Content-Type: multipart/mixed; boundary="===============4577798618216717171=="
MIME-Version: 1.0
From: Max <Max.Suraev@fairwaves.ru>
Subject: scan problem
Date: Fri, 20 Apr 2012 12:14:34 +0800
Message-ID: <4F90E2AA.70002@fairwaves.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4577798618216717171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello.

I've got following error while trying to scan for operator with ofono from =
git:

./scan-for-operators /wavecom_q_0
Scanning operators on modem /wavecom_q_0...
Traceback (most recent call last):
  File "./scan-for-operators", line 20, in <module>
    operators =3D netreg.Scan(timeout=3D100);
  File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in call=
_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Me=
thod
"Scan" with signature "" on interface "org.ofono.NetworkRegistration" doesn=
't exist

Is this some known bug or some sort of misconfiguration on my side?

best regards,
Max.

--===============4577798618216717171==--


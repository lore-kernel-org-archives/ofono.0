Content-Type: multipart/mixed; boundary="===============1075980953730575799=="
MIME-Version: 1.0
From: zoltanmaric@pm.me
Subject: ofono enable-modem fails with dbus.exceptions.DBusException:
 org.ofono.Error.Failed: Operation failed
Date: Wed, 14 Oct 2020 20:50:51 +0000
Message-ID: <20201014205051.2619.94189@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1075980953730575799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm trying to make Ubuntu 20.04 recognise AirPods Pro as a headset (not jus=
t as headphones). I tried to follow the instructions in this AskUbuntu answ=
er: https://askubuntu.com/questions/831331/failed-to-change-profile-to-head=
set-head-unit/1236379#1236379

list-modems returns the following output:

[ /phonesim ]
    Online =3D 0
    Powered =3D 0
    Lockdown =3D 0
    Emergency =3D 0
    Interfaces =3D =

    Features =3D =

    Type =3D hardware

But when I try to run the enable-modem command from a freshly checked-out o=
fono git repo (commit 285fad8f39d46a5f0a0f9d194789978227558d1e), I get the =
following error:

Connecting modem /phonesim...
Traceback (most recent call last):
  File "./enable-modem", line 20, in <module>
    modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)
  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 72, in __call=
__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 141, in __cal=
l__
    return self._connection.call_blocking(self._named_service,
  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 652, in ca=
ll_blocking
    reply_message =3D self.send_message_with_reply_and_block(
dbus.exceptions.DBusException: org.ofono.Error.Failed: Operation failed

What does the error mean, and how could I get around it?

Thanks for your help.
--===============1075980953730575799==--


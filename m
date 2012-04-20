Content-Type: multipart/mixed; boundary="===============4446374379911045712=="
MIME-Version: 1.0
From: Max <Max.Suraev@fairwaves.ru>
Subject: Re: scan problem
Date: Fri, 20 Apr 2012 16:34:15 +0800
Message-ID: <4F911F87.4050101@fairwaves.ru>
In-Reply-To: <ED4DEEB78293B34A9D0EAC02A474A46E18AA282F@IRSMSX102.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4446374379911045712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

20.04.2012 16:01, Aygon, Bertrand =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:

> Ok,  so your modem is enabled, but not online (Online =3D 0).
> =

> You should online it by doing "./online-modem /wavecom_q_0"

./online-modem /wavecom_q_0
Setting modem /wavecom_q_0 online...
Traceback (most recent call last):
  File "./online-modem", line 17, in <module>
    modem.SetProperty("Online", dbus.Boolean(1), timeout =3D 120)
  File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in call=
_blocking
    message, timeout)
dbus.exceptions.DBusException: org.ofono.Error.NotImplemented: Implementati=
on not
provided

That's odd. Could it be some sort of build problem with my installation?
How can I troubleshoot that?

> You can add a var arg OFONO_AT_DEBUG=3D1 to enable AT logging.

Thanks. Although this gave me only AT command for ./enable-modem which work=
s anyway :)

cheers,
Max.



--===============4446374379911045712==--


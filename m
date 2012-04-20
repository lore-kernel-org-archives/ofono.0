Content-Type: multipart/mixed; boundary="===============2263005954261342537=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: scan problem
Date: Fri, 20 Apr 2012 08:53:30 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18AA289A@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4F911F87.4050101@fairwaves.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2263005954261342537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > Ok,  so your modem is enabled, but not online (Online =3D 0).
> >
> > You should online it by doing "./online-modem /wavecom_q_0"
> =

> ./online-modem /wavecom_q_0
> Setting modem /wavecom_q_0 online...
> Traceback (most recent call last):
>   File "./online-modem", line 17, in <module>
>     modem.SetProperty("Online", dbus.Boolean(1), timeout =3D 120)
>   File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call=
__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __cal=
l__
>     **keywords)
>   File "/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in
> call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.ofono.Error.NotImplemented:
> Implementation not provided
> =

> That's odd. Could it be some sort of build problem with my installation?
> How can I troubleshoot that?
> =

> > You can add a var arg OFONO_AT_DEBUG=3D1 to enable AT logging.
> =

> Thanks. Although this gave me only AT command for ./enable-modem which
> works anyway :)

Can you please send the log from beginning to ./enable-modem with AT comman=
d, so we can have a look at what is going on?

Thanks,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2263005954261342537==--


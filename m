Content-Type: multipart/mixed; boundary="===============3473259491008224416=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: scan problem
Date: Fri, 20 Apr 2012 06:44:59 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18AA2607@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4F90E2AA.70002@fairwaves.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3473259491008224416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> I've got following error while trying to scan for operator with ofono fro=
m git:
> =

> ./scan-for-operators /wavecom_q_0
> Scanning operators on modem /wavecom_q_0...
> Traceback (most recent call last):
>   File "./scan-for-operators", line 20, in <module>
>     operators =3D netreg.Scan(timeout=3D100);
>   File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call=
__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __cal=
l__
>     **keywords)
>   File "/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in
> call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
> Method "Scan" with signature "" on interface "org.ofono.NetworkRegistrati=
on"
> doesn't exist
> =

> Is this some known bug or some sort of misconfiguration on my side?

Can you please give more details?

Is your modem enabled and online?

Can you please attach a log?

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


--===============3473259491008224416==--


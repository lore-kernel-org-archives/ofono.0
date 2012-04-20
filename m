Content-Type: multipart/mixed; boundary="===============2151664236696276078=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: scan problem
Date: Fri, 20 Apr 2012 12:00:42 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E18AA2B78@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4F914D79.4060403@fairwaves.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2151664236696276078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > OFONO_AT_DEBUG=3D1 ./src/ofonod -n -d '*'
> =

> Awesome! The log is attached: 1st I run `./enable-modem /wavecom_q_0` than
> wait for few seconds and run `./online-modem /wavecom_q_0` which gives me
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

So your modem doesn't reply to the first AT command sent.

Can you try to open one of the many /dev/ttyUSB1 to /dev/ttyUSB16 using min=
icom and send some AT command to see if you got an answer?

Regards,

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

--===============2151664236696276078==--


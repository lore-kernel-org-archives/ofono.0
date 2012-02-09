Content-Type: multipart/mixed; boundary="===============1714691103272481221=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: dbus error while trying to enable hfp connection with smartphone
Date: Thu, 09 Feb 2012 14:17:25 -0600
Message-ID: <4F3429D5.2050003@gmail.com>
In-Reply-To: <1328816507.14667.5.camel@Ostrea-Edulis.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1714691103272481221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robyn,

On 02/09/2012 01:41 PM, Robyn Minkler wrote:
> I'm trying to get ofono, telepathy-ring and empathy set up so that I can
> make and receive calls on my fedora 16 laptop. =

> =

> The list-modems script shows my phone, but I get a dbus error when I try
> to run enable-modems. More information below. =

> =

> Does anyone have any suggestions about how I might debug this?

export OFONO_AT_DEBUG=3D1 and run ofono with -d option

> =

> This is with:
> dbus 1.4.10
> ofono 1.3
> =

> ./list-modems
> [ /hfp/889FFAEA6A1B_78471DBB098C ]
>     Name =3D Nexus S
>     Powered =3D 0
>     Lockdown =3D 0
>     Interfaces =3D =

>     Online =3D 0
>     Features =3D =

> =

> ./enable-modem
> Connecting modem /hfp/889FFAEA6A1B_78471DBB098C...
> Traceback (most recent call last):
>   File "./enable-modem", line 20, in <module>
>     modem.SetProperty("Powered", dbus.Boolean(1), timeout =3D 120)
>   File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 68, in
> __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 140, in
> __call__
>     **keywords)
>   File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 630,
> in call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.ofono.Error.Failed: Operation failed
> =


Generally two things can go wrong:

- The bluetooth link could not be established for some reason.  e.g. the
your adapter is off, the remote device is off, stale pairing setup, etc.
 Use hcidump utility from bluez to debug this.

- The Handsfree SLC handshake could not be established.  The AT command
logs from oFono would help us diagnose that...

Regards,
-Denis

--===============1714691103272481221==--


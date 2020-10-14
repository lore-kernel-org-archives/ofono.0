Content-Type: multipart/mixed; boundary="===============5431922720552683552=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ofono enable-modem fails with dbus.exceptions.DBusException:
 org.ofono.Error.Failed: Operation failed
Date: Wed, 14 Oct 2020 23:04:11 +0200
Message-ID: <20201014210410.GA19086@amd>
In-Reply-To: <20201014205051.2619.94189@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5431922720552683552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed 2020-10-14 20:50:51, zoltanmaric(a)pm.me wrote:
> I'm trying to make Ubuntu 20.04 recognise AirPods Pro as a headset (not j=
ust as headphones). I tried to follow the instructions in this AskUbuntu an=
swer: https://askubuntu.com/questions/831331/failed-to-change-profile-to-he=
adset-head-unit/1236379#1236379
> =

> list-modems returns the following output:
> =

> [ /phonesim ]
>     Online =3D 0
>     Powered =3D 0
>     Lockdown =3D 0
>     Emergency =3D 0
>     Interfaces =3D =

>     Features =3D =

>     Type =3D hardware
> =

> But when I try to run the enable-modem command from a freshly checked-out=
 ofono git repo (commit 285fad8f39d46a5f0a0f9d194789978227558d1e), I get th=
e following error:
> =

> Connecting modem /phonesim...
> Traceback (most recent call last):

You are talking to phonesim -- that's software simulator (and quite
useful), but it is not your AirPods.

Best regards,
									Pavel

-- =

http://www.livejournal.com/~pavelmachek

--===============5431922720552683552==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsK0haOG9BQ2drUU1PZndhcFhiK3ZKalBBQ2VMWHRwVUZZSExvNlZrNFo0L29IcWE2SXQK
V29rQW5pSnBLclJEK2xveDgrcGtIZnVodjM0a0FnMmoKPXpSUVkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5431922720552683552==--


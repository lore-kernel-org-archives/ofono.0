Content-Type: multipart/mixed; boundary="===============0862322153131606045=="
MIME-Version: 1.0
From: Santtu Lakkala <inz@inz.fi>
Subject: Re: failed to start ofonod....
Date: Thu, 11 Jun 2009 11:10:59 +0300
Message-ID: <4A30BC13.3070003@inz.fi>
In-Reply-To: <a0b5f4b30906110055j38ae0005t86f114ead305d8da@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0862322153131606045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

WuYongbo wrote:
> I got the source code by git-clone and built it successfully.
> but failed to start ofonod....
> =

> *$ sudo ofonod  -n -d
> ofonod[25234]: oFono version 0.0
> ofonod[25234]: Unable to hop onto D-Bus: Connection ":1.646" is not allow=
ed
> to own the service "org.ofono" due to security policies in the configurat=
ion
> file
> ofonod[25234]: Exit

Sounds like you don't have the src/ofono.conf installed in
/etc/dbus-1/system.d; this should allow root to own the org.ofono
service (and the local user to use it).

- --
Santtu Lakkala
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkowvBIACgkQX9Rc0+po4p1qgACdHEJOip8TYcCP1o7PWpeFYB6U
iO4AoJbvwW9bmTae65ySZfKVM84g0LqA
=3DNsbw
-----END PGP SIGNATURE-----

--===============0862322153131606045==--


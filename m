Content-Type: multipart/mixed; boundary="===============1383908885447464280=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sd-bus
Date: Thu, 03 Jan 2019 21:34:23 +0100
Message-ID: <20190103203422.GA21861@amd>
In-Reply-To: <CAKSBH7E66=jEZE4+ByY1zDm0bN5RD-DeT+B3S5OK=4gb-qyz1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1383908885447464280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> would it be interesting to port ofono from GDBus, which comes with the
> huge GLib dependency, to sd-bus?
> It is a lot of work, but the main question is whether we can assume
> that systemd is deployed enough to allow the switch.

As someone said, ell already has dbus support.

But dependency on systemd would be bad -- I (and maemo leste project)
am running ofonod on Devuan -- which is Debian w/o systemd.

Best regards,
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1383908885447464280==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd3VjYzRBQ2drUU1PZndhcFhiK3ZMRWtRQ2d0a2doNFNEWkIvY2FLS0lrL0dvb2hxdEsK
dVl3QW9JZmVJQTdOK2NFVWI2SDVVelVlYlB1c3p1clIKPWdwOHIKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1383908885447464280==--


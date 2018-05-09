Content-Type: multipart/mixed; boundary="===============7246644736868971419=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: AT commands in U0001AT+FOOBAR form
Date: Wed, 09 May 2018 08:09:40 +0200
Message-ID: <20180509060940.GA7488@amd>
In-Reply-To: <7c430d01-d7e3-8473-03c7-c1bf3eb236c5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7246644736868971419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >I have a motorola droid 4 here; it uses gsm 07.10 multiplex. Over
> >that, there are AT commands, but prefixed with serial numbers, in
> >U0001AT+FOOBAR form. Corresponding reply then has U0001 prefix, too.
> >Has anyone seen that before? Any hints for me trying to add the
> >support?
> >
> =

> I've never seen anything like it.  The 07.10 was explicitly designed so t=
hat
> the AT command processor didn't need to know or care whether it was
> connected directly to the serial port or to the multiplexer.  E.g. AT
> commands should not be modified in any way.
> =

> Are you use this is a 07.10 multiplexer and not something else?  What is =
the
> serial number exactly? Serial number of the multiplexer channel or ?

Looks like 07.10 multiplexer...

https://github.com/tmlind/droid4-ngsm/

Serial number seems to be "serial number of command" during normal
operation.

We may be able to get kernel to strip the extra U1234 stuff.

For now I'm using usb interface to the modem, which eats extra power
but does not have this problem.

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7246644736868971419==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnlrS1FBQ2drUU1PZndhcFhiK3ZLM2NBQ2dpRFJvek8wOG9Yamc4azZWZ05TTmtsOFYK
Nm9jQW4xYTByUXlkRnQrWU5WYmNGLytpdnQ1YnFCZGQKPURKQUwKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============7246644736868971419==--


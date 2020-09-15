Content-Type: multipart/mixed; boundary="===============4255907311351658964=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] Support weird modem in Motorola Droid 4
Date: Tue, 15 Sep 2020 13:13:40 +0200
Message-ID: <20200915111340.GA27359@duo.ucw.cz>
In-Reply-To: <76d39f7d-8365-2e51-f523-ac375914c83d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4255907311351658964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> On 9/10/20 8:05 AM, Pavel Machek wrote:
> > This is basic support for modem in Droid 4, accessed over
> > ttyUSB4. That interface is unfortunately quite broken, so we need to
> > force very specific SMS mode.
> > =

> =

> Can you separate this into at least a couple of patches per our patch
> submission guidelines? See HACKING, 'Submitting Patches' section.
> =

> 1 - atmodem / vendor quirks
> 2 - plugins/droid.c + build changes

Would it be okay to do them in the other order? droid.c + build
changes already gives modem usable for voice calls...

Best regards,
							Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4255907311351658964==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWDJDaDVBQUtDUkF3NS9CcWxkdjYKOGswdUFKOUdQOTVIN1hJTjdi
ZFpERWZKSTIrSm5WY1VJd0NnaDRmMUJ6TEdYSTg2NWlCNnZUWGJZZkowZm04PQo9K0RuUQotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============4255907311351658964==--


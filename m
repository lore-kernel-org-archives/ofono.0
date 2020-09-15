Content-Type: multipart/mixed; boundary="===============4851659789281743364=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] Support weird modem in Motorola Droid 4
Date: Tue, 15 Sep 2020 12:08:29 +0200
Message-ID: <20200915100829.GA28795@duo.ucw.cz>
In-Reply-To: <76d39f7d-8365-2e51-f523-ac375914c83d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4851659789281743364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

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

Ok, will make it into two patches.

> > +		default:
> > +			/* Should be a safe fallback */
> > +			snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
> > +			break;
> > +		}
> =

> I'd rather you just not call at_ack_delivery at all in the case of DROID.
> In fact, I don't think this function gets invoked at all if cnma_enabled =
is
> false...

Let me see if I can get that to work.

> > +	if (getenv("OFONO_AT_DEBUG"))
> > +		g_at_chat_set_debug(chat, droid_debug, "");
> =

> Maybe use at_util_open_device()?

Let me take a look.

Thanks a lot for the review!
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4851659789281743364==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWDJDU25RQUtDUkF3NS9CcWxkdjYKOHUrN0FLQy8xOUw5Rm9aMnFU
ZCtjVzZZbllCd1JRSW00Z0NmVEw3MCtnVEIraXg1cHZXM2txcFRxV0NBeW44PQo9UDRPVQotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============4851659789281743364==--


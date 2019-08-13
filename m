Content-Type: multipart/mixed; boundary="===============1519055239061765967=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfc] Motorola Droid 4 voice: integrate into atmodem or
 completely separate?
Date: Tue, 13 Aug 2019 22:59:22 +0200
Message-ID: <20190813205922.GA14446@amd>
In-Reply-To: <174aba4c-e8a4-c059-ffcb-64770aae7401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1519055239061765967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >Droid 4 has ... something similar to AT commands, but not quite. For
> >voice calls, I modified atmodem... but I guess there are so many
> >changes that creating separate motorolamodem/voicecall.c might be
> >an option? (send_clcc() changes make sense as a cleanup, and were sent
> >in separate mail.)
> =

> Since it looks like the Modem does actually provide some rudimentary
> unsolicited call state notifications via CIEV, you're better off just
> writing a custom driver.  CLCC polling logic is actually quite complex as=
 it
> is, so adding vendor branching to it just makes things worse. Also the
> driver is likely to be much simpler if you can rely on unsolicited call
> state reporting events.

Thanks for feedback. Done, but there are more cleanups possible.

> The send_clcc change does sort of make sense separately.

Yes, you should have it separate in your inbox ;-). If not, let me
know and I'll resend.

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1519055239061765967==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMVRKS29BQ2drUU1PZndhcFhiK3ZJeTRnQ2dzV2t6L04vZmhZWnZOaDlzUDJVREV3cmQK
b0ZBQW9KNWZqYUJ4WEdKYVZGSXFKSjRvT0R5R2prL0EKPU1ZMUsKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1519055239061765967==--


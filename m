Content-Type: multipart/mixed; boundary="===============5085680902556630334=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Weird Droid 4 modem protocol and a way to support it
Date: Sat, 11 Jul 2020 14:10:47 +0200
Message-ID: <20200711121047.GA3973@amd>
In-Reply-To: <bf3dfd8a-d192-0c6a-d0ee-6480bea81e13@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5085680902556630334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >I'd really like to get support for Droid 4 modem... unfortunately it
> >is quite special. Few words about Droid 4 modem protocol:
> =

> >
> >I'm not sure what is the best way to support it. I was not able to get
> >atchat.c to work with it (and I don't think it is quite suitable), so
> >I ended up copying it and modifying it for Droid 4 protocol.
> >
> >Is that acceptable? Can you see a better way?
> =

> I don't think there's really another way.  So the approach of duplicating
> GAtChat and everything inside drivers/atmodem is likely the way to go.
> =

> But if you pursue this, we really should throw out as much of the legacy =
in
> gatchat as possible:
> =

> - g_at_chat_suspend / resume is likely not needed (you're probably not
> running PPP over these, right)?
> - stuff like g_at_chat_set_wakeup is only relevant for some weird modems =
and
> probably isn't relevant here
> - add_terminator / blacklist_terminator might not be needed
> - Some other concepts might not be needed, like send_pdu_listing and
> send_and_expect_short_prompt.  Those are really only for weird SMS comman=
ds.
> - It might also be possible to greatly simplify the GAtParser
 >concept.

I had it removed from .c files, removed from .h now, too.

> - I'd also just put this all directly into drivers/motmodem/* instead of
> trying to extend gatchat library itself.

Already done.

> Most importantly though, we should stop using glib.  oFono is (glacially
> slowly) being ported over to ell.  So I don't really want to accept any n=
ew
> glib code.

Heh. I guess I'll wait for atchat to be converted, first...

Best regards,
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5085680902556630334==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsOEpyRWNBQ2drUU1PZndhcFhiK3ZKRjZnQ2ZVRlVsbU4zcWdkd1gxejAwNlNyeGFPMkgK
c0ZJQW9LQWEyOXljWkZCelUxVllKdjhDblliMzY4MDUKPVdSUXIKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5085680902556630334==--


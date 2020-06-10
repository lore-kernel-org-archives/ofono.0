Content-Type: multipart/mixed; boundary="===============2497929709868398581=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Weird Droid 4 modem protocol and a way to support it
Date: Wed, 10 Jun 2020 18:24:30 +0200
Message-ID: <20200610162430.GA4109@amd>
In-Reply-To: <bf3dfd8a-d192-0c6a-d0ee-6480bea81e13@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2497929709868398581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >I'd really like to get support for Droid 4 modem... unfortunately it
> >is quite special. Few words about Droid 4 modem protocol:
> >
> =

> <snip>
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

Ok, thanks for confirmation.

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
> concept.

I believe I don't need GAtParser at all.

> - I'd also just put this all directly into drivers/motmodem/* instead of
> trying to extend gatchat library itself.

Yes.

> Most importantly though, we should stop using glib.  oFono is (glacially
> slowly) being ported over to ell.  So I don't really want to accept any n=
ew
> glib code.

So... this code started as copy of gatchat, with me removing the
obviously-unneeded stuff. I guess I can convert motchat easily when
atchat is converted... but I'm not sure I understand the code well
enough to do conversion on my own.

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2497929709868398581==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFVUVBUkVD
QUFZRkFsN2hDVDRBQ2drUU1PZndhcFhiK3ZLUEhRQ1lxdmszd1puTVYrd1ZlaXhmNkh6b0NUL3YK
cGdDZ21JWVJ5dmc1T0VEMHpNaWVwWDRWVkQ0bUcvZz0KPUcySk4KLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2497929709868398581==--


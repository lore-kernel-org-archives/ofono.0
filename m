Content-Type: multipart/mixed; boundary="===============0173152709809291291=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola motmdm support
Date: Mon, 07 Jan 2019 18:41:26 +0100
Message-ID: <20190107174126.GA933@amd>
In-Reply-To: <20190107152908.GD5544@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0173152709809291291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > > But that seems to fix a different issue from what you're seeing.
> > =

> > Yes, I can easily work around the problem like this:
> > =

> > It needs huge fixme there, but if you could include it... "always
> > ready" is better than "never ready".
> =

> OK I'll take a look when I get a chance. I think all we need
> to do there is check that cdata->write_offset < cdata->write_buf_sz.

Makes sense. And you probably need to wake up userspace when buffer
was full and free space appears.

> > Have you figured out how the incoming calls are supposed to work? I'm
> > getting this on incoming call:
...
> > ofonod[2534]: Voice: < ~+CIEV=3D1,4,0\n\r
> > ignoring line
> > ofonod[2534]: Voice: < ~+CLIP=3D"+420xxxxxxxxx",1,1,"",0,"",0\n\r
> > ignoring line

> > I probably could use +CLIP as "there's incoming call", but I don't see
> > anything useful when I hang up and phone should stop ringing. =

> =

> Parsing the number(s) from +CIEV should tell that, see what
> I added to motmdm_read_state().

+CIEV is documented as "indicator event". I can make ofono parse that,
but it will be ... slightly hacky.

Is there "RING" or something like that going on any of the interfaces?

BTW does 5.0-rc1 boot for you?

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============0173152709809291291==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd3pqMFlBQ2drUU1PZndhcFhiK3ZJemdBQ2ZiSU5iY3g0d25FL2ZSMWlUeUVVNkRaQ1gK
WnNvQW9NVEcrNks5VjdTL3c2WXgxOVZ0Tnpha2F4SnYKPVd4UkMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============0173152709809291291==--


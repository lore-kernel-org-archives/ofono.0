Content-Type: multipart/mixed; boundary="===============7240394135457889596=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4 modem support in kernel & ofono
Date: Thu, 07 Feb 2019 23:17:46 +0100
Message-ID: <20190207221745.GA12219@amd>
In-Reply-To: <20190201205032.GF5720@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7240394135457889596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, so I got calls and smses somehow working in kernel&ofono ... which
> > is really all I need.
> =

> Nice :)
> =

> I think the SIM card reading and writing should be doable
> using dlci10 /dev/motmdm10 for AT+CRSM calls..

Might be. Sorry, this is outside of my area of interest, because LTE
would not be on usable frequencies, anyway.

> > I pushed the tree to git(a)github.com:pavelmachek/ofono.git , branch
> > d4... But I had to do some "rather interesting" hacks. D4 modem
> > expects packets and current kernel drivers rely on write() boundaries
> > and flush(). .. which is a bit of problem for in ofonod, as it expects
> > to work with bytestream with no explicit packet boundaries.
> > =

> > However D4 still uses normal AT commands, so... it would be good to be
> > able to use AT parsing framework in ofono.
> > =

> > I believe easiest solution would be to automatically do the packet
> > splitting in kernel, it should be as easy as splitting on \r and
> > ^Z. (Currently packets are only generated when \r or ^Z is seen on
> > write boundary, but that does not work well for ofono).
> =

> OK yeah it's worth trying. I hit that issue too with the
> flush needed for droid4-sms-tools scripts. And the traffic
> we're seeing is minimal and AFAIK there's no network port
> for ts27010. And SMS messages are PDU encoded anyways.
> =

> Hmm should we do it for \r\n and \r? Otherwise the \n
> will be left out of the packet :)

I guess splitting on \n makes sense, yes. =


Ofono normally uses just \r. Translating it to \r\n in kernel (ttys
already do that) would be super nice, but I think this is easy enough
to handle in ofono.

Thanks,
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7240394135457889596==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseGNyb2tBQ2drUU1PZndhcFhiK3ZLNGJ3Q2ZWL0xWZ01nQVh0N1J0M3I1RUd6N0NxOVYK
dlY4QW9KY1pwSUZTLzZveDVqNlpDdkhVOVZIbzZHa0cKPTlPUTYKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============7240394135457889596==--


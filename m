Content-Type: multipart/mixed; boundary="===============4193959614898323742=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 17:11:04 +0200
Message-ID: <20180509151103.GB28193@amd>
In-Reply-To: <04c1e128-9094-cdc0-97f3-abd7cacea1d9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4193959614898323742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >PDU Len 2, strlen 4
> >PDU last char 48
> >0000^ZCNMA=3D1,2
> ><PR
> >0000^ZCNMA=3D1,2
> >< +CMS ERROR: 304
> >ofonod[3057]: CNMA acknowledgement failed: Further SMS reception is
> >not guaranteed
> >< +CIEV: 1,4
> >
> >Modem does not like our CNMA acknowledgement. AFAICT, we are sending
> >
> >AT+CNMA=3D1,2
> >0000^Z
> =

> That looks correct.  In fact that logic has been working for something li=
ke
> 8-9 years, but it doesn't hurt to be paranoid and double check.

Ah. Four zeros somehow looked too simple to me.

> >If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA, it =
does
> >not like that, either, but with +CMS ERROR: 500.
> =

> CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  How ab=
out:
> =

> window.open();
> window.throw(modem);

Heh :-). Well, there are two phones with reasonable Linux support:
N900 and Droid 4. N900 can't do voice calls of reasonable
quality. That leaves Droid 4... so I'd really like it to work.

Afaict.. In PDU mode we need either +CNMA, which is broken, or CMTI,
which reports '+CMTI: "ME",-1' which I assume is broken, too.

Is there chance that '+CMTI: "ME",-1' can be understood as '+CMTI:
"ME",1' ?

Best regards,

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4193959614898323742==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFVUVBUkVD
QUFZRkFscnpENGNBQ2drUU1PZndhcFhiK3ZMakd3Q1lvZlBacXdoWW1MeHFaMmZ5c2Q3L1ZzcUEK
VkFDZ21Mc2pnc2JEWkVpbTl3cU9STW5yaXdzcDJWZz0KPVdxMFMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4193959614898323742==--


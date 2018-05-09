Content-Type: multipart/mixed; boundary="===============8209480608220571054=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 20:57:55 +0200
Message-ID: <20180509185755.GA32379@amd>
In-Reply-To: <590d180f-f7ab-abcc-2bd9-93cb22905381@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8209480608220571054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA, i=
t does
> >>>not like that, either, but with +CMS ERROR: 500.
> >>
> >>CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  How =
about:
> >>
> >>window.open();
> >>window.throw(modem);
> >
> >Heh :-). Well, there are two phones with reasonable Linux support:
> >N900 and Droid 4. N900 can't do voice calls of reasonable
> >quality. That leaves Droid 4... so I'd really like it to work.
> =

> Is this actually an AT command modem or one of those modems where AT
> commands were only bolted on for carrier certification?  Does it support =
QMI
> or something maybe?

Ok, so ... this is complex. And maybe this is one of "those" modems.

There's USB with AT commands, USB with QMI protocol, then serial with
mux and U1234AT+XYZ commands.

It seems Android uses serial, but that is being worked on, so I'm
using AT commands for now.

> >Afaict.. In PDU mode we need either +CNMA, which is broken, or CMTI,
> >which reports '+CMTI: "ME",-1' which I assume is broken, too.
> >
> >Is there chance that '+CMTI: "ME",-1' can be understood as '+CMTI:
> >"ME",1' ?
> =

> ITU v.250, Section 5.3.1:
> < number>
> may be a string of one or more characters from "0" through "9" representi=
ng
> a decimal integer value. Commands that expect a < number>
> are noted in the description of the command (see clause 6).
> =

> So strictly speaking negative numbers are not allowed.  But who reads spe=
cs
> anyway for something as unimportant as a communications device that lives
> might depend on.

Would it be possible to re-scan the messages similar way we do scan on
startup when invalid +CMTI is received?

Any hints how I should hack it in?

Thanks,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8209480608220571054==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnpSTE1BQ2drUU1PZndhcFhiK3ZKeUpRQ2duZ1VBcmxtQ2h5aDdaOGNqZmVIUlRicG4K
eFFzQW5pbExkVjdFOTl4NGFldlJyT1BHcHhFcnFoTU8KPVhhcEsKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8209480608220571054==--


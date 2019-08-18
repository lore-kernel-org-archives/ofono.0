Content-Type: multipart/mixed; boundary="===============6426963680319637830=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfc] Motorola Droid 4 voice: integrate into atmodem or
 completely separate?
Date: Sun, 18 Aug 2019 10:33:38 +0200
Message-ID: <20190818083338.GA23821@amd>
In-Reply-To: <e8eec1b5-1762-8fae-f6dd-b687cad5b425@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6426963680319637830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >>The send_clcc change does sort of make sense separately.
> >
> >Yes, you should have it separate in your inbox ;-). If not, let me
> >know and I'll resend.
> =

> Doesn't look like I do?

You should have now. :-).

I pushed updated sources to
https://github.com/pavelmachek/ofono/pull/new/m-v1.29-1 .

Now I'm fighting with network registration, and there's problem I
don't know how to solve nicely.

Regular AT commands behave like this:

AT+CREG?
+CREG: 0,0

OK

Why Droid4 reacts with single line (and no OK)

+CREG=3D0,0,0,0,0,0,0,0,0,0,,0

I'm using

g_at_chat_add_terminator(chat,  "+CREG=3D", 6, TRUE  );

so I get my callbacks called, but I can't really get that to work.

Is there a better way?

Best regards,

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6426963680319637830==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMVpEV0VBQ2drUU1PZndhcFhiK3ZJTjlnQ2dxSDhSeXc0VXFDYmtwdEs5UEUzTHIzZG4K
TWd3QW4waEczR3FtV29QMHhQbzlBQTIvZVhnVTM1ZkQKPVVHN0YKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6426963680319637830==--


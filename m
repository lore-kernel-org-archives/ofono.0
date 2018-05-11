Content-Type: multipart/mixed; boundary="===============1209398322183268965=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Fri, 11 May 2018 14:34:03 +0200
Message-ID: <20180511123403.GA27892@amd>
In-Reply-To: <20180509133506.GX77069@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1209398322183268965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > > And that's probably the incoming SMS size. But I don't see
> > > anything for what actually reads the incoming SMS.
> =

> Hmm it occured to me that maybe the incoming messages are read
> using QMI over USB.
> =

> > That seems to be standard message
> > ftp://www.3gpp.org/tsg_t/TSG_T/TSGT_04/Docs/PDFs/TP-99129.pdf .
> > =

> > Do you see AT+CNMI during boot and AT+CNMA after message is received?
> =

> I'm only seeing AT+CNMA=3D0,0 on dlci 9 after resume. I think that is
> used to query for new messages.
> =

> No CNMI in my logs it seems. But if QMI over USB is used to read
> the messages that would explain it only checks for new SMS.

I tried debugging this some more, and it is rather frustrating :-(.

State of the modem is kept over tries, which makes me reboot rather
often.

Is there way to power cycle the modem without reboot? That should make
the debugging... less bad.

Best regards,

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1209398322183268965==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscjFqYnNBQ2drUU1PZndhcFhiK3ZKQTdnQ2dqcm14NUlYUU5jeVNVaUp0QTFqdDZpR1kK
cUZNQW4zTS96Y2ozWm5KdUdKVDArM1N0WXZ6aVBscTUKPU5VZVQKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1209398322183268965==--


Content-Type: multipart/mixed; boundary="===============8594343206559614100=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: AT modem on Droid 4: where is my sms?
Date: Sat, 01 Aug 2020 21:13:25 +0200
Message-ID: <20200801191325.GB8032@amd>
In-Reply-To: <7733d88b-05d1-1b76-ed92-9a9eff076cbf@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8594343206559614100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >> I have problems with getting CNMA to work, so I'm exploring other
> >> possibilities. Apparently ofono should be able to work without
> >> that.. but is it working properly?
> >>
> >> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> >> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> >> ofonod[5218]: < \r\n+CMTI: "ME",2\r\n
> >> ofonod[5218]: drivers/atmodem/sms.c:at_cmti_notify() Got a CMTI
> >> indication at ME, index: 2
> >> ofonod[5218]: > AT+CMGR=3D2\r
> >> ofonod[5218]: < \r\nOK\r\n
> >
> > That's quite strange, CMGR response should have an intermediate
> > response prefixed by +CMGR: prior to the OK.=C2=A0 Your modem is just w=
eird ;)
> Just my guess. This can happen if another process (other than Ofono) is
> reading the tty channel.

There should not be such other process. And this is quite
reproducible..

It might be something power-management-related, I'm fighting with that
a lot; but I believe modem is simply weird.

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8594343206559614100==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsOGx2dFVBQ2drUU1PZndhcFhiK3ZKbjFnQ2NDSDhOL2IvUW0rWldIQWs5ZFhjWnhBZSsK
K2NBQW5qcWk5QTVBRTg1dFJRVHVVTWlXSTdydkpxVnIKPThZMWMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8594343206559614100==--


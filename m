Content-Type: multipart/mixed; boundary="===============2832544567802514810=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: AT modem on Droid 4: where is my sms?
Date: Sat, 01 Aug 2020 21:11:48 +0200
Message-ID: <20200801191148.GA8032@amd>
In-Reply-To: <05afe4c6-a81b-77e5-6e1e-6cb9d0f8f6a6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2832544567802514810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >I have problems with getting CNMA to work, so I'm exploring other
> >possibilities. Apparently ofono should be able to work without
> >that.. but is it working properly?
> >
> >ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> >ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> >ofonod[5218]: < \r\n+CMTI: "ME",2\r\n
> >ofonod[5218]: drivers/atmodem/sms.c:at_cmti_notify() Got a CMTI
> >indication at ME, index: 2
> >ofonod[5218]: > AT+CMGR=3D2\r
> >ofonod[5218]: < \r\nOK\r\n
> =

> That's quite strange, CMGR response should have an intermediate response
> prefixed by +CMGR: prior to the OK.  Your modem is just weird ;)

Yes, it is.

> >ofonod[5218]: > AT+CMGD=3D2\r
> >ofonod[5218]: < \r\nOK\r\n
> >ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> >ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> >
> >So.... modem told us we have new message and where it is, but then
> >ofono ... deleted the message without delivering it...?
> >
> =

> What the stock AT modem driver does is reads the message and deletes it
> right away.  Somehow your modem says 'sure' to the read request without
> actually reading the message.  Maybe the firmware is just too slow or oFo=
no
> is too fast, or maybe this modem needs extra special magic.

Would it make sense not to proceed with +CMGD in case modem did not
provide a message for +CMGR?

I don't think it is timing, as we see OK after CMGR...

Fortunately, I found a mode that works...

Best regards,
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2832544567802514810==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsOGx2blFBQ2drUU1PZndhcFhiK3ZLRitRQ2ZUaERoWmlYanNFbnoyRXdNb1F2eGtSTjUK
NU84QW5pMzR1UndiVWFYMWQzbEVXMzFmK1c2NDFHMjQKPXRYT2gKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2832544567802514810==--


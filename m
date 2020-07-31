Content-Type: multipart/mixed; boundary="===============8014611165820601746=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: AT modem on Droid 4: where is my sms?
Date: Fri, 31 Jul 2020 12:10:15 +0200
Message-ID: <20200731101015.GA23587@amd>
In-Reply-To: <20200731100750.GA22791@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8014611165820601746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri 2020-07-31 12:07:50, Pavel Machek wrote:
> Hi!
> =

> I have problems with getting CNMA to work, so I'm exploring other
> possibilities. Apparently ofono should be able to work without
> that.. but is it working properly?
> =

> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> ofonod[5218]: < \r\n+CMTI: "ME",2\r\n
> ofonod[5218]: drivers/atmodem/sms.c:at_cmti_notify() Got a CMTI
> indication at ME, index: 2
> ofonod[5218]: > AT+CMGR=3D2\r
> ofonod[5218]: < \r\nOK\r\n
> ofonod[5218]: > AT+CMGD=3D2\r
> ofonod[5218]: < \r\nOK\r\n
> ofonod[5218]: < \r\n+CIEV: 1,3\r\n
> ofonod[5218]: < \r\n+CIEV: 1,4\r\n
> =

> So.... modem told us we have new message and where it is, but then
> ofono ... deleted the message without delivering it...?

After a while, this appeared in the log:

ofonod[5218]: < \r\n+CIEV: 1,4\r\n
ofonod[5218]: < \r\n+CMTI: "ME",-1\r\n
ofonod[5218]: Unable to parse CMTI notification

Not sure what is going on there.

Best regards,								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8014611165820601746==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsOGo3Z2NBQ2drUU1PZndhcFhiK3ZKOWlnQ2ZXREF1bFBWZVJiUGpCcEtFQURML1ZzZ0UK
NU84QW4wditTcldJa2J6amgyMTRTdjNNWG1xM08rd3IKPThkN3oKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8014611165820601746==--


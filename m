Content-Type: multipart/mixed; boundary="===============7141858555669215728=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: AT modem on Droid 4: where is my sms?
Date: Fri, 31 Jul 2020 12:07:50 +0200
Message-ID: <20200731100750.GA22791@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7141858555669215728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I have problems with getting CNMA to work, so I'm exploring other
possibilities. Apparently ofono should be able to work without
that.. but is it working properly?

ofonod[5218]: < \r\n+CIEV: 1,3\r\n
ofonod[5218]: < \r\n+CIEV: 1,4\r\n
ofonod[5218]: < \r\n+CMTI: "ME",2\r\n
ofonod[5218]: drivers/atmodem/sms.c:at_cmti_notify() Got a CMTI
indication@ME, index: 2
ofonod[5218]: > AT+CMGR=3D2\r
ofonod[5218]: < \r\nOK\r\n
ofonod[5218]: > AT+CMGD=3D2\r
ofonod[5218]: < \r\nOK\r\n
ofonod[5218]: < \r\n+CIEV: 1,3\r\n
ofonod[5218]: < \r\n+CIEV: 1,4\r\n

So.... modem told us we have new message and where it is, but then
ofono ... deleted the message without delivering it...?

There's no new message@monitor-ofono...

Best regards,
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7141858555669215728==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsOGo3WFVBQ2drUU1PZndhcFhiK3ZLRnVRQ2VKOUp4a3k1T0RFMjhnQkl2MVJHWDJ0ZmIK
bXdRQW4xZnU5elgzVFdDWk4xcUQ0MUtobzdZNlRvblEKPWF0K1oKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============7141858555669215728==--


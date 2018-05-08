Content-Type: multipart/mixed; boundary="===============9079387059077899287=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Incoming sms problem on Motorola Droid 4
Date: Tue, 08 May 2018 23:51:02 +0200
Message-ID: <20180508215102.GA5253@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9079387059077899287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0

> AT+CNMI=3D?
< +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
< OK
ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> AT+CNMI=3D1,2,2,1,0
< OK
ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0

... unfortunately, with that configuration no messages are comming to
ofono and the other phone sees them as "delievery failed".

I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (not
PDU) messages. That works well enough for me.

Unfortunately, if I force ofono to pass "AT+CNMI=3D1,2", it does not
work well, either.

Any ideas how to debug this / what to try?

Thanks,

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============9079387059077899287==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnlHOFlBQ2drUU1PZndhcFhiK3ZKTUhRQ2ZjTEtwdXZNc1VlTCtsd2Q1OHRNRmppWkUK
bXFJQW5SdWtQRFFNa0pUSFZ6L25VZ0lHTTFja002ZVgKPVFMbTkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============9079387059077899287==--


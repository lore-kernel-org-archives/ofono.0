Content-Type: multipart/mixed; boundary="===============5582228052370585450=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Manually packetizing data for motorola modem was Re: Test clients for
 ofono: rfone, Unicsy Demo
Date: Sun, 03 Mar 2019 23:49:27 +0100
Message-ID: <20190303224927.GA12652@amd>
In-Reply-To: <20190214101117.GA6132@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5582228052370585450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'm still fighting with SMS sending on Motorola Droid 4. Yes, its
kernel driver is somehow interesting... and work in progress.

If packets are split correctly, SMS sending works. =


ofonod[2900]: OutSMS: > AT+GCMGS=3D\r
ofonod[2900]: OutSMS: > 3100098106343401F30000A70A73F45B4E07D1CB733A<CtrlZ>
ofonod[2900]: OutSMS: < +GCMGS=3D10,"00/00/00,01:00:00+00"\r\n

But if data are sent in one write, it does not... (and even this
is not easy to do with ofono).

ofonod[3131]: OutSMS: > AT+GCMGS=3D\r3100098106343401F30000A70A73F45B4E07D1=
CB733A<CtrlZ>
ofonod[3131]: OutSMS: < :ERROR=3D18\r\n
Handle command response: :ERROR=3D18
Handle terminator list

Is there easy way to do the splitting? I can do

        g_at_io_write(data->send_chat->parent->io, buf, strlen(buf));
 	g_io_channel_flush(data->send_chat->parent->io->channel, NULL);
						   =

But that needs exporting functions I guess you'd rather not have
exported.

Is there better way?

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5582228052370585450==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseDhXZmNBQ2drUU1PZndhcFhiK3ZJVkRBQ2dqL21OZzFxVytmMFY1MGVrWG55Z0dYRVQK
Sk9FQW4zU2ErLzQ4eE5TRUM1d3FIMlFEbWF5Yk9tdG0KPVFRMDMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5582228052370585450==--


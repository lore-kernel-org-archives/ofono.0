Content-Type: multipart/mixed; boundary="===============6765923715985325625=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Motorola motmdm support
Date: Sat, 29 Dec 2018 10:49:54 +0100
Message-ID: <20181229094953.GA15358@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6765923715985325625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Motorola phones use "interesting" setup.

There's qmi and "normal" (but very buggy) AT interface on
them. Unfortunately that uses USB and uses too much power (which is a
problem on phone).

Plus there's /dev/motmdm1, motmdm3 and motmdm9, multiplexed over
serial line.

It uses subset of AT commands (good) with slightly modified
protocol... it says ":OK" instead of "OK" and puts ~ before
unsolicited messages.

Other major difference is that commands need to be sent to the right
device. It seems motmdm1 is for status and call control, and motmdm9
is for incoming sms.

I guess that right way to do this is to introduce
drivers/motorolamodem (or can we just have drivers/motorola?).

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6765923715985325625==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd25RMEVBQ2drUU1PZndhcFhiK3ZJbHBBQ2ZkWndvVEtCVUwvRWdKNmdqRnltUGp6b2gK
c0tjQW4zWlpMRjQ4bzJobk9SODk3Qyt6US9yOGdwRFAKPXBXUmsKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6765923715985325625==--


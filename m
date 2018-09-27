Content-Type: multipart/mixed; boundary="===============5999678737509459490=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Better help for delivery reports
Date: Thu, 27 Sep 2018 23:47:44 +0200
Message-ID: <20180927214744.GF17346@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5999678737509459490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Explain "delivery report" parameter in send-sms.

diff --git a/test/send-sms b/test/send-sms
index 98808aaf..cabe0652 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -6,6 +6,7 @@ import dbus
 if len(sys.argv) < 4:
 	print("Usage: %s [modem] <to> <message> <delivery report>" %\
 					(sys.argv[0]))
+	print("  where delivery report is 0|1")
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5999678737509459490==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdXRVQUFBQ2drUU1PZndhcFhiK3ZMenpRQ2dweWR3alptVGp3b2hWcVVuaElxR3BQV2cK
aVBZQW5SMG9zMXpNOXFIci9wd24vTzVLalhuRldZOEEKPUI2SVoKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5999678737509459490==--


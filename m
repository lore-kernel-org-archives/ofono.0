Content-Type: multipart/mixed; boundary="===============3624185198308736957=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Better help text for dial-number
Date: Fri, 01 Feb 2019 22:00:56 +0100
Message-ID: <20190201210056.GA10509@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3624185198308736957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Better help text for "dial-number". Without details, user may be
tempted to pass 0|1 (as send-sms uses) or true|false.

diff --git a/test/dial-number b/test/dial-number
index fe5adad3..4c0ee142 100755
--- a/test/dial-number
+++ b/test/dial-number
@@ -4,7 +4,8 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print("Usage: %s [modem] <number> [hide_callerid]" % (sys.argv[0]))
+	print("Usage: %s [modem] <number> [enabled|disabled|default]" % (sys.argv=
[0]))
+	print("Last argument enables/disables callerid")
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============3624185198308736957==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseFVzNGdBQ2drUU1PZndhcFhiK3ZKeUV3Q2ZkT2x3MG1oeEpSV0dIMTBaQ2V4c2NzN2wK
MFVBQW5BdXd4Q0JCc1NnOERqVlh1TlA2V2huYmFQSUgKPStQcWsKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============3624185198308736957==--


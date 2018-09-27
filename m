Content-Type: multipart/mixed; boundary="===============4929290957476336405=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Fix typo in location-reporting-api.txt.
Date: Thu, 27 Sep 2018 23:47:15 +0200
Message-ID: <20180927214715.GC17346@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4929290957476336405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Fix typo in location-reporting-api.txt.

diff --git a/doc/location-reporting-api.txt b/doc/location-reporting-api.txt
index 21e346d4..ff0a35dc 100644
--- a/doc/location-reporting-api.txt
+++ b/doc/location-reporting-api.txt
@@ -13,7 +13,7 @@ Methods		dict GetProperties()
 		filedescriptor Request()
 =

 			Asks to turn ON the NMEA stream and supplies the
-			gps device file descriptor. The external cliend should
+			gps device file descriptor. The external client should
 			use the file descriptor to receive the NMEA data.
 =

 			Possible Errors: [service].Error.InProgress

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4929290957476336405==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdXRUK01BQ2drUU1PZndhcFhiK3ZKaGV3Q2ZXYVVhQWFkbGNpdTFxK1Z5dVFXS0VaYXQK
OC9NQW4zZkpDbUJPcGZNRldXQkNPZXMxQlVMdENHVm0KPTJaSmEKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4929290957476336405==--


Content-Type: multipart/mixed; boundary="===============8357462416140809923=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] simple fixes
Date: Wed, 09 May 2018 16:33:56 +0200
Message-ID: <20180509143356.GA28193@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8357462416140809923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix typo in location-reporting-api.txt.

AFAICT, at_cmt_notify() calls ofono_error even in case stuff is
okay. Fix that.

Move debug print to more useful place in setup_gobi().

Explain  "delivery report" parameter in send-sms.

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
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 68b89862..217971e7 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -440,6 +436,8 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
 		at_ack_delivery(sms);
 =

+	return;
+
 err:
 	ofono_error("Unable to parse CMT notification");
 }
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..a4b18488 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -233,10 +233,11 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
 =

+	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
+	=

 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
 		return FALSE;
 =

-	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
diff --git a/test/send-sms b/test/send-sms
index 98808aaf..cabe0652 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -6,6 +6,7 @@ import dbus
 if len(sys.argv) < 4:
 	print("Usage: %s [modem] <to> <message> <delivery report>" %\
 					(sys.argv[0]))
+        print("  where delivery report is 0|1")
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8357462416140809923==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnpCdFFBQ2drUU1PZndhcFhiK3ZLTHh3Q2dvWGZWV0NZUTBScDBWSE5TOHhCRGM5TU8K
dWZVQW4yZXFuVnEwUmpDZzdOT0ZDWm5GVVV2VEF3QXgKPUZoYXgKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8357462416140809923==--


Content-Type: multipart/mixed; boundary="===============4353128950924717905=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Fix error handling in at_cmt_notify()
Date: Thu, 27 Sep 2018 23:47:24 +0200
Message-ID: <20180927214724.GD17346@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4353128950924717905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


at_cmt_notify() calls ofono_error even in case stuff is
okay. Fix that.

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

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4353128950924717905==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdXRUK3dBQ2drUU1PZndhcFhiK3ZLL3FnQ2ZaNHhzaEFacHBFVTAybitBT2RnRnFxWkoK
WUdrQW5pK0haL2lTQ2ZIN3dKVVlrUGZ6UDA5VXFwb3MKPU1WeFUKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4353128950924717905==--


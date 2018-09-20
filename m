Content-Type: multipart/mixed; boundary="===============6430055314923285942=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: added missing return in at_cmt_notify before
 error processing
Date: Thu, 20 Sep 2018 07:08:09 +0200
Message-ID: <1537420089-25524-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6430055314923285942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 7e78fcf..fb4d67a 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -455,6 +455,7 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
 		at_ack_delivery(sms);
+	return;
 =

 err:
 	ofono_error("Unable to parse CMT notification");
-- =

1.9.1


--===============6430055314923285942==--


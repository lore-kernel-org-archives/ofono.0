Content-Type: multipart/mixed; boundary="===============4709685983808375327=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 05/12] Modify ussd parser
Date: Sun, 13 Jun 2010 17:43:15 +0800
Message-ID: <1276422202-16240-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4709685983808375327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Original code doesn't call unpack_7bit(), which seems not correct.
* An utility function is used to handle it, which supports 8-bit
and ucs2 besides 7-bit character.
* Status is assigned with correct value when error occurs
---
 drivers/atmodem/ussd.c |   33 ++++++---------------------------
 1 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 555ce13..2b006eb 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -40,6 +40,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "ussdutil.h"
 =

 struct cusd_req {
 	ofono_ussd_cb_t cb;
@@ -53,14 +54,10 @@ static const char *none_prefix[] =3D { NULL };
 static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 {
 	GAtResultIter iter;
-	int status;
 	int dcs;
 	const char *content;
+	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
 	char *converted =3D NULL;
-	gboolean udhi;
-	enum sms_charset charset;
-	gboolean compressed;
-	gboolean iso639;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -76,32 +73,14 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 	if (!g_at_result_iter_next_number(&iter, &dcs))
 		goto out;
 =

-	if (!cbs_dcs_decode(dcs, &udhi, NULL, &charset,
-				&compressed, NULL, &iso639))
-		goto out;
-
-	if (udhi || compressed || iso639)
-		goto out;
+	converted =3D ussd_decode(dcs, strlen(content), (unsigned char *)content);
 =

-	if (charset =3D=3D SMS_CHARSET_7BIT)
-		converted =3D convert_gsm_to_utf8((const guint8 *) content,
-						strlen(content), NULL, NULL, 0);
-
-	else if (charset =3D=3D SMS_CHARSET_8BIT) {
-		/* TODO: Figure out what to do with 8 bit data */
-		ofono_error("8-bit coded USSD response received");
-		status =3D 4; /* Not supported */
-	} else {
-		/* No other encoding is mentioned in TS27007 7.15 */
-		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
-		status =3D 4; /* Not supported */
-	}
+	if (converted)
+		status =3D OFONO_USSD_STATUS_NOTIFY;
 =

 out:
 	ofono_ussd_notify(ussd, status, converted);
-
-	if (converted)
-		g_free(converted);
+	g_free(converted);
 }
 =

 static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
-- =

1.7.0.4


--===============4709685983808375327==--


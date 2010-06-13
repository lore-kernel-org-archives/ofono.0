Content-Type: multipart/mixed; boundary="===============0538522533732077980=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 06/12] Refactor ussd parser
Date: Sun, 13 Jun 2010 17:43:16 +0800
Message-ID: <1276422202-16240-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0538522533732077980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/ussd.c |   36 +++++++-----------------------------
 1 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 8be20b6..10bee0f 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -47,6 +47,7 @@
 #include "isiutil.h"
 #include "ss.h"
 #include "debug.h"
+#include "ussdutil.h"
 =

 struct ussd_data {
 	GIsiClient *client;
@@ -73,44 +74,21 @@ static void ussd_parse(struct ofono_ussd *ussd, const v=
oid *restrict data,
 			size_t len)
 {
 	const unsigned char *msg =3D data;
-	unsigned char buf[256];
-	unsigned char *unpacked;
-	long written;
-	int status;
+	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
 	char *converted =3D NULL;
-	gboolean udhi;
-	enum sms_charset charset;
-	gboolean compressed;
-	gboolean iso639;
 =

 	if (!msg || len < 4)
-		goto error;
+		goto out;
 =

 	status =3D isi_type_to_status(msg[2]);
 =

 	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
-		goto error;
-
-	if (!cbs_dcs_decode(msg[1], &udhi, NULL, &charset,
-				&compressed, NULL, &iso639))
-		goto error;
-
-	if (udhi || compressed || iso639)
-		goto error;
-
-	if (charset !=3D SMS_CHARSET_7BIT)
-		goto error;
-
-	unpacked =3D unpack_7bit_own_buf(msg + 4, msg[3], 0, TRUE,
-					SS_MAX_USSD_LENGTH, &written, 0, buf);
+		goto out;
 =

-	converted =3D convert_gsm_to_utf8((const guint8 *)unpacked, written,
-					NULL, NULL, 0);
+	converted =3D ussd_decode(msg[1], msg[3], msg + 4);
 =

-	goto out;
-
-error:
-	status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
+	if (converted)
+		status =3D OFONO_USSD_STATUS_NOTIFY;
 =

 out:
 	ofono_ussd_notify(ussd, status, converted);
-- =

1.7.0.4


--===============0538522533732077980==--


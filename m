Content-Type: multipart/mixed; boundary="===============3969129896960363688=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH 1/2] ste: Add support for multiple pdp contexts.
Date: Tue, 08 Feb 2011 12:17:26 +0100
Message-ID: <1297163846-27817-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3969129896960363688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 plugins/ste.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index cf8aed8..749c4f3 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -66,6 +66,7 @@
 #include <drivers/stemodem/if_caif.h>
 =

 #define NUM_CHAT	1
+#define MAX_PDP_CONTEXTS	4
 =

 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 =

@@ -363,6 +364,7 @@ static void ste_post_online(struct ofono_modem *modem)
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	int i;
 =

 	DBG("%p", modem);
 =

@@ -378,13 +380,18 @@ static void ste_post_online(struct ofono_modem *modem)
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+	if (gprs) {
+		for (i =3D 0; i < MAX_PDP_CONTEXTS; i++) {
+			gc =3D ofono_gprs_context_create(
+					modem, 0, "stemodem", data->chat);
+			if (gc =3D=3D NULL)
+				break;
+
+			ofono_gprs_add_context(gprs, gc);
+		}
+	}
 =

 	mw =3D ofono_message_waiting_create(modem);
-
 	if (mw)
 		ofono_message_waiting_register(mw);
 }
-- =

1.7.1


--===============3969129896960363688==--


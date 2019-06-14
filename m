Content-Type: multipart/mixed; boundary="===============8145018764099862672=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7modem: fix to activate context with cid zero
Date: Fri, 14 Jun 2019 14:56:36 +0530
Message-ID: <1560504396-8891-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8145018764099862672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

xmm7modem returns 0 as cid for default pdp context. Thus
initializing last_auto_context_id to -1 to indicate a deactivated
context.
---
 drivers/atmodem/gprs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index dd73458..fbee5c9 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -48,7 +48,7 @@ static const char *none_prefix[] =3D { NULL };
 struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
-	unsigned int last_auto_context_id;
+	int last_auto_context_id;
 	gboolean telit_try_reattach;
 	int attached;
 };
@@ -161,7 +161,7 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult *=
result,
 		return;
 	}
 =

-	if (gd->last_auto_context_id =3D=3D 0) {
+	if (gd->last_auto_context_id =3D=3D -1) {
 		DBG("Context got deactivated while calling CGDCONT");
 		return;
 	}
@@ -257,11 +257,11 @@ static void cgev_notify(GAtResult *result, gpointer u=
ser_data)
 		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
 				at_cgdcont_read_cb, gprs, NULL);
 	} else if (g_str_has_prefix(event, "ME PDN DEACT")) {
-		unsigned int context_id;
+		int context_id;
 		sscanf(event, "%*s %*s %*s %u", &context_id);
 		/* Indicate that this cid is not activated anymore */
 		if (gd->last_auto_context_id =3D=3D context_id)
-			gd->last_auto_context_id =3D 0;
+			gd->last_auto_context_id =3D -1;
 	}
 }
 =

@@ -632,6 +632,7 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	gd->chat =3D g_at_chat_clone(chat);
 	gd->vendor =3D vendor;
+	gd->last_auto_context_id =3D -1;
 =

 	ofono_gprs_set_data(gprs, gd);
 =

-- =

1.9.1


--===============8145018764099862672==--


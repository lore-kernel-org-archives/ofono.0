Content-Type: multipart/mixed; boundary="===============2465032592926127731=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 9/9] ubloxmodem: support automatic ctx activation
Date: Thu, 17 Mar 2016 18:02:20 +0100
Message-ID: <1458234140-7936-10-git-send-email-dragos@endocode.com>
In-Reply-To: <1458234140-7936-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2465032592926127731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

... by imlementing read_settings.
---
 drivers/ubloxmodem/gprs-context.c | 39 +++++++++++++++++++++++++++++------=
----
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 63f6ac2..25e0447 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -35,6 +35,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs-context.h>
+#include <ofono/gprs.h>
 =

 #include "gatchat.h"
 #include "gatresult.h"
@@ -181,6 +182,27 @@ static void ublox_read_settings(struct ofono_gprs_cont=
ext *gc)
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

+static void ublox_gprs_read_settings(struct ofono_gprs_context *gc,
+					const struct ofono_gprs_primary_context *ctx,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	DBG("cid %u", ctx->cid);
+
+	gcd->active_context =3D ctx->cid;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	ublox_read_settings(gc);
+}
+
 static void cgact_enable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -370,6 +392,7 @@ static void cgev_notify(GAtResult *result, gpointer use=
r_data)
 	GAtResultIter iter;
 	const char *event;
 	gint cid;
+	char tmp[16] =3D {0};
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -379,16 +402,11 @@ static void cgev_notify(GAtResult *result, gpointer u=
ser_data)
 	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
 		return;
 =

-	if (g_str_has_prefix(event, "NW PDN DEACT")) {
-		if (!g_at_result_iter_skip_next(&iter))
-			return;
-	} else if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE)
-		return;
-
-	if (!g_at_result_iter_skip_next(&iter))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &cid))
+	if (g_str_has_prefix(event, "NW PDN DEACT"))
+		sscanf(event, "%s %s %s %u", tmp, tmp, tmp, &cid);
+	else if (g_str_has_prefix(event, "NW DEACT"))
+		sscanf(event, "%s %s %u", tmp, tmp, &cid);
+	else
 		return;
 =

 	DBG("cid %d", cid);
@@ -440,6 +458,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.remove			=3D ublox_gprs_context_remove,
 	.activate_primary	=3D ublox_gprs_activate_primary,
 	.deactivate_primary	=3D ublox_gprs_deactivate_primary,
+	.read_settings		=3D ublox_gprs_read_settings,
 };
 =

 void ublox_gprs_context_init(void)
-- =

2.5.0


--===============2465032592926127731==--


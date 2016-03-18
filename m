Content-Type: multipart/mixed; boundary="===============1154434077015685898=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 5/5] ubloxmodem: support automatic ctx activation
Date: Fri, 18 Mar 2016 11:47:10 +0100
Message-ID: <1458298030-30455-9-git-send-email-dragos@endocode.com>
In-Reply-To: <1458298030-30455-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1154434077015685898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

... by imlementing read_settings.
---
 drivers/ubloxmodem/gprs-context.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 63f6ac2..23c27aa 100644
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
@@ -181,6 +182,21 @@ static void ublox_read_settings(struct ofono_gprs_cont=
ext *gc)
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

+static void ublox_gprs_read_settings(struct ofono_gprs_context *gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("cid %u", cid);
+
+	gcd->active_context =3D cid;
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
@@ -379,16 +395,11 @@ static void cgev_notify(GAtResult *result, gpointer u=
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
+		sscanf(event, "%*s %*s %*s %u", &cid);
+	else if (g_str_has_prefix(event, "NW DEACT"))
+		sscanf(event, "%*s %*s %u", &cid);
+	else
 		return;
 =

 	DBG("cid %d", cid);
@@ -440,6 +451,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.remove			=3D ublox_gprs_context_remove,
 	.activate_primary	=3D ublox_gprs_activate_primary,
 	.deactivate_primary	=3D ublox_gprs_deactivate_primary,
+	.read_settings		=3D ublox_gprs_read_settings,
 };
 =

 void ublox_gprs_context_init(void)
-- =

2.5.0


--===============1154434077015685898==--


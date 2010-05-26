Content-Type: multipart/mixed; boundary="===============1317771195104080552=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v3 1/2] atmodem: remove CGACT command
Date: Wed, 26 May 2010 18:31:34 +0300
Message-ID: <20100526153134.2330.70055.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1317771195104080552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's enough that we shutdown PPP, no need to send CGACT after that.
Recommended by Denis.
---

 drivers/atmodem/gprs-context.c |   51 +++++++++++++-----------------------=
----
 1 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index ba5f0c0..9b32d59 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -65,22 +65,6 @@ struct gprs_context_data {
 	void *cb_data;                                  /* Callback data */
 };
 =

-static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_cb_t cb =3D cbd->cb;
-	struct ofono_gprs_context *gc =3D cbd->user;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct ofono_error error;
-
-	if (ok)
-		gcd->active_context =3D 0;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	cb(&error, cbd->data);
-}
-
 static void ppp_connect(const char *interface, const char *ip,
 			const char *dns1, const char *dns2,
 			gpointer user_data)
@@ -104,13 +88,21 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 	struct ofono_gprs_context *gc =3D user_data;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

-	if (gcd->state =3D=3D STATE_ENABLING) {
+	DBG("");
+
+	switch (gcd->state) {
+	case STATE_ENABLING:
 		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
 					NULL, NULL, NULL, gcd->cb_data);
-		return;
+		break;
+	case STATE_DISABLING:
+		CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
+		break;
+	default:
+		ofono_gprs_context_deactivated(gc, gcd->active_context);
+		break;
 	}
 =

-	ofono_gprs_context_deactivated(gc, gcd->active_context);
 	gcd->active_context =3D 0;
 	gcd->state =3D STATE_IDLE;
 }
@@ -227,25 +219,14 @@ static void at_gprs_deactivate_primary(struct ofono_g=
prs_context *gc,
 					ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char buf[64];
-
-	if (!cbd)
-		goto error;
-
-	cbd->user =3D gc;
 =

-	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", id);
+	DBG("");
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				at_cgact_down_cb, cbd, g_free) > 0)
-		return;
-
-error:
-	if (cbd)
-		g_free(cbd);
+	gcd->state =3D STATE_DISABLING;
+	gcd->down_cb =3D cb;
+	gcd->cb_data =3D data;
 =

-	CALLBACK_WITH_FAILURE(cb, data);
+	g_at_ppp_shutdown(gcd->ppp);
 }
 =

 static int at_gprs_context_probe(struct ofono_gprs_context *gc,


--===============1317771195104080552==--


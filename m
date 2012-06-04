Content-Type: multipart/mixed; boundary="===============1894308802249388974=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] atmodem: check the Packet Domain service state before
 attaching
Date: Mon, 04 Jun 2012 18:21:27 +0200
Message-ID: <1338826887-12028-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1894308802249388974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c |   66 ++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 65a8b7b..3be0a9d 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -44,6 +44,7 @@
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *cgatt_prefix[] =3D { "+CGATT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
@@ -62,17 +63,74 @@ static void at_cgatt_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

+static void at_cgatt_query_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_cb_t cb =3D cbd->cb;
+	struct gprs_data *gd =3D cbd->user;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int state;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, cbd->data);
+		g_free(cbd);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGATT:")) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+		return;
+	}
+
+	g_at_result_iter_next_number(&iter, &state);
+
+	switch (state) {
+	case 0:
+		if (g_at_chat_send(gd->chat, "AT+CGATT=3D1", none_prefix,
+					at_cgatt_cb, cbd, g_free) > 0)
+			return;
+
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		break;
+	case 1:
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		break;
+	}
+
+	g_free(cbd);
+}
+
 static void at_gprs_set_attached(struct ofono_gprs *gprs, int attached,
 					ofono_gprs_cb_t cb, void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char buf[64];
 =

-	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
+	cbd->user =3D gd;
 =

-	if (g_at_chat_send(gd->chat, buf, none_prefix,
-				at_cgatt_cb, cbd, g_free) > 0)
+	/*
+	 * Before attaching, check the current state.
+	 * If we are already attached to the packet domain service, it means
+	 * that the attachment is done automatically at power on.
+	 * If we send again the command +CGATT, this command should be ignored
+	 * by the modem but some of them are initiating a complete new
+	 * attachment procedure resulting in a preliminary IMSI/P-TMSI detach.
+	 * To prevent such bad behavior, the command +CGATT is not sent if the
+	 * modem is already in the requested state.
+	 */
+	if (attached =3D=3D TRUE) {
+		if (g_at_chat_send(gd->chat, "AT+CGATT?", cgatt_prefix,
+					at_cgatt_query_cb, cbd, NULL) > 0)
+		return;
+	} else if (g_at_chat_send(gd->chat, "AT+CGATT=3D0", none_prefix,
+					at_cgatt_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
-- =

1.7.9.5


--===============1894308802249388974==--


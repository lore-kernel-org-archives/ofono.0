Content-Type: multipart/mixed; boundary="===============7230518248670984563=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 2/2] atmodem: Implement the get_active_auto_context callback
Date: Sun, 11 Aug 2019 18:46:31 +0200
Message-ID: <20190811164631.16804-2-richard.rojfors@gmail.com>
In-Reply-To: <20190811164631.16804-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7230518248670984563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

The callback calls cgact and cgdcont to get information
regarding any auto activated context.
---
 drivers/atmodem/gprs.c | 115 +++++++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 27 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 10108281..f08dc00c 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -146,27 +146,11 @@ static void at_gprs_registration_status(struct ofono_=
gprs *gprs,
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

-static void at_cgdcont_read_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+static const char *at_cgdcont_parse(GAtResult *result, int cid)
 {
-	struct ofono_gprs *gprs =3D user_data;
-	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-	int activated_cid =3D gd->last_auto_context_id;
 	const char *apn =3D NULL;
 	GAtResultIter iter;
 =

-	DBG("ok %d", ok);
-
-	if (!ok) {
-		ofono_warn("Can't read CGDCONT contexts.");
-		return;
-	}
-
-	if (gd->last_auto_context_id =3D=3D -1) {
-		DBG("Context got deactivated while calling CGDCONT");
-		return;
-	}
-
 	g_at_result_iter_init(&iter, result);
 =

 	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
@@ -175,7 +159,7 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult *=
result,
 		if (!g_at_result_iter_next_number(&iter, &read_cid))
 			break;
 =

-		if (read_cid !=3D activated_cid)
+		if (read_cid !=3D cid)
 			continue;
 =

 		/* ignore protocol */
@@ -186,6 +170,31 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult =
*result,
 		break;
 	}
 =

+	return apn;
+}
+
+static void at_cgdcont_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	int activated_cid =3D gd->last_auto_context_id;
+	const char *apn =3D NULL;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_warn("Can't read CGDCONT contexts.");
+		return;
+	}
+
+	if (activated_cid =3D=3D -1) {
+		DBG("Context got deactivated while calling CGDCONT");
+		return;
+	}
+
+	apn =3D at_cgdcont_parse(result, activated_cid);
+
 	if (apn)
 		ofono_gprs_cid_activated(gprs, activated_cid, apn);
 	else
@@ -193,16 +202,46 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult=
 *result,
 				activated_cid);
 }
 =

+static void at_cgdcont_act_read_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct gprs_data *gd =3D cbd->user;
+	ofono_gprs_active_context_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int activated_cid =3D gd->last_auto_context_id;
+	const char *apn =3D NULL;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		ofono_warn("Can't read CGDCONT contexts.");
+
+		activated_cid =3D -1;
+	} else  if (activated_cid !=3D -1) {
+		apn =3D at_cgdcont_parse(result, activated_cid);
+	}
+
+	cb(&error, activated_cid, apn, cbd->data);
+}
+
 static void at_cgact_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
-	struct ofono_gprs *gprs =3D user_data;
-	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd =3D user_data;
+	struct gprs_data *gd =3D cbd->user;
+	ofono_gprs_active_context_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
 	GAtResultIter iter;
 =

-	DBG("ok %d", ok);
+	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
 		ofono_warn("Can't read CGACT contexts.");
+
+		cb(&error, -1, NULL, cbd->data);
+
+		g_free(cbd);
+
 		return;
 	}
 =

@@ -222,17 +261,42 @@ static void at_cgact_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 			continue;
 =

 		/* Flag this as auto context as it was obviously active */
-		if (gd->last_auto_context_id =3D=3D 0)
+		if (gd->last_auto_context_id =3D=3D -1)
 			gd->last_auto_context_id =3D read_cid;
 =

 		if (read_cid !=3D gd->last_auto_context_id)
 			continue;
 =

 		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
-				at_cgdcont_read_cb, gprs, NULL);
+				at_cgdcont_act_read_cb, cbd, g_free);
 =

 		break;
 	}
+
+	if (gd->last_auto_context_id =3D=3D -1) {
+		/* No error, but no auto activated contexts... */
+		cb(&error, -1, NULL, cbd->data);
+
+		g_free(cbd);
+	}
+}
+
+static void at_gprs_get_active_auto_context(struct ofono_gprs *gprs,
+					    ofono_gprs_active_context_cb_t cb,
+					    void *data)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	cbd->user =3D gd;
+
+	if (g_at_chat_send(gd->chat, "AT+CGACT?", cgact_prefix,
+				at_cgact_cb, cbd, NULL))
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, NULL, data);
 }
 =

 static void cgreg_notify(GAtResult *result, gpointer user_data)
@@ -538,10 +602,6 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		break;
 	}
 =

-	/* Check if there is any already activated contexts at init */
-	g_at_chat_send(gd->chat, "AT+CGACT?", cgact_prefix,
-			at_cgact_cb, gprs, NULL);
-
 	ofono_gprs_register(gprs);
 }
 =

@@ -705,6 +765,7 @@ static const struct ofono_gprs_driver driver =3D {
 	.remove			=3D at_gprs_remove,
 	.set_attached		=3D at_gprs_set_attached,
 	.attached_status	=3D at_gprs_registration_status,
+	.get_active_auto_context=3D at_gprs_get_active_auto_context,
 };
 =

 void at_gprs_init(void)
-- =

2.20.1


--===============7230518248670984563==--


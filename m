Content-Type: multipart/mixed; boundary="===============2296319095411926355=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 1/2] gemalto: gprs: support automatic context activation
Date: Sat, 26 Dec 2020 23:56:41 +0300
Message-ID: <20201226205642.10332-2-geomatsi@gmail.com>
In-Reply-To: <20201226205642.10332-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2296319095411926355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement read_settings function to get configuration for automatic
contexts. AT^SWWAN command activates PDP context unless it has been
already activated automatically, and then starts DHCP server in the
ME. So AT^SWWAN command should be run for automatic context as well
in order to obtain IP settings from the ME.

This commit also fixes the issue uncovered by the added support for
automatic contexts: as per modem specs, AT+CGACT context should not
be reused for AT^SWWAN. Though that worked for some reason when
automatic context was reactivated without proper deactivation.

Note that in both cases success code is reported to the core before
AT^SWWAN response. This is because the ME waits until DHCP negotiation
has finished before sending the "OK" or "ERROR" result code.
---
 drivers/gemaltomodem/gprs-context.c | 116 +++++++++++++++++-----------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/gpr=
s-context.c
index 13a858d4..99cb4114 100644
--- a/drivers/gemaltomodem/gprs-context.c
+++ b/drivers/gemaltomodem/gprs-context.c
@@ -51,70 +51,63 @@ struct gprs_context_data {
 	void *cb_data;
 };
 =

-static void cgact_enable_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+static void set_gprs_context_interface(struct ofono_gprs_context *gc)
 {
-	struct ofono_gprs_context *gc =3D user_data;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct ofono_modem *modem;
 	const char *interface;
-	char buf[64];
+
+	modem =3D ofono_gprs_context_get_modem(gc);
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	ofono_gprs_context_set_interface(gc, interface);
+
+	/* Use DHCP */
+	ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
+}
+
+static void swwan_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
 =

 	DBG("ok %d", ok);
 =

 	if (!ok) {
-		struct ofono_error error;
-
+		ofono_error("Unable to activate context");
+		ofono_gprs_context_deactivated(gc, gcd->active_context);
 		gcd->active_context =3D 0;
-
 		decode_at_error(&error, g_at_result_final_response(result));
 		gcd->cb(&error, gcd->cb_data);
-
 		return;
 	}
-
-	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
-
-	modem =3D ofono_gprs_context_get_modem(gc);
-	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
-	ofono_gprs_context_set_interface(gc, interface);
-
-	/* Use DHCP */
-	ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
-
-	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

 static void cgdcont_enable_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+			gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
 	char buf[64];
 =

 	DBG("ok %d", ok);
 =

 	if (!ok) {
-		struct ofono_error error;
-
 		gcd->active_context =3D 0;
-
 		decode_at_error(&error, g_at_result_final_response(result));
 		gcd->cb(&error, gcd->cb_data);
-
 		return;
 	}
 =

-	snprintf(buf, sizeof(buf), "AT+CGACT=3D1,%u", gcd->active_context);
+	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
 =

-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				cgact_enable_cb, gc, NULL) =3D=3D 0)
-		goto error;
+	if (g_at_chat_send(gcd->chat, buf, none_prefix, swwan_cb, gc, NULL)) {
+		set_gprs_context_interface(gc);
 =

-	return;
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+		return;
+	}
 =

-error:
 	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

@@ -152,31 +145,27 @@ static void gemalto_gprs_activate_primary(struct ofon=
o_gprs_context *gc,
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", ctx->apn);
 =

 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				cgdcont_enable_cb, gc, NULL) > 0)
+				cgdcont_enable_cb, gc, NULL))
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void cgact_disable_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+static void deactivate_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	char buf[64];
 =

 	DBG("ok %d", ok);
 =

+	gcd->active_context =3D 0;
+
 	if (!ok) {
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 		return;
 	}
 =

-	snprintf(buf, sizeof(buf), "AT^SWWAN=3D0,%u", gcd->active_context);
-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
-
-	gcd->active_context =3D 0;
-
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

@@ -193,17 +182,49 @@ static void gemalto_gprs_deactivate_primary(struct of=
ono_gprs_context *gc,
 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
 =

-	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", cid);
+	snprintf(buf, sizeof(buf), "AT^SWWAN=3D0,%u", gcd->active_context);
 =

 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				cgact_disable_cb, gc, NULL) =3D=3D 0)
-		goto error;
-
-	return;
+				deactivate_cb, gc, NULL))
+		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, data);
+}
 =

+static void gemalto_gprs_read_settings(struct ofono_gprs_context *gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("cid %u", cid);
+
+	gcd->active_context =3D cid;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	/*
+	 * AT^SWWAN command activates PDP context unless it has been already
+	 * activated automatically, and then starts DHCP server in the ME.
+	 * So AT^SWWAN command should be run in both cases:
+	 * - when activate context and then obtain IP address from the ME
+	 * - when obtain IP address from the automatically activated context
+	 *
+	 * Note that the ME waits until DHCP negotiation has finished before
+	 * sending the "OK" or "ERROR" result code. So success is reported
+	 * to the core before AT^SWWAN response.
+	 */
+	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix, swwan_cb, gc, NULL)) {
+		set_gprs_context_interface(gc);
+
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

 static void cgev_notify(GAtResult *result, gpointer user_data)
@@ -275,6 +296,7 @@ static const struct ofono_gprs_context_driver driver =
=3D {
 	.remove			=3D gemalto_gprs_context_remove,
 	.activate_primary	=3D gemalto_gprs_activate_primary,
 	.deactivate_primary	=3D gemalto_gprs_deactivate_primary,
+	.read_settings		=3D gemalto_gprs_read_settings,
 };
 =

 void gemalto_gprs_context_init(void)
-- =

2.29.2

--===============2296319095411926355==--


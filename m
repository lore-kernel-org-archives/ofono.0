Content-Type: multipart/mixed; boundary="===============0694494317070824710=="
MIME-Version: 1.0
From: Yevhen Kyriukha <kirgene@gmail.com>
Subject: [PATCH v2] atmodem: reset modem if it stops responding.
Date: Fri, 28 Jun 2013 20:19:19 +0300
Message-ID: <1372439959-4846-1-git-send-email-kirgene@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0694494317070824710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'd tested a lot of ZTE and Huawei modems and noticed that each of them can
hang and become unusable anymore for establishing internet connection.
Some modems may hang right after boot, some of them after connection was
dropped several times.
The problem is that the "Modem" port hangs and doesn't accept any commands.
The only way to bring it to work is to reset the modem.

This is very important issue for devices that needs to be connected through
3G modem all the time and work in automatic mode!

So I created a patch that resolves this issue by checking modem port before
establishing connection.
If we get no answer during some time, we reset the modem and it can be
usable again.

---
 drivers/atmodem/gprs-context.c |   84 +++++++++++++++++++++++++++++++++---=
----
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 3694c27..730ba6e 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -59,6 +59,8 @@ enum state {
 struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
+	guint modem_ready_timeout;
+	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtPPP *ppp;
@@ -219,13 +221,73 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

+static void activate_primary(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	int len;
+
+	DBG("cid %u", gcd->active_context);
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", gcd->active_=
context);
+
+	if (gcd->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", gcd->apn);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix, at_cgdcont_cb, gc, NULL) =
> 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static gboolean at_modem_not_ready_cb(gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtChat *chat =3D g_at_chat_get_slave(gcd->chat);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+	gcd->modem_ready_timeout =3D 0;
+
+	ofono_error("Modem not responding");
+	DBG("resetting modem...");
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+
+	g_at_chat_send(chat, "AT+CFUN=3D1,1", none_prefix, NULL, NULL, NULL);
+
+	return FALSE;
+}
+
+static void at_modem_ready_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	if (gcd->modem_ready_timeout =3D=3D 0)
+		return;  // Too late, modem already been reset
+	DBG("modem is ready");
+	g_source_remove(gcd->modem_ready_timeout);
+	activate_primary(gc);
+}
+
+static void at_activate_primary_with_check(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	gcd->modem_ready_timeout =3D g_timeout_add_seconds(70, at_modem_not_ready=
_cb, gc);
+	g_at_chat_send(gcd->chat, "AT", none_prefix, at_modem_ready_cb, gc, NULL);
+}
+
+static void at_gprs_activate_primary_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
+{
+	at_activate_primary_with_check(user_data);
+}
+
 static void at_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
-	int len;
 =

 	/* IPv6 support not implemented */
 	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
@@ -238,6 +300,7 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 	gcd->cb_data =3D data;
 	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
 	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+	memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));
 =

 	gcd->state =3D STATE_ENABLING;
 =

@@ -258,19 +321,14 @@ static void at_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 		 * needs to be send on the control port of course.
 		 *
 		 */
-		g_at_chat_send(chat, "AT+ZOPRT?", none_prefix,
-						NULL, NULL, NULL);
+		if (g_at_chat_send(chat, "AT+ZOPRT?", none_prefix,
+						at_gprs_activate_primary_cb, gc, NULL) > 0)
+			return;
+		goto error;
 	}
 =

-	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
-
-	if (ctx->apn)
-		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
-				ctx->apn);
-
-	if (g_at_chat_send(gcd->chat, buf, none_prefix,
-				at_cgdcont_cb, gc, NULL) > 0)
-		return;
+	at_activate_primary_with_check(gc);
+	return;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.9.5


--===============0694494317070824710==--


Content-Type: multipart/mixed; boundary="===============6489166405343298671=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 5/7] ubloxmodem: support authentication
Date: Thu, 17 Mar 2016 13:38:31 +0100
Message-ID: <1458218313-26966-6-git-send-email-dragos@endocode.com>
In-Reply-To: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6489166405343298671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If username and password specified, issue an UAUTHREQ
command with the configured authentication method, selected cid
and credentials.
---
 drivers/ubloxmodem/gprs-context.c | 78 +++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index ccf6289..778ff85 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -48,6 +48,9 @@ struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
 	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_gprs_auth_method auth_method;
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;
 };
@@ -250,11 +253,67 @@ static void ublox_send_cgdcont(struct ofono_gprs_cont=
ext *gc)
 	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

+static void uauthreq_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		gcd->active_context =3D 0;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		gcd->cb(&error, gcd->cb_data);
+
+		return;
+	}
+
+	ublox_send_cgdcont(gc);
+}
+
+#define UBLOX_MAX_USER_LEN 50
+#define UBLOX_MAX_PASS_LEN 50
+
+static void ublox_send_uauthreq(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[UBLOX_MAX_USER_LEN + UBLOX_MAX_PASS_LEN + 32];
+	unsigned auth_method;
+
+	switch (gcd->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		auth_method =3D 1;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		auth_method =3D 2;
+		break;
+	default:
+		ofono_error("Unsupported auth type %u", gcd->auth_method);
+		goto error;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+UAUTHREQ=3D%u,%u,\"%s\",\"%s\"",
+			gcd->active_context, auth_method,
+			gcd->username, gcd->password);
+
+	/* If this failed, we will see it during context activation. */
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				uauthreq_cb, gc, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
 static void ublox_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	size_t u_len, p_len;
 =

 	/* IPv6 support not implemented */
 	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP) {
@@ -273,9 +332,26 @@ static void ublox_gprs_activate_primary(struct ofono_g=
prs_context *gc,
 =

 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
+
+	gcd->auth_method =3D ctx->auth_method;
 	memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));
 =

-	ublox_send_cgdcont(gc);
+	u_len =3D strlen(ctx->username);
+	p_len =3D strlen(ctx->password);
+
+	if (u_len && p_len) {
+		if (u_len >=3D UBLOX_MAX_USER_LEN || p_len >=3D UBLOX_MAX_PASS_LEN) {
+			ofono_error("Toby L2: user or password length too big");
+			CALLBACK_WITH_FAILURE(cb, data);
+
+			return;
+		}
+
+		memcpy(gcd->username, ctx->username, sizeof(gcd->username));
+		memcpy(gcd->password, ctx->password, sizeof(gcd->password));
+		ublox_send_uauthreq(gc);
+	} else
+		ublox_send_cgdcont(gc);
 }
 =

 static void cgact_disable_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
-- =

2.5.0


--===============6489166405343298671==--


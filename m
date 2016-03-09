Content-Type: multipart/mixed; boundary="===============8898269109483145659=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 17/19] ubloxmodem: support authentication
Date: Wed, 09 Mar 2016 16:44:58 +0100
Message-ID: <1457538300-7183-18-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8898269109483145659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If username and password specified, issue an UAUTHREQ
command with the configured authentication method, selected cid
and credentials.
---
 drivers/ubloxmodem/gprs-context.c | 61 +++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index b6eaa5e..bc100d6 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -49,6 +49,9 @@ struct gprs_context_data {
 	unsigned int active_context;
 	unsigned int gprs_cid;
 	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_gprs_auth_method auth_method;
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;
 };
@@ -326,9 +329,58 @@ static void ublox_activate_ctx(struct ofono_gprs_conte=
xt *gc)
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
+		ofono_error("can't authenticate");
+		release_context_id(gcd->active_context);
+		callback_with_error(gcd, result);
+
+		return;
+	}
+
+	ublox_activate_ctx(gc);
+}
+
 #define UBLOX_MAX_USER_LEN 50
 #define UBLOX_MAX_PASS_LEN 50
 =

+static void ublox_authenticate(struct ofono_gprs_context *gc)
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
@@ -352,13 +404,18 @@ static void ublox_gprs_activate_primary(struct ofono_=
gprs_context *gc,
 =

 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
+	gcd->auth_method =3D ctx->auth_method;
 	gcd->gprs_cid =3D ctx->cid;
 	memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));
 =

-	if (gcd->active_context =3D=3D ublox_data.default_context_id)
+	if (gcd->active_context =3D=3D ublox_data.default_context_id) {
 		/* Default context already active, only read details. */
 		ublox_post_activation(gc);
-	else
+	} else if (strlen(ctx->username) && strlen(ctx->password)) {
+		memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+		memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+		ublox_authenticate(gc);
+	} else
 		ublox_activate_ctx(gc);
 }
 =

-- =

2.5.0


--===============8898269109483145659==--


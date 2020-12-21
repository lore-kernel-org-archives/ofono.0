Content-Type: multipart/mixed; boundary="===============0365911678668035737=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 5/5] gemalto: gprs: support authentication settings
Date: Mon, 21 Dec 2020 23:01:33 +0300
Message-ID: <20201221200133.522933-6-geomatsi@gmail.com>
In-Reply-To: <20201221200133.522933-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0365911678668035737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergey Matyukevich <matyukevich@arrival.com>

Add support for gprs contexts with username, password, as well as
specific authentication type.
---
 drivers/gemaltomodem/gprs-context.c | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/gpr=
s-context.c
index bb09f0b0..da68e959 100644
--- a/drivers/gemaltomodem/gprs-context.c
+++ b/drivers/gemaltomodem/gprs-context.c
@@ -46,6 +46,9 @@ static const char *none_prefix[] =3D { NULL };
 struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	int auth_type;
 	enum ofono_gprs_proto proto;
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;
@@ -79,7 +82,7 @@ static void swwan_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	}
 }
 =

-static void cgdcont_enable_cb(gboolean ok, GAtResult *result,
+static void sgauth_enable_cb(gboolean ok, GAtResult *result,
 			gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -109,6 +112,39 @@ static void cgdcont_enable_cb(gboolean ok, GAtResult *=
result,
 	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

+static void cgdcont_enable_cb(gboolean ok, GAtResult *result,
+			gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
+	char buf[384];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		gcd->active_context =3D 0;
+		decode_at_error(&error, g_at_result_final_response(result));
+		gcd->cb(&error, gcd->cb_data);
+		return;
+	}
+
+	if (gcd->username[0] && gcd->password[0])
+		sprintf(buf, "AT^SGAUTH=3D%u,%u,\"%s\",\"%s\"",
+			gcd->active_context, gcd->auth_type,
+			gcd->username, gcd->password);
+	else
+		sprintf(buf, "AT^SGAUTH=3D%u,%u,\"\",\"\"",
+			gcd->active_context, gcd->auth_type);
+
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				sgauth_enable_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
 static void gemalto_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *data)
@@ -123,6 +159,22 @@ static void gemalto_gprs_activate_primary(struct ofono=
_gprs_context *gc,
 	gcd->cb_data =3D data;
 	gcd->cb =3D cb;
 =

+	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+	gcd->proto =3D ctx->proto;
+
+	switch (ctx->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		gcd->auth_type =3D 1;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		gcd->auth_type =3D 2;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+	default:
+		gcd->auth_type =3D 0;
+		break;
+	}
 =

 	switch (ctx->proto) {
 	case OFONO_GPRS_PROTO_IP:
-- =

2.29.2

--===============0365911678668035737==--


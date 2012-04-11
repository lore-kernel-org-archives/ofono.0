Content-Type: multipart/mixed; boundary="===============4762091891934511997=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] atmodem: Fix wrong behavior with Huawei modems
Date: Wed, 11 Apr 2012 12:08:24 +0200
Message-ID: <1334138904-2005-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1334138904-2005-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4762091891934511997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |   80 ++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 16893ce..d47d66a 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -51,6 +51,7 @@ static const char *none_prefix[] =3D { NULL };
 =

 enum state {
 	STATE_IDLE,
+	STATE_RECOVERING,
 	STATE_ENABLING,
 	STATE_DISABLING,
 	STATE_ACTIVE,
@@ -61,11 +62,14 @@ struct gprs_context_data {
 	unsigned int active_context;
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
 	GAtPPP *ppp;
 	enum state state;
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;                                  /* Callback data */
 	unsigned int vendor;
+	guint no_carrier_watch;
+	guint timeout_source;
 };
 =

 static void ppp_debug(const char *str, void *data)
@@ -100,6 +104,21 @@ static void ppp_connect(const char *interface, const c=
har *local,
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

+static gboolean remove_no_carrier_cb(gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	gcd->timeout_source =3D 0;
+
+	g_at_chat_unregister(gcd->chat, gcd->no_carrier_watch);
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+
+	return FALSE;
+}
+
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -114,6 +133,18 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 	case STATE_ENABLING:
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 		break;
+	case STATE_RECOVERING:
+		gcd->state =3D STATE_ENABLING;
+		g_at_chat_resume(gcd->chat);
+
+		/*
+		 * Place the no carrier callback for limited time because we
+		 * don't want to have side effects on other ppp sessions.
+		 */
+		gcd->timeout_source =3D g_timeout_add_seconds(5,
+							remove_no_carrier_cb,
+							gc);
+		return;
 	case STATE_DISABLING:
 		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 		break;
@@ -219,6 +250,34 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

+static void ppp_resume(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	int len;
+
+	DBG("");
+
+	if (gcd->timeout_source > 0)
+		g_source_remove(gcd->timeout_source);
+
+	g_at_chat_unregister(gcd->chat, gcd->no_carrier_watch);
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
+						gcd->active_context);
+
+	if (gcd->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+				gcd->apn);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				at_cgdcont_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
 static void at_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *data)
@@ -239,6 +298,27 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
 	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
 =

+	if (ctx->apn)
+		memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));
+
+	/*
+	 * It might happen for Huawei modems that, when GPRS is no more
+	 * attached to the network, oFono core will reset context but the
+	 * modem has not ended ppp sesssion at driver level.
+	 * In this case trigger a disconnection manually and try to reconnect.
+	 */
+	if (gcd->ppp !=3D NULL && gcd->state =3D=3D STATE_ACTIVE &&
+			gcd->vendor =3D=3D OFONO_VENDOR_HUAWEI) {
+		gcd->no_carrier_watch =3D	g_at_chat_register(gcd->chat,
+							"NO CARRIER",
+							ppp_resume, FALSE,
+							gc, NULL);
+		gcd->state =3D STATE_RECOVERING;
+
+		g_at_ppp_shutdown(gcd->ppp);
+		return;
+	}
+
 	gcd->state =3D STATE_ENABLING;
 =

 	if (gcd->vendor =3D=3D OFONO_VENDOR_ZTE) {
-- =

1.7.4.1


--===============4762091891934511997==--


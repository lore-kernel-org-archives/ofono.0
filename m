Content-Type: multipart/mixed; boundary="===============3927510230573008973=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 4/5] ublox: gprs-context: query networking mode for TOBY L2
Date: Thu, 14 Mar 2019 23:28:42 +0100
Message-ID: <20190314222843.9232-4-jonas@norrbonn.se>
In-Reply-To: <20190314222843.9232-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3927510230573008973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TOBY L2 may run in either "bridge" mode or "router" mode.  For this
model, query the configured mode so that the appropriate settings are
communicated when the context is activated.
---

Only compile tested... I don't actually have a TOBY L2.

/Jonas

 drivers/ubloxmodem/gprs-context.c | 54 ++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 389868c1..35abae02 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -43,6 +43,12 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
 static const char *uipaddr_prefix[] =3D { "+UIPADDR:", NULL };
+static const char *ubmconf_prefix[] =3D { "+UBMCONF:", NULL };
+
+enum netmode {
+	NETWORKING_MODE_ROUTER,
+	NETWORKING_MODE_BRIDGE,
+};
 =

 struct gprs_context_data {
 	const struct ublox_model *model;
@@ -50,6 +56,7 @@ struct gprs_context_data {
 	unsigned int active_context;
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;
+	enum netmode networking_mode;
 };
 =

 static void uipaddr_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -240,7 +247,7 @@ static void ublox_gprs_read_settings(struct ofono_gprs_=
context *gc,
 =

 	DBG("cid %u", cid);
 =

-	if (ublox_is_toby_l4(gcd->model)) {
+	if (gcd->networking_mode =3D=3D NETWORKING_MODE_ROUTER) {
 		/* Use DHCP */
 		gcd->active_context =3D cid;
 		set_gprs_context_interface(gc);
@@ -471,6 +478,42 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 	gcd->active_context =3D 0;
 }
 =

+static void at_ubmconf_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	int mode;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "+UBMCONF:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &mode))
+		goto error;
+
+	switch (mode) {
+	case 1:
+		gcd->networking_mode =3D NETWORKING_MODE_ROUTER;
+		break;
+	case 2:
+		gcd->networking_mode =3D NETWORKING_MODE_BRIDGE;
+		break;
+	default:
+		goto error;
+	}
+
+	return;
+
+error:
+	ofono_error("AT+UBMCONF? failed; assuming router mode");
+	gcd->networking_mode =3D NETWORKING_MODE_ROUTER;
+}
+
 static int ublox_gprs_context_probe(struct ofono_gprs_context *gc,
 					unsigned int model_id, void *data)
 {
@@ -491,6 +534,15 @@ static int ublox_gprs_context_probe(struct ofono_gprs_=
context *gc,
 =

 	ofono_gprs_context_set_data(gc, gcd);
 =

+	if (ublox_is_toby_l2(gcd->model)) {
+		g_at_chat_send(chat, "AT+UBMCONF?", ubmconf_prefix,
+				at_ubmconf_read_cb, gc, NULL);
+	} else if (ublox_is_toby_l4(gcd->model)) {
+		gcd->networking_mode =3D NETWORKING_MODE_ROUTER;
+	} else {
+		gcd->networking_mode =3D NETWORKING_MODE_ROUTER;
+	}
+
 	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
 =

 	return 0;
-- =

2.19.1


--===============3927510230573008973==--


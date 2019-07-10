Content-Type: multipart/mixed; boundary="===============3234351899193650461=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 8/9] quectel: query device model to enable vendor quirks
Date: Wed, 10 Jul 2019 23:51:47 +0200
Message-ID: <20190710215148.78083-9-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3234351899193650461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index bfae31c0..8bf9a963 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -51,6 +51,7 @@
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static const uint8_t gsm0710_terminate[] =3D {
@@ -69,6 +70,7 @@ struct quectel_data {
 	GAtChat *aux;
 	guint cpin_ready;
 	bool have_sim;
+	enum ofono_vendor vendor;
 =

 	/* used by quectel uart driver */
 	GAtChat *uart;
@@ -306,6 +308,36 @@ static void cfun_query(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		cfun_enable(TRUE, NULL, modem);
 }
 =

+static void cgmm_cb(int ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const char *model;
+
+	DBG("%p ok %d", modem, ok);
+
+	if (!at_util_parse_attr(result, "", &model)) {
+		ofono_error("Failed to query modem model");
+		close_serial(modem);
+		return;
+	}
+
+	if (strcmp(model, "UC15") =3D=3D 0) {
+		DBG("%p model UC15", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+	} else if (strcmp(model, "Quectel_M95") =3D=3D 0) {
+		DBG("%p model M95", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL_M95;
+	} else {
+		ofono_warn("%p unknown model: '%s'", modem, model);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+	}
+
+	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
+			NULL);
+}
+
 static int open_ttys(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -331,7 +363,7 @@ static int open_ttys(struct ofono_modem *modem)
 			NULL, NULL);
 	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix, NULL, NULL,
 			NULL);
-	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
+	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
 			NULL);
 =

 	return -EINPROGRESS;
@@ -582,8 +614,7 @@ static void quectel_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
-				data->aux);
+	sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
 =

 	if (sim && data->have_sim =3D=3D true)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

2.22.0


--===============3234351899193650461==--


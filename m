Content-Type: multipart/mixed; boundary="===============8384914206504716687=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 4/7] quectel: store model id in private data
Date: Tue, 16 Jul 2019 21:10:50 +0200
Message-ID: <20190716191053.71990-4-martin@geanix.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8384914206504716687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some Quectel models supports different features such has GNSS or
different URC strings. Add a field in the quectel data structure to be
used when adding support for said features.
---
 plugins/quectel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 61b82744..e84e3cf1 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -70,6 +70,13 @@ static const uint8_t gsm0710_terminate[] =3D {
 	0xf9, /* close flag */
 };
 =

+enum quectel_model {
+	QUECTEL_UNKNOWN,
+	QUECTEL_UC15,
+	QUECTEL_M95,
+	QUECTEL_MC60,
+};
+
 struct quectel_data {
 	GAtChat *modem;
 	GAtChat *aux;
@@ -77,6 +84,7 @@ struct quectel_data {
 	guint call_ready;
 	bool have_sim;
 	enum ofono_vendor vendor;
+	enum quectel_model model;
 	struct l_timeout *sms_ready_timer;
 =

 	/* used by quectel uart driver */
@@ -329,12 +337,15 @@ static void cgmm_cb(int ok, GAtResult *result, void *=
user_data)
 	if (strcmp(model, "UC15") =3D=3D 0) {
 		DBG("%p model UC15", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_UC15;
 	} else if (strcmp(model, "Quectel_M95") =3D=3D 0) {
 		DBG("%p model M95", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
+		data->model =3D QUECTEL_M95;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_UNKNOWN;
 	}
 =

 	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
-- =

2.22.0


--===============8384914206504716687==--


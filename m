Content-Type: multipart/mixed; boundary="===============0505441499632516277=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 04/10] quectel: use plain c-types over glib/ofono typedefs
Date: Wed, 03 Jul 2019 20:09:49 +0200
Message-ID: <20190703180955.18246-5-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0505441499632516277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index f99b1ff8..50657265 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <stdbool.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -50,8 +51,8 @@ static const char *none_prefix[] =3D { NULL };
 struct quectel_data {
 	GAtChat *modem;
 	GAtChat *aux;
-	guint cpin_ready;
-	gboolean have_sim;
+	size_t cpin_ready;
+	bool have_sim;
 };
 =

 static void quectel_debug(const char *str, void *user_data)
@@ -97,7 +98,7 @@ static GAtChat *open_device(struct ofono_modem *modem, co=
nst char *key,
 	return at_util_open_device(modem, key, quectel_debug, debug, NULL);
 }
 =

-static void cpin_notify(GAtResult *result, gpointer user_data)
+static void cpin_notify(GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -114,9 +115,9 @@ static void cpin_notify(GAtResult *result, gpointer use=
r_data)
 	g_at_result_iter_next_unquoted_string(&iter, &sim_inserted);
 =

 	if (g_strcmp0(sim_inserted, "NOT INSERTED") !=3D 0)
-		data->have_sim =3D TRUE;
+		data->have_sim =3D true;
 =

-	ofono_modem_set_powered(modem, TRUE);
+	ofono_modem_set_powered(modem, true);
 =

 	/* Turn off the radio. */
 	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);
@@ -125,7 +126,7 @@ static void cpin_notify(GAtResult *result, gpointer use=
r_data)
 	data->cpin_ready =3D 0;
 }
 =

-static void cpin_query(gboolean ok, GAtResult *result, gpointer user_data)
+static void cpin_query(int ok, GAtResult *result, void *user_data)
 {
 	DBG("ok %d", ok);
 =

@@ -133,7 +134,7 @@ static void cpin_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 		cpin_notify(result, user_data);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void cfun_enable(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -145,17 +146,17 @@ static void cfun_enable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		data->aux =3D NULL;
 		g_at_chat_unref(data->modem);
 		data->modem =3D NULL;
-		ofono_modem_set_powered(modem, FALSE);
+		ofono_modem_set_powered(modem, false);
 		return;
 	}
 =

 	data->cpin_ready =3D g_at_chat_register(data->aux, "+CPIN", cpin_notify,
-						FALSE, modem, NULL);
+						false, modem, NULL);
 	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
 			NULL);
 }
 =

-static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
+static void cfun_query(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -169,7 +170,7 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE)
+	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D false)
 		return;
 =

 	g_at_result_iter_next_number(&iter, &status);
@@ -190,7 +191,7 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	cfun_enable(TRUE, NULL, modem);
+	cfun_enable(true, NULL, modem);
 }
 =

 static int quectel_enable(struct ofono_modem *modem)
@@ -222,7 +223,7 @@ static int quectel_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

-static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void cfun_disable(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -233,7 +234,7 @@ static void cfun_disable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	data->aux =3D NULL;
 =

 	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
+		ofono_modem_set_powered(modem, false);
 }
 =

 static int quectel_disable(struct ofono_modem *modem)
@@ -257,7 +258,7 @@ static int quectel_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

-static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+static void set_online_cb(int ok, GAtResult *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_modem_online_cb_t cb =3D cbd->cb;
@@ -267,7 +268,7 @@ static void set_online_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

-static void quectel_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+static void quectel_set_online(struct ofono_modem *modem, int online,
 				ofono_modem_online_cb_t cb, void *user_data)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -296,8 +297,8 @@ static void quectel_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
 				data->aux);
 =

-	if (sim && data->have_sim =3D=3D TRUE)
-		ofono_sim_inserted_notify(sim, TRUE);
+	if (sim && data->have_sim =3D=3D true)
+		ofono_sim_inserted_notify(sim, true);
 }
 =

 static void quectel_post_sim(struct ofono_modem *modem)
-- =

2.22.0


--===============0505441499632516277==--


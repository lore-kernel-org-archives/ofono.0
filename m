Content-Type: multipart/mixed; boundary="===============7225216071941063040=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 03/10] quectel: improve coding style
Date: Wed, 03 Jul 2019 20:09:48 +0200
Message-ID: <20190703180955.18246-4-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7225216071941063040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 6ab97027..f99b1ff8 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -91,8 +91,8 @@ static void quectel_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static GAtChat *open_device(struct ofono_modem *modem,
-				const char *key, char *debug)
+static GAtChat *open_device(struct ofono_modem *modem, const char *key,
+				char *debug)
 {
 	return at_util_open_device(modem, key, quectel_debug, debug, NULL);
 }
@@ -151,8 +151,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 =

 	data->cpin_ready =3D g_at_chat_register(data->aux, "+CPIN", cpin_notify,
 						FALSE, modem, NULL);
-	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query,
-						modem, NULL);
+	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
+			NULL);
 }
 =

 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
@@ -185,8 +185,8 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 	 */
 =

 	if (status !=3D 1) {
-		g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
-					cfun_enable, modem, NULL);
+		g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, cfun_enable,
+				modem, NULL);
 		return;
 	}
 =

@@ -212,13 +212,12 @@ static int quectel_enable(struct ofono_modem *modem)
 =

 	g_at_chat_set_slave(data->modem, data->aux);
 =

-	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", none_prefix,
-					NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", none_prefix,
-					NULL, NULL, NULL);
-
-	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix,
-					cfun_query, modem, NULL);
+	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", none_prefix, NULL, NULL,
+			NULL);
+	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", none_prefix, NULL, NULL,
+			NULL);
+	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
+			NULL);
 =

 	return -EINPROGRESS;
 }
@@ -277,8 +276,8 @@ static void quectel_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (g_at_chat_send(data->aux, command, cfun_prefix, set_online_cb,
-					cbd, g_free) > 0)
+	if (g_at_chat_send(data->aux, command, cfun_prefix, set_online_cb, cbd,
+				g_free) > 0)
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
@@ -295,7 +294,7 @@ static void quectel_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
-					data->aux);
+				data->aux);
 =

 	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

2.22.0


--===============7225216071941063040==--


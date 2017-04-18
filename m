Content-Type: multipart/mixed; boundary="===============2186502240749476723=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH v4] gemalto: Use sim_state_query for sim detection
Date: Tue, 18 Apr 2017 17:40:05 +0200
Message-ID: <1492530005-31475-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <3c560e32-616d-8432-29e7-bdaf953d9a5d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2186502240749476723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Populate gemalto_data structure.
Add sim_state callbacks.
Fix enable/disable return value.
---
Change in v4:
 - Remove style fixes (don't mix with code addition)

 plugins/gemalto.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index ab0da8f..abc20ca 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -46,10 +46,14 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+static const char *none_prefix[] =3D { NULL };
 =

 struct gemalto_data {
 	GAtChat *app;
 	GAtChat *mdm;
+	struct ofono_sim *sim;
+	gboolean have_sim;
+	struct at_util_sim_state_query *sim_state_query;
 };
 =

 static int gemalto_probe(struct ofono_modem *modem)
@@ -69,6 +73,8 @@ static void gemalto_remove(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 =

+	/* Cleanup potential SIM state polling */
+	at_util_sim_state_query_free(data->sim_state_query);
 	ofono_modem_set_data(modem, NULL);
 	g_free(data);
 }
@@ -103,6 +109,39 @@ static GAtChat *open_device(const char *device)
 	return chat;
 }
 =

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
+	data->have_sim =3D present;
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		g_at_chat_unref(data->app);
+		data->app =3D NULL;
+
+		g_at_chat_unref(data->mdm);
+		data->mdm =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	data->sim_state_query =3D at_util_sim_state_query_new(data->app,
+						2, 20, sim_state_cb, modem,
+						NULL);
+}
+
 static int gemalto_enable(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
@@ -133,7 +172,32 @@ static int gemalto_enable(struct ofono_modem *modem)
 		g_at_chat_set_debug(data->mdm, gemalto_debug, "Mdm");
 	}
 =

-	return 0;
+	g_at_chat_send(data->mdm, "ATE0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(data->app, "ATE0 +CMEE=3D1", none_prefix,
+			NULL, NULL, NULL);
+	g_at_chat_send(data->mdm, "AT&C0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(data->app, "AT&C0", none_prefix, NULL, NULL, NULL);
+
+	g_at_chat_send(data->app, "AT+CFUN=3D4", none_prefix,
+			cfun_enable, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void gemalto_smso_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->mdm);
+	data->mdm =3D NULL;
+	g_at_chat_unref(data->app);
+	data->app =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
 }
 =

 static int gemalto_disable(struct ofono_modem *modem)
@@ -142,11 +206,14 @@ static int gemalto_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_send(data->app, "AT^SMSO", NULL, NULL, NULL, NULL);
+	g_at_chat_cancel_all(data->app);
+	g_at_chat_unregister_all(data->app);
 =

-	ofono_modem_set_data(modem, NULL);
+	/* Shutdown the modem */
+	g_at_chat_send(data->app, "AT^SMSO", none_prefix, gemalto_smso_cb,
+			modem, NULL);
 =

-	return 0;
+	return -EINPROGRESS;
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -185,10 +252,10 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
 =

-	if (sim)
+	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.9.1


--===============2186502240749476723==--


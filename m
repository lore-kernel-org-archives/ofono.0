Content-Type: multipart/mixed; boundary="===============6050356805507377995=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 12/20] sap: enable modem only when #RSEN is 1
Date: Mon, 05 Sep 2011 15:03:41 -0300
Message-ID: <1315245829-6887-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-12-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6050356805507377995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Only put modem powered when Remote SAP Server is enabled
---
 plugins/bluetooth.h |    2 +-
 plugins/sap.c       |    4 +---
 plugins/telit.c     |   18 +++++++++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index d2ccb21..26767b7 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -45,7 +45,7 @@ struct bluetooth_profile {
 =

 struct bluetooth_sap_driver {
 	const char *name;
-	int (*enable) (struct ofono_modem *modem);
+	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
 	int (*disable) (struct ofono_modem *modem);
 	int (*open) (struct ofono_modem *modem);
 };
diff --git a/plugins/sap.c b/plugins/sap.c
index 308d28f..d92dc6a 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -262,9 +262,7 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	data->hw_watch =3D g_io_add_watch(data->hw_io, G_IO_HUP | G_IO_ERR
 				| G_IO_NVAL | G_IO_IN, hw_event_cb, modem);
 =

-	sap_driver->enable(data->hw_modem);
-
-	ofono_modem_set_powered(modem, TRUE);
+	sap_driver->enable(data->hw_modem, modem);
 =

 done:
 	dbus_message_unref(reply);
diff --git a/plugins/telit.c b/plugins/telit.c
index b6d408f..a89fce1 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -68,6 +68,7 @@ struct telit_data {
 	GAtChat *aux;
 	struct ofono_sim *sim;
 	guint sim_inserted_source;
+	struct ofono_modem *sap_modem;
 };
 =

 static void telit_debug(const char *str, void *user_data)
@@ -112,6 +113,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
 static void telit_rsen_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
 	int status;
 	GAtResultIter iter;
 =

@@ -123,6 +125,13 @@ static void telit_rsen_notify(GAtResult *result, gpoin=
ter user_data)
 		return;
 =

 	g_at_result_iter_next_number(&iter, &status);
+
+	if (status =3D=3D 0) {
+		ofono_modem_set_powered(data->sap_modem, FALSE);
+		return;
+	}
+
+	ofono_modem_set_powered(data->sap_modem, TRUE);
 }
 =

 static void rsen_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -135,7 +144,7 @@ static void rsen_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	if (!ok) {
 		g_at_chat_unref(data->aux);
 		data->aux =3D NULL;
-		ofono_modem_set_powered(modem, FALSE);
+		ofono_modem_set_powered(data->sap_modem, FALSE);
 		return;
 	}
 }
@@ -151,7 +160,7 @@ static void rsen_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	data->aux =3D NULL;
 =

 	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
+		ofono_modem_set_powered(data->sap_modem, FALSE);
 }
 =

 static int telit_sap_open(struct ofono_modem *modem)
@@ -179,7 +188,8 @@ static int telit_sap_open(struct ofono_modem *modem)
 	return fd;
 }
 =

-static int telit_sap_enable(struct ofono_modem *modem)
+static int telit_sap_enable(struct ofono_modem *modem,
+					struct ofono_modem *sap_modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 =

@@ -189,6 +199,8 @@ static int telit_sap_enable(struct ofono_modem *modem)
 	if (data->aux =3D=3D NULL)
 		return -EINVAL;
 =

+	data->sap_modem =3D sap_modem;
+
 	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

-- =

1.7.6.1


--===============6050356805507377995==--


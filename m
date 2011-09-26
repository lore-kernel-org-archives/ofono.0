Content-Type: multipart/mixed; boundary="===============2094064124691008520=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 19/23] sap: disconnect link if enable() fails
Date: Mon, 26 Sep 2011 14:27:12 -0300
Message-ID: <1317058036-32641-19-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-18-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2094064124691008520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We should disconnect the bluetooh link if sap_modem enabling fails.
---
 plugins/bluetooth.h |    5 ++++-
 plugins/sap.c       |    7 ++++++-
 plugins/telit.c     |    9 ++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 6564609..81eed9d 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -43,9 +43,12 @@ struct bluetooth_profile {
 	void (*set_alias)(const char *device, const char *);
 };
 =

+typedef void (*ConnectFailed)(struct ofono_modem *modem);
+
 struct bluetooth_sap_driver {
 	const char *name;
-	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
+	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
+							ConnectFailed cb);
 	void (*pre_sim) (struct ofono_modem *modem);
 	void (*post_sim) (struct ofono_modem *modem);
 	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
diff --git a/plugins/sap.c b/plugins/sap.c
index e19361c..5b52d89 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -180,6 +180,11 @@ static void sap_remove(struct ofono_modem *modem)
 	DBG("%p", modem);
 }
 =

+static void sap_failed_cb(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -258,7 +263,7 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	data->hw_watch =3D g_io_add_watch(data->hw_io, G_IO_HUP | G_IO_ERR
 				| G_IO_NVAL | G_IO_IN, hw_event_cb, modem);
 =

-	data->sap_driver->enable(data->hw_modem, modem);
+	data->sap_driver->enable(data->hw_modem, modem, sap_failed_cb);
 =

 done:
 	dbus_message_unref(reply);
diff --git a/plugins/telit.c b/plugins/telit.c
index 47a82d9..0c8061f 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -69,6 +69,7 @@ struct telit_data {
 	struct ofono_sim *sim;
 	guint sim_inserted_source;
 	struct ofono_modem *sap_modem;
+	ConnectFailed cb;
 };
 =

 static void telit_debug(const char *str, void *user_data)
@@ -200,6 +201,7 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		g_at_chat_unref(data->chat);
 		data->chat =3D NULL;
 		ofono_modem_set_powered(m, FALSE);
+		data->cb(data->sap_modem);
 		return;
 	}
 =

@@ -259,6 +261,7 @@ static void telit_rsen_notify(GAtResult *result, gpoint=
er user_data)
 =

 	if (status =3D=3D 0) {
 		ofono_modem_set_powered(data->sap_modem, FALSE);
+		data->cb(data->sap_modem);
 		return;
 	}
 =

@@ -276,6 +279,7 @@ static void rsen_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		g_at_chat_unref(data->aux);
 		data->aux =3D NULL;
 		ofono_modem_set_powered(data->sap_modem, FALSE);
+		data->cb(data->sap_modem);
 		return;
 	}
 }
@@ -356,7 +360,8 @@ static int telit_sap_open(struct ofono_modem *modem)
 }
 =

 static int telit_sap_enable(struct ofono_modem *modem,
-					struct ofono_modem *sap_modem)
+					struct ofono_modem *sap_modem,
+					ConnectFailed cb)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 =

@@ -368,6 +373,8 @@ static int telit_sap_enable(struct ofono_modem *modem,
 =

 	data->sap_modem =3D sap_modem;
 =

+	data->cb =3D cb;
+
 	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

-- =

1.7.6.2


--===============2094064124691008520==--


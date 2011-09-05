Content-Type: multipart/mixed; boundary="===============3594447706363740433=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 19/20] sap: disconnect link if enable() fails
Date: Mon, 05 Sep 2011 15:03:48 -0300
Message-ID: <1315245829-6887-20-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-19-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3594447706363740433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

We should disconnect the bluetooh link if sap_modem enabling fails.
---
 plugins/bluetooth.h |    5 +++-
 plugins/sap.c       |   58 +++++++++++++++++++++++++++++++----------------=
---
 plugins/telit.c     |    9 +++++++-
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 78b93e2..089c32f 100644
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
index c5f0d46..3a764ef 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -181,6 +181,41 @@ static void sap_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

+static void sap_power_down(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Disconnect reply: %s", derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void sap_failed_cb(struct ofono_modem *modem)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+	char str[] =3D "sap";
+	char *s =3D str;
+
+	DBG("%p", modem);
+
+	bluetooth_send_with_reply(data->server_path, BLUEZ_SERIAL_INTERFACE,
+				"Disconnect", sap_power_down, modem, NULL,
+				DBUS_TIMEOUT, DBUS_TYPE_STRING, &s,
+				DBUS_TYPE_INVALID);
+}
+
 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -262,7 +297,7 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	data->hw_watch =3D g_io_add_watch(data->hw_io, G_IO_HUP | G_IO_ERR
 				| G_IO_NVAL | G_IO_IN, hw_event_cb, modem);
 =

-	sap_driver->enable(data->hw_modem, modem);
+	sap_driver->enable(data->hw_modem, modem, sap_failed_cb);
 =

 done:
 	dbus_message_unref(reply);
@@ -290,27 +325,6 @@ static int sap_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

-static void sap_power_down(DBusPendingCall *call, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	DBusMessage *reply;
-	DBusError derr;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		DBG("Disconnect reply: %s", derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	ofono_modem_set_powered(modem, FALSE);
-
-done:
-	dbus_message_unref(reply);
-}
-
 static int sap_disable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
diff --git a/plugins/telit.c b/plugins/telit.c
index 55a2225..2970357 100644
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

1.7.6.1


--===============3594447706363740433==--


Content-Type: multipart/mixed; boundary="===============8577351525947928140=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 19/21] sap: remove server_path
Date: Tue, 27 Sep 2011 18:04:18 -0300
Message-ID: <1317157460-17012-19-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-18-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8577351525947928140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

We use ofono_modem_set_string() instead to store it.
This also remove the need to have sap_data allocation on
bluetooth_sap_probe().
---
 plugins/sap.c |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 9b8e670..ce5886d 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -53,7 +53,6 @@ static struct ofono_modem *sap_hw_modem =3D NULL;
 static struct bluetooth_sap_driver *sap_hw_driver =3D NULL;
 =

 struct sap_data {
-	char *server_path;
 	struct ofono_modem *hw_modem;
 	struct bluetooth_sap_driver *sap_driver;
 	GIOChannel *bt_io;
@@ -110,7 +109,6 @@ static void sap_remove_modem(struct ofono_modem *modem)
 	if (data->call !=3D NULL)
 		dbus_pending_call_cancel(data->call);
 =

-	g_free(data->server_path);
 	g_free(data);
 =

 	ofono_modem_set_data(modem, NULL);
@@ -213,8 +211,16 @@ static gboolean hw_event_cb(GIOChannel *hw_io, GIOCond=
ition condition,
 =

 static int sap_probe(struct ofono_modem *modem)
 {
+	struct sap_data *data;
+
 	DBG("%p", modem);
 =

+	data =3D g_try_new0(struct sap_data, 1);
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, data);
+
 	return 0;
 }
 =

@@ -309,14 +315,15 @@ static int sap_enable(struct ofono_modem *modem)
 	DBusPendingCall *call;
 	int status;
 	const char *str =3D "sap";
+	const char *server_path =3D ofono_modem_get_string(modem, "ServerPath");
 =

 	DBG("%p", modem);
 =

-	status =3D bluetooth_send_with_reply(data->server_path,
-					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
-					&call, sap_connect_reply, modem, NULL,
-					DBUS_TIMEOUT, DBUS_TYPE_STRING,
-					&str, DBUS_TYPE_INVALID);
+	status =3D bluetooth_send_with_reply(server_path, BLUEZ_SERIAL_INTERFACE,
+					"ConnectFD", &call, sap_connect_reply,
+					modem, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &str,
+					DBUS_TYPE_INVALID);
 =

 	if (status < 0)
 		return -EINVAL;
@@ -380,7 +387,6 @@ static int bluetooth_sap_probe(const char *device, cons=
t char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
 	struct ofono_modem *modem;
-	struct sap_data *data;
 	char buf[256];
 =

 	if (sap_hw_modem =3D=3D NULL)
@@ -401,27 +407,13 @@ static int bluetooth_sap_probe(const char *device, co=
nst char *dev_addr,
 	if (modem =3D=3D NULL)
 		return -ENOMEM;
 =

-	data =3D g_try_new0(struct sap_data, 1);
-	if (data =3D=3D NULL)
-		goto free;
-
-	data->server_path =3D g_strdup(device);
-	if (data->server_path =3D=3D NULL)
-		goto free;
-
-	ofono_modem_set_data(modem, data);
+	ofono_modem_set_string(modem, "ServerPath", device);
 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
 =

 	g_hash_table_insert(modem_hash, g_strdup(device), modem);
 =

 	return 0;
-
-free:
-	g_free(data);
-	ofono_modem_remove(modem);
-
-	return -ENOMEM;
 }
 =

 static void bluetooth_sap_remove(const char *prefix)
-- =

1.7.6.2


--===============8577351525947928140==--


Content-Type: multipart/mixed; boundary="===============8432216629211741517=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 1/5] sap: remove connect callback if enable fails
Date: Wed, 28 Sep 2011 17:48:56 -0300
Message-ID: <1317242940-4014-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8432216629211741517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

---
 plugins/sap.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 1c0d9ce..28b07e7 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -54,6 +54,7 @@ static struct bluetooth_sap_driver *sap_hw_driver =3D NUL=
L;
 struct sap_data {
 	struct ofono_modem *hw_modem;
 	struct bluetooth_sap_driver *sap_driver;
+	DBusPendingCall *call;
 };
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
@@ -112,6 +113,9 @@ static void sap_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
 	g_free(data);
 =

 	ofono_modem_set_data(modem, NULL);
@@ -120,6 +124,7 @@ static void sap_remove(struct ofono_modem *modem)
 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct sap_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
 	DBusMessage *reply;
 =

@@ -127,6 +132,8 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

+	data->call =3D NULL;
+
 	if (ofono_modem_get_powered(modem))
 		goto done;
 =

@@ -147,6 +154,8 @@ done:
 /* power up hardware */
 static int sap_enable(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+	DBusPendingCall *call;
 	int status;
 	const char *str =3D "sap";
 	const char *server_path =3D ofono_modem_get_string(modem, "ServerPath");
@@ -154,7 +163,7 @@ static int sap_enable(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	status =3D bluetooth_send_with_reply(server_path, BLUEZ_SERIAL_INTERFACE,
-					"ConnectFD", NULL, sap_connect_reply,
+					"ConnectFD", &call, sap_connect_reply,
 					modem, NULL, DBUS_TIMEOUT,
 					DBUS_TYPE_STRING, &str,
 					DBUS_TYPE_INVALID);
@@ -162,6 +171,8 @@ static int sap_enable(struct ofono_modem *modem)
 	if (status < 0)
 		return -EINVAL;
 =

+	data->call =3D call;
+
 	return -EINPROGRESS;
 }
 =

-- =

1.7.6.2


--===============8432216629211741517==--


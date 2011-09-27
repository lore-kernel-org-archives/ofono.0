Content-Type: multipart/mixed; boundary="===============5769086340043658832=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 18/21] sap: de-register DBus callback if BlueZ goes down
Date: Tue, 27 Sep 2011 18:04:17 -0300
Message-ID: <1317157460-17012-18-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-17-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5769086340043658832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index fbca3d8..9b8e670 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -60,6 +60,7 @@ struct sap_data {
 	GIOChannel *hw_io;
 	guint bt_watch;
 	guint hw_watch;
+	DBusPendingCall *call;
 };
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
@@ -106,6 +107,9 @@ static void sap_remove_modem(struct ofono_modem *modem)
 =

 	sap_close_io(modem);
 =

+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
 	g_free(data->server_path);
 	g_free(data);
 =

@@ -238,6 +242,8 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

+	data->call =3D NULL;
+
 	if (ofono_modem_get_powered(modem))
 		goto done;
 =

@@ -300,6 +306,7 @@ done:
 static int sap_enable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
+	DBusPendingCall *call;
 	int status;
 	const char *str =3D "sap";
 =

@@ -307,13 +314,15 @@ static int sap_enable(struct ofono_modem *modem)
 =

 	status =3D bluetooth_send_with_reply(data->server_path,
 					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
-					NULL, sap_connect_reply, modem, NULL,
+					&call, sap_connect_reply, modem, NULL,
 					DBUS_TIMEOUT, DBUS_TYPE_STRING,
 					&str, DBUS_TYPE_INVALID);
 =

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


--===============5769086340043658832==--


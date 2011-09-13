Content-Type: multipart/mixed; boundary="===============3531568288601037612=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 24/24] sap: de-register DBus callback if BlueZ goes down
Date: Tue, 13 Sep 2011 15:58:32 -0300
Message-ID: <1315940312-1238-24-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-23-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3531568288601037612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 81e4e32..cbec028 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -59,6 +59,7 @@ struct sap_data {
 	GIOChannel *hw_io;
 	guint bt_watch;
 	guint hw_watch;
+	DBusPendingCall *call;
 };
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
@@ -177,6 +178,9 @@ static void sap_remove(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
 =

+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
 	g_hash_table_remove(modem_hash, data->server_path);
 =

 	g_free(data->server_path);
@@ -232,6 +236,8 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

+	data->call =3D NULL;
+
 	if (ofono_modem_get_powered(modem))
 		goto done;
 =

@@ -305,6 +311,7 @@ done:
 static int sap_enable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
+	DBusPendingCall *call;
 	int status;
 	const char *str =3D "sap";
 =

@@ -312,13 +319,15 @@ static int sap_enable(struct ofono_modem *modem)
 =

 	status =3D bluetooth_send_with_reply(data->server_path,
 					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
-					sap_connect_reply, modem, NULL,
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


--===============3531568288601037612==--


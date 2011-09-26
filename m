Content-Type: multipart/mixed; boundary="===============2453605593051187185=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 23/23] sap: de-register DBus callback if BlueZ goes down
Date: Mon, 26 Sep 2011 14:27:16 -0300
Message-ID: <1317058036-32641-23-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-22-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2453605593051187185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index d69ba6d..b6643d8 100644
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
@@ -110,6 +111,9 @@ static void sap_remove_modem(struct ofono_modem *modem)
 =

 	sap_close_io(modem);
 =

+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
 	g_free(data->server_path);
 	g_free(data);
 =

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

@@ -308,6 +314,7 @@ done:
 static int sap_enable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
+	DBusPendingCall *call;
 	int status;
 	const char *str =3D "sap";
 =

@@ -315,13 +322,15 @@ static int sap_enable(struct ofono_modem *modem)
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


--===============2453605593051187185==--


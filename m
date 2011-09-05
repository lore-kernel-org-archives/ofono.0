Content-Type: multipart/mixed; boundary="===============1519864590326897579=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 04/20] sap: add support to connect the RFCOMM link
Date: Mon, 05 Sep 2011 15:03:33 -0300
Message-ID: <1315245829-6887-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1519864590326897579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 2d4ef5f..b88e08b 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -38,11 +38,14 @@
 #include <ofono/modem.h>
 =

 #include "bluetooth.h"
+#include "util.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
 #endif
 =

+#define BLUEZ_SERIAL_INTERFACE	BLUEZ_SERVICE ".Serial"
+
 static DBusConnection *connection;
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *sap_hw_hash =3D NULL;
@@ -113,24 +116,95 @@ static void sap_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

+static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	DBusError derr;
+	DBusMessage *reply;
+
+	DBG("");
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (ofono_modem_get_powered(modem))
+		goto done;
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply))
+		goto done;
+
+	DBG("Connect reply: %s", derr.message);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	dbus_error_free(&derr);
+
+done:
+	dbus_message_unref(reply);
+}
+
 /* power up hardware */
 static int sap_enable(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
-	struct bluetooth_sap_driver *sap_driver;
+	int status;
+	char str[] =3D "sap";
+	char *s =3D str;
+
+	DBG("%p", modem);
 =

-	sap_driver =3D g_hash_table_lookup(sap_hw_hash, data->hw_modem);
-	if (!sap_driver)
-		return -ENODEV;
+	status =3D bluetooth_send_with_reply(data->server_path,
+					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
+					sap_connect_reply, modem, NULL,
+					DBUS_TIMEOUT, DBUS_TYPE_STRING,
+					&s, DBUS_TYPE_INVALID);
 =

-	return sap_driver->enable(data->hw_modem);
+	if (status < 0)
+		return -EINVAL;
+
+	return -EINPROGRESS;
+}
+
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
 }
 =

 static int sap_disable(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+	int status;
+	char str[] =3D "sap";
+	char *s =3D str;
+
 	DBG("%p", modem);
 =

-	return 0;
+	status =3D bluetooth_send_with_reply(data->server_path,
+				BLUEZ_SERIAL_INTERFACE, "Disconnect",
+				sap_power_down, modem, NULL,
+				DBUS_TIMEOUT, DBUS_TYPE_STRING,
+				&s, DBUS_TYPE_INVALID);
+
+	if (status < 0)
+		return -EINVAL;
+
+	return -EINPROGRESS;
 }
 =

 static void sap_pre_sim(struct ofono_modem *modem)
-- =

1.7.6.1


--===============1519864590326897579==--


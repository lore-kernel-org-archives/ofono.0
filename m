Content-Type: multipart/mixed; boundary="===============8562834385241181717=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/5] Add dun_enable() function
Date: Wed, 04 Aug 2010 07:22:12 -0300
Message-ID: <1280917334-4519-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1280917334-4519-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8562834385241181717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dun_enable() is called by setting the Powered property to true.
It creates a rfcomm link throught the BlueZ Serial API.
---
 drivers/dunmodem/dunmodem.h |    1 +
 plugins/bluetooth.h         |    1 +
 plugins/dun.c               |   62 +++++++++++++++++++++++++++++++++++++++=
++-
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index 291e2ce..6d545c9 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -21,4 +21,5 @@
 =

 struct dun_data {
 	char *dun_path;
+	char *rfcomm;
 };
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index d1302d4..2a4a549 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -22,6 +22,7 @@
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#define	BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 =

 #define DBUS_TIMEOUT 15
 =

diff --git a/plugins/dun.c b/plugins/dun.c
index 1e9f972..60d0271 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
+#include <gdbus.h>
 #include <glib.h>
 #include <ofono.h>
 =

@@ -139,10 +140,67 @@ static void dun_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

+static void dun_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	const char *dev;
+	DBusError derr;
+	DBusMessage *reply, *msg;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (ofono_modem_get_powered(modem))
+		goto done;
+
+	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &dev,
+				DBUS_TYPE_INVALID))
+		goto done;
+
+	data->rfcomm =3D g_strdup(dev);
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		ofono_modem_set_powered(modem, TRUE);
+		goto done;
+	}
+
+	DBG("Connect reply: %s", derr.message);
+
+	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
+		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
+				data->dun_path,
+				BLUEZ_SERIAL_INTERFACE, "Disconnect");
+		if (!msg)
+			ofono_error("Disconnect failed");
+		else
+			g_dbus_send_message(connection, msg);
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	dbus_error_free(&derr);
+
+done:
+	dbus_message_unref(reply);
+}
+
 static int dun_enable(struct ofono_modem *modem)
 {
-	DBG("%p", modem);
-	return 0;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	int status;
+	const char *uuid =3D DUN_GW_UUID;
+
+	status =3D bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					dun_connect_reply, modem, NULL,
+					DBUS_TIMEOUT, DBUS_TYPE_STRING, &uuid,
+					DBUS_TYPE_INVALID);
+
+	if (status < 0)
+		return -EINVAL;
+
+	return -EINPROGRESS;
 }
 =

 static int dun_disable(struct ofono_modem *modem)
-- =

1.7.1.1


--===============8562834385241181717==--


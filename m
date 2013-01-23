Content-Type: multipart/mixed; boundary="===============7503864635383957970=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 05/10] hfp_hf_bluez5: Handle NewConnection from BlueZ
Date: Wed, 23 Jan 2013 15:27:56 -0300
Message-ID: <1358965681-7420-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7503864635383957970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parse the essential arguments in the message, in this case only the
file descriptor, and register the modem if it is not already
registered. This is necessary because in some cases, we may receive a
NewConnection call, and the SDP process is still taking place.
---
 plugins/hfp_hf_bluez5.c | 51 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 91bafaf..d4f158e 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -24,6 +24,8 @@
 #endif
 =

 #include <errno.h>
+#include <unistd.h>
+
 #include <glib.h>
 =

 #include <gdbus.h>
@@ -124,11 +126,54 @@ static struct ofono_modem_driver hfp_driver =3D {
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct ofono_modem *modem;
+	DBusMessageIter iter;
+	GDBusProxy *proxy;
+	DBusMessageIter entry;
+	const char *device, *alias;
+	int fd;
+
 	DBG("Profile handler NewConnection");
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".NotImplemented",
-					"Implementation not provided");
+	if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
+		goto invalid;
+
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&entry, &device);
+
+	proxy =3D g_hash_table_lookup(devices_proxies, device);
+	if (proxy =3D=3D NULL)
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".Rejected",
+					"Unknown Bluetooth device");
+
+	g_dbus_proxy_get_property(proxy, "Alias", &iter);
+
+	dbus_message_iter_get_basic(&iter, &alias);
+
+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&entry, &fd);
+	if (fd < 0)
+		goto invalid;
+
+	modem =3D modem_register(device, alias);
+	if (modem =3D=3D NULL) {
+		close(fd);
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".Rejected",
+					"Could not register HFP modem");
+	}
+
+	return NULL;
+
+invalid:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static DBusMessage *profile_release(DBusConnection *conn,
-- =

1.8.1.1


--===============7503864635383957970==--


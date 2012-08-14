Content-Type: multipart/mixed; boundary="===============0006638831989669150=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 1/2] dundee: add timeout to close stalled ppp handshake
Date: Tue, 14 Aug 2012 04:14:31 -0300
Message-ID: <1344928472-29531-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0006638831989669150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If something goes wrong the PPP handshake can stall, then we just add a
timer to return an error after a certain timeout (15 seconds).
---
 dundee/dbus.c   |  6 ++++++
 dundee/device.c | 28 ++++++++++++++++++++++++++++
 dundee/dundee.h |  1 +
 3 files changed, 35 insertions(+)

diff --git a/dundee/dbus.c b/dundee/dbus.c
index c245eab..90bd76b 100644
--- a/dundee/dbus.c
+++ b/dundee/dbus.c
@@ -43,3 +43,9 @@ DBusMessage *__dundee_error_failed(DBusMessage *msg)
 					".Failed",
 					"Operation failed");
 }
+
+DBusMessage *__dundee_error_timed_out(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, DUNDEE_ERROR_INTERFACE ".Timedout",
+			"Operation failure due to timeout");
+}
diff --git a/dundee/device.c b/dundee/device.c
index 5126071..e5f6424 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -35,6 +35,8 @@
 =

 #include "dundee.h"
 =

+#define PPP_TIMEOUT 15
+
 static int next_device_id =3D 0;
 static GHashTable *device_hash;
 =

@@ -59,6 +61,7 @@ struct dundee_device {
 	struct ipv4_settings settings;
 =

 	DBusMessage *pending;
+	guint connect_timeout;
 	void *data;
 };
 =

@@ -221,6 +224,11 @@ static void ppp_connect(const char *iface, const char =
*local, const char *peer,
 	DBG("Primary DNS Server: %s\n", dns1);
 	DBG("Secondary DNS Server: %s\n", dns2);
 =

+	if (device->connect_timeout > 0) {
+		g_source_remove(device->connect_timeout);
+		device->connect_timeout =3D 0;
+	}
+
 	g_free(device->settings.interface);
 	device->settings.interface =3D g_strdup(iface);
 	if (device->settings.interface =3D=3D NULL)
@@ -287,6 +295,23 @@ out:
 	device->pending =3D NULL;
 }
 =

+static gboolean ppp_connect_timeout(gpointer user_data)
+{
+	struct dundee_device *device =3D user_data;
+
+	if (device->pending !=3D NULL) {
+		__ofono_dbus_pending_reply(&device->pending,
+				__dundee_error_timed_out(device->pending));
+		device->pending =3D NULL;
+	}
+
+	device->driver->disconnect(device, disconnect_callback, device);
+
+	device->connect_timeout =3D 0;
+
+	return FALSE;
+}
+
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -344,6 +369,9 @@ static void dial_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	}
 	g_at_ppp_set_debug(device->ppp, debug, "PPP");
 =

+	device->connect_timeout =3D g_timeout_add_seconds(PPP_TIMEOUT,
+						ppp_connect_timeout, device);
+
 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(device->ppp, ppp_connect, device);
 	g_at_ppp_set_disconnect_function(device->ppp, ppp_disconnect, device);
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 8866007..db932b6 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -94,6 +94,7 @@ void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMe=
ssage *reply);
 =

 DBusMessage *__dundee_error_invalid_args(DBusMessage *msg);
 DBusMessage *__dundee_error_failed(DBusMessage *msg);
+DBusMessage *__dundee_error_timed_out(DBusMessage *msg);
 =

 =

 int __dundee_manager_init(void);
-- =

1.7.11.2


--===============0006638831989669150==--


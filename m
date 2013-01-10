Content-Type: multipart/mixed; boundary="===============2592096919296484843=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 5/6] hfp_hf: Add hfp_driver
Date: Thu, 10 Jan 2013 11:44:48 -0300
Message-ID: <1357829089-16029-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1357829089-16029-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2592096919296484843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds HFP modem driver registration.
---
 Makefile.am             |   4 +-
 plugins/bluez5.c        | 112 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluez5.h        |  29 +++++++++++++
 plugins/hfp_hf_bluez5.c |  80 ++++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100644 plugins/bluez5.h

diff --git a/Makefile.am b/Makefile.am
index ee71f85..799cd28 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -409,10 +409,10 @@ builtin_sources +=3D plugins/sim900.c
 =

 if BLUEZ5
 builtin_modules +=3D bluez5
-builtin_sources +=3D plugins/bluez5.c
+builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
 =

 builtin_modules +=3D hfp_bluez5
-builtin_sources +=3D plugins/hfp_hf_bluez5.c
+builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
 =

 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 028af66..986a3ac 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -23,11 +23,123 @@
 #include <config.h>
 #endif
 =

+#include <errno.h>
 #include <glib.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 =

+#include <gdbus/gdbus.h>
+#include "bluez5.h"
+
+#define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
+
+static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("RegisterProfile() replied an error: %s, %s",
+						derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void unregister_profile_cb(DBusPendingCall *call, gpointer user_dat=
a)
+{
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("UnregisterProfile() replied an error: %s, %s",
+						derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+done:
+	dbus_message_unref(reply);
+}
+
+int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
+					const char *name, const char *object)
+{
+	DBusMessageIter iter, dict;
+	DBusPendingCall *c;
+	DBusMessage *msg;
+
+	DBG("Bluetooth: Registering %s (%s) profile", uuid, name);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, "/org/bluez",
+			BLUEZ_PROFILE_MGMT_INTERFACE, "RegisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &object);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &uuid);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+	ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &name);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (!dbus_connection_send_with_reply(conn, msg, &c, -1)) {
+		ofono_error("Sending RegisterProfile failed");
+		dbus_message_unref(msg);
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(c, profile_register_cb, NULL, NULL);
+	dbus_pending_call_unref(c);
+
+	dbus_message_unref(msg);
+
+	return 0;
+}
+
+void bluetooth_unregister_profile(DBusConnection *conn, const char *object)
+{
+	DBusMessageIter iter;
+	DBusPendingCall *c;
+	DBusMessage *msg;
+
+	DBG("Bluetooth: Unregistering profile %s", object);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, "/org/bluez",
+			BLUEZ_PROFILE_MGMT_INTERFACE, "UnregisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &object);
+
+	if (!dbus_connection_send_with_reply(conn, msg, &c, -1)) {
+		ofono_error("Sending RegisterProfile failed");
+		dbus_message_unref(msg);
+		return;
+	}
+
+	dbus_pending_call_set_notify(c, unregister_profile_cb, NULL, NULL);
+	dbus_pending_call_unref(c);
+
+	dbus_message_unref(msg);
+}
+
 OFONO_PLUGIN_DEFINE(bluez5, "BlueZ 5 Utils Plugin", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
new file mode 100644
index 0000000..e403b85
--- /dev/null
+++ b/plugins/bluez5.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#define	BLUEZ_SERVICE "org.bluez"
+
+#define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
+
+int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
+					const char *name, const char *object);
+
+void bluetooth_unregister_profile(DBusConnection *conn, const char *object=
);
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index aa77ba7..ff70481 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -23,19 +23,99 @@
 #include <config.h>
 #endif
 =

+#include <errno.h>
 #include <glib.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 =

+#include "bluez5.h"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+#define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
+
+static int hfp_probe(struct ofono_modem *modem)
+{
+	DBG("modem: %p", modem);
+
+	return 0;
+}
+
+static void hfp_remove(struct ofono_modem *modem)
+{
+	DBG("modem: %p", modem);
+}
+
+/* power up hardware */
+static int hfp_enable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	return 0;
+}
+
+static int hfp_disable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	return 0;
+}
+
+static void hfp_pre_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static void hfp_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static struct ofono_modem_driver hfp_driver =3D {
+	.name		=3D "hfp",
+	.modem_type	=3D OFONO_MODEM_TYPE_HFP,
+	.probe		=3D hfp_probe,
+	.remove		=3D hfp_remove,
+	.enable		=3D hfp_enable,
+	.disable	=3D hfp_disable,
+	.pre_sim	=3D hfp_pre_sim,
+	.post_sim	=3D hfp_post_sim,
+};
+
 static int hfp_init(void)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	int err;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	err =3D ofono_modem_driver_register(&hfp_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
+						HFP_EXT_PROFILE_PATH);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&hfp_driver);
+		return err;
+	}
+
 	return 0;
 }
 =

 static void hfp_exit(void)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	bluetooth_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
+	ofono_modem_driver_unregister(&hfp_driver);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.7.11.7


--===============2592096919296484843==--


Content-Type: multipart/mixed; boundary="===============4922547616409465812=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 4/8] siri: Add atom implementation
Date: Mon, 16 Dec 2013 17:52:40 +0000
Message-ID: <1387216364-7138-5-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4922547616409465812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   3 +-
 src/ofono.h |   1 +
 src/siri.c  | 331 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 334 insertions(+), 1 deletion(-)
 mode change 100644 =3D> 100755 src/ofono.h
 create mode 100755 src/siri.c

diff --git a/Makefile.am b/Makefile.am
index cd84c14..371018e 100755
--- a/Makefile.am
+++ b/Makefile.am
@@ -521,7 +521,8 @@ src_ofonod_SOURCES =3D $(builtin_sources) src/ofono.ver=
 \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
 			src/cdma-provision.c src/handsfree.c \
 			src/handsfree-audio.c src/bluetooth.h \
-			src/hfp.h
+			src/hfp.h \
+			src/siri.c
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/ofono.h b/src/ofono.h
old mode 100644
new mode 100755
index 8abaf1e..c342329
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -151,6 +151,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CDMA_SMS,
 	OFONO_ATOM_TYPE_CDMA_NETREG,
 	OFONO_ATOM_TYPE_HANDSFREE,
+	OFONO_ATOM_TYPE_SIRI,
 };
 =

 enum ofono_atom_watch_condition {
diff --git a/src/siri.c b/src/siri.c
new file mode 100755
index 0000000..80ba6c9
--- /dev/null
+++ b/src/siri.c
@@ -0,0 +1,331 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2013  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/siri.h>
+
+#include <gdbus.h>
+#include "ofono.h"
+#include "common.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_siri {
+	ofono_bool_t siri_status;
+	unsigned int eyes_free_mode;
+	unsigned int pending_eyes_free_mode;
+	const struct ofono_siri_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	DBusMessage *pending;
+};
+
+void ofono_siri_set_status(struct ofono_siri *siri, int value)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(siri->atom);
+	dbus_bool_t siri_status;
+
+	if (siri =3D=3D NULL)
+		return;
+
+	if (value =3D=3D 1)
+		siri->siri_status =3D TRUE;
+	else
+		siri->siri_status =3D FALSE;
+
+	siri_status =3D siri->siri_status;
+
+	if (__ofono_atom_get_registered(siri->atom) =3D=3D FALSE)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_SIRI_INTERFACE,
+				"Enabled", DBUS_TYPE_BOOLEAN,
+				&siri_status);
+}
+
+static DBusMessage *siri_get_properties(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_siri *siri =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t status;
+	const char *eyes_free_str;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE,
+				&dict);
+
+	status =3D siri->siri_status;
+
+	ofono_dbus_dict_append(&dict, "Enabled", DBUS_TYPE_BOOLEAN,
+				&status);
+
+	if (siri->eyes_free_mode =3D=3D 0)
+		eyes_free_str =3D "disabled";
+	else
+		eyes_free_str =3D "enabled";
+
+	ofono_dbus_dict_append(&dict, "EyesFreeMode", DBUS_TYPE_STRING,
+				&eyes_free_str);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void set_eyes_free_mode_callback(const struct ofono_error *error,
+					struct ofono_siri *siri)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(siri->atom);
+	DBusMessage *reply;
+	const char *eyes_free_str;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Set eyes free mode callback returned error %s",
+					telephony_error_to_str(error));
+		reply =3D __ofono_error_failed(siri->pending);
+		__ofono_dbus_pending_reply(&siri->pending, reply);
+		return;
+	}
+
+	siri->eyes_free_mode =3D siri->pending_eyes_free_mode;
+
+	if (siri->eyes_free_mode =3D=3D 0)
+		eyes_free_str =3D "disabled";
+	else
+		eyes_free_str =3D "enabled";
+
+	reply =3D dbus_message_new_method_return(siri->pending);
+	__ofono_dbus_pending_reply(&siri->pending, reply);
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_SIRI_INTERFACE,
+				"EyesFreeMode", DBUS_TYPE_STRING,
+				&eyes_free_str);
+}
+
+static DBusMessage *siri_set_property(DBusConnection *conn,
+							DBusMessage *msg, void *data)
+{
+	struct ofono_siri *siri =3D data;
+	DBusMessageIter iter, var;
+	char *val;
+	const char *name;
+
+	if (siri->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&var, &val);
+
+	if (g_str_equal(name, "EyesFreeMode") =3D=3D TRUE) {
+		if (!siri->driver->set_eyes_free_mode)
+			return __ofono_error_not_implemented(msg);
+
+		if (g_str_equal(val, "disabled") =3D=3D TRUE)
+			siri->pending_eyes_free_mode =3D 0;
+		else if (g_str_equal(val, "enabled") =3D=3D TRUE)
+			siri->pending_eyes_free_mode =3D 1;
+		else
+			return __ofono_error_invalid_args(msg);
+
+		siri->pending =3D dbus_message_ref(msg);
+		siri->driver->set_eyes_free_mode(siri, set_eyes_free_mode_callback,
+						siri->pending_eyes_free_mode);
+	} else
+		return __ofono_error_invalid_args(msg);
+
+	return NULL;
+}
+
+static const GDBusMethodTable siri_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}"}),
+			siri_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }), NULL,
+			siri_set_property) },
+	{ }
+};
+
+static const GDBusSignalTable siri_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s"}, { "value", "v"})) },
+	{ }
+};
+
+static void siri_remove(struct ofono_atom *atom)
+{
+	struct ofono_siri *siri =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (siri =3D=3D NULL)
+		return;
+
+	if (siri->driver !=3D NULL && siri->driver->remove !=3D NULL)
+		siri->driver->remove(siri);
+
+	g_free(siri);
+}
+
+struct ofono_siri *ofono_siri_create(struct ofono_modem *modem,
+			unsigned int vendor, const char *driver, void *data)
+{
+	struct ofono_siri *siri;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	siri =3D g_try_new0(struct ofono_siri, 1);
+	if (siri =3D=3D NULL)
+		return NULL;
+
+	siri->atom =3D __ofono_modem_add_atom(modem,
+						OFONO_ATOM_TYPE_SIRI,
+						siri_remove, siri);
+
+	siri->eyes_free_mode =3D 0;
+	siri->pending_eyes_free_mode =3D 0;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_siri_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(siri, vendor, data) < 0)
+			continue;
+
+		siri->driver =3D drv;
+		break;
+	}
+
+	return siri;
+}
+
+static void ofono_siri_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+	struct ofono_siri *siri =3D __ofono_atom_get_data(atom);
+
+	if (siri->pending) {
+		DBusMessage *reply =3D __ofono_error_failed(siri->pending);
+		__ofono_dbus_pending_reply(&siri->pending, reply);
+	}
+
+	ofono_modem_remove_interface(modem, OFONO_SIRI_INTERFACE);
+	g_dbus_unregister_interface(conn, path,
+					OFONO_SIRI_INTERFACE);
+}
+
+void ofono_siri_register(struct ofono_siri *siri)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(siri->atom);
+	const char *path =3D __ofono_atom_get_path(siri->atom);
+
+	if (!g_dbus_register_interface(conn, path, OFONO_SIRI_INTERFACE,
+					siri_methods, siri_signals, NULL, siri, NULL)) {
+		ofono_error("Could not create %s interface", OFONO_SIRI_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_SIRI_INTERFACE);
+	__ofono_atom_register(siri->atom, ofono_siri_unregister);
+}
+
+int ofono_siri_driver_register(const struct ofono_siri_driver *driver)
+{
+	DBG("driver: %p, name: %s", driver, driver->name);
+
+	if (driver->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) driver);
+
+	return 0;
+}
+
+void ofono_siri_driver_unregister(const struct ofono_siri_driver *driver)
+{
+	DBG("driver: %p, name: %s", driver, driver->name);
+	g_drivers =3D g_slist_remove(g_drivers, (void *) driver);
+}
+
+void ofono_siri_remove(struct ofono_siri *siri)
+{
+	__ofono_atom_free(siri->atom);
+}
+
+void ofono_siri_set_data(struct ofono_siri *siri, void *data)
+{
+	siri->driver_data =3D data;
+}
+
+void *ofono_siri_get_data(struct ofono_siri *siri)
+{
+	return siri->driver_data;
+}
-- =

1.7.11.7


--===============4922547616409465812==--


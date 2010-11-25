Content-Type: multipart/mixed; boundary="===============5289623475669815267=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/5] text-telephony: implement interface/atom
Date: Thu, 25 Nov 2010 15:41:57 -0200
Message-ID: <1290706920-24740-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1290706920-24740-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5289623475669815267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 src/ctm.c   |  334 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |    2 +
 3 files changed, 337 insertions(+), 1 deletions(-)
 create mode 100644 src/ctm.c

diff --git a/Makefile.am b/Makefile.am
index 2615be7..93db7ea 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,7 +319,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h
+			src/smsagent.c src/smsagent.h src/ctm.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/ctm.c b/src/ctm.c
new file mode 100644
index 0000000..1d683df
--- /dev/null
+++ b/src/ctm.c
@@ -0,0 +1,334 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "common.h"
+
+#define CTM_FLAG_CACHED 0x1
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_ctm {
+	DBusMessage *pending;
+	int flags;
+	ofono_bool_t enabled;
+	const struct ofono_ctm_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static DBusMessage *ctm_get_properties_reply(DBusMessage *msg,
+						struct ofono_ctm *ctm)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D ctm->enabled;
+	ofono_dbus_dict_append(&dict, "Enabled", DBUS_TYPE_BOOLEAN, &value);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void ctm_signal_enabled(struct ofono_ctm *ctm)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(ctm->atom);
+	ofono_bool_t value =3D ctm->enabled;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_TEXT_TELEPHONY_INTERFACE,
+						"Enabled",
+						DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void ctm_set_enabled_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_ctm *ctm =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting ctm enabled property");
+
+		reply =3D __ofono_error_failed(ctm->pending);
+		__ofono_dbus_pending_reply(&ctm->pending, reply);
+
+		return;
+	}
+
+	ctm->enabled =3D !ctm->enabled;
+
+	reply =3D dbus_message_new_method_return(ctm->pending);
+	__ofono_dbus_pending_reply(&ctm->pending, reply);
+
+	ctm_signal_enabled(ctm);
+}
+
+static void ctm_query_enabled_callback(const struct ofono_error *error,
+						ofono_bool_t enable, void *data)
+{
+	struct ofono_ctm *ctm =3D data;
+	DBusMessage *reply;
+	ofono_bool_t enabled_old;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBusMessage *reply;
+
+		DBG("Error during ctm enabled query");
+
+		reply =3D __ofono_error_failed(ctm->pending);
+		__ofono_dbus_pending_reply(&ctm->pending, reply);
+
+		return;
+	}
+
+	ctm->flags |=3D CTM_FLAG_CACHED;
+
+	enabled_old =3D ctm->enabled;
+	ctm->enabled =3D enable;
+
+	reply =3D ctm_get_properties_reply(ctm->pending, ctm);
+	__ofono_dbus_pending_reply(&ctm->pending, reply);
+
+	if (ctm->enabled ^ enabled_old)
+		ctm_signal_enabled(ctm);
+}
+
+static DBusMessage *ctm_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_ctm *ctm =3D data;
+
+	if (ctm->flags & CTM_FLAG_CACHED)
+		return ctm_get_properties_reply(msg, ctm);
+
+	if (ctm->pending)
+		return __ofono_error_busy(msg);
+
+	ctm->pending =3D dbus_message_ref(msg);
+
+	ctm->driver->query_tty(ctm, ctm_query_enabled_callback, ctm);
+
+	return NULL;
+}
+
+static DBusMessage *ctm_set_property(DBusConnection *conn, DBusMessage *ms=
g,
+					void *data)
+{
+	struct ofono_ctm *ctm =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (ctm->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (g_strcmp0(property, "Enabled") =3D=3D 0) {
+		dbus_bool_t value;
+		int target;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		target =3D value;
+
+		if (ctm->enabled =3D=3D target)
+			return dbus_message_new_method_return(msg);
+
+		ctm->pending =3D dbus_message_ref(msg);
+
+		ctm->driver->set_tty(ctm, target,
+					ctm_set_enabled_callback, ctm);
+		return NULL;
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable ctm_methods[] =3D {
+	{ "GetProperties",  "",    "a{sv}",  ctm_get_properties,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetProperty",    "sv",  "",       ctm_set_property,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable ctm_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+int ofono_ctm_driver_register(const struct ofono_ctm_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d =3D=3D NULL || d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_ctm_driver_unregister(const struct ofono_ctm_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d =3D=3D NULL)
+		return;
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void text_telephony_unregister(struct ofono_atom *atom)
+{
+	struct ofono_ctm *ctm =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(ctm->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ctm->atom);
+
+	ofono_modem_remove_interface(modem, OFONO_TEXT_TELEPHONY_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_TEXT_TELEPHONY_INTERFACE);
+}
+
+static void text_telephony_remove(struct ofono_atom *atom)
+{
+	struct ofono_ctm *ctm =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (ctm =3D=3D NULL)
+		return;
+
+	if (ctm->driver && ctm->driver->remove)
+		ctm->driver->remove(ctm);
+
+	g_free(ctm);
+}
+
+struct ofono_ctm *ofono_ctm_create(struct ofono_modem *modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct ofono_ctm *ctm;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	ctm =3D g_try_new0(struct ofono_ctm, 1);
+	if (ctm =3D=3D NULL)
+		return NULL;
+
+	ctm->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_CTM,
+						text_telephony_remove, ctm);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_ctm_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver) !=3D 0)
+			continue;
+
+		if (drv->probe(ctm, vendor, data) < 0)
+			continue;
+
+		ctm->driver =3D drv;
+		break;
+	}
+
+	return ctm;
+}
+
+void ofono_ctm_register(struct ofono_ctm *ctm)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ctm->atom);
+	const char *path =3D __ofono_atom_get_path(ctm->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_TEXT_TELEPHONY_INTERFACE,
+					ctm_methods, ctm_signals,
+					NULL, ctm, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_TEXT_TELEPHONY_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_TEXT_TELEPHONY_INTERFACE);
+	__ofono_atom_register(ctm->atom, text_telephony_unregister);
+}
+
+void ofono_ctm_remove(struct ofono_ctm *ctm)
+{
+	__ofono_atom_free(ctm->atom);
+}
+
+void ofono_ctm_set_data(struct ofono_ctm *ctm,
+					void *data)
+{
+	ctm->driver_data =3D data;
+}
+
+void *ofono_ctm_get_data(struct ofono_ctm *ctm)
+{
+	return ctm->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index d1a4bdc..792134b 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -125,6 +125,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_AUDIO_SETTINGS =3D 19,
 	OFONO_ATOM_TYPE_STK =3D 20,
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
+	OFONO_ATOM_TYPE_CTM =3D 22,
 };
 =

 enum ofono_atom_watch_condition {
@@ -205,6 +206,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
l_settings *cs);
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
+#include <ofono/ctm.h>
 =

 #include <ofono/voicecall.h>
 =

-- =

1.7.3.2


--===============5289623475669815267==--


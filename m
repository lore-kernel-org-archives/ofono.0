Content-Type: multipart/mixed; boundary="===============5811674734701974224=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] Add TTY (hearing impaired) support
Date: Thu, 18 Nov 2010 09:26:54 -0200
Message-ID: <1290079616-2754-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5811674734701974224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                |    5 +-
 doc/text-telephony-api.txt |   38 +++++
 include/dbus.h             |    1 +
 include/text-telephony.h   |   71 ++++++++++
 src/modem.c                |    1 +
 src/ofono.h                |    2 +
 src/text-telephony.c       |  333 ++++++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 449 insertions(+), 2 deletions(-)
 create mode 100644 doc/text-telephony-api.txt
 create mode 100644 include/text-telephony.h
 create mode 100644 src/text-telephony.c

diff --git a/Makefile.am b/Makefile.am
index f841b4c..ee1313d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
-			include/audio-settings.h include/nettime.h
+			include/audio-settings.h include/nettime.h \
+			include/text-telephony.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -318,7 +319,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h
+			src/smsagent.c src/smsagent.h src/text-telephony.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/doc/text-telephony-api.txt b/doc/text-telephony-api.txt
new file mode 100644
index 0000000..8623d5f
--- /dev/null
+++ b/doc/text-telephony-api.txt
@@ -0,0 +1,38 @@
+Text Telephony hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.TextTelephony
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all Text Telephony properties. See the
+			properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.DoesNotExist
+					 [service].Error.InProgress
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean	Powered [readwrite]
+
+			This property will enable or disable the text
+			telephony feature in the modem.
+
+			Text telephony (TTY), also known as TDD, is a feature
+			present in some modems that allow them to be used by
+			hearing impaired people.
diff --git a/include/dbus.h b/include/dbus.h
index 59b2aae..9e29afb 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -48,6 +48,7 @@ extern "C" {
 #define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
 #define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
 #define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
+#define OFONO_TEXT_TELEPHONY_INTERFACE "org.ofono.TextTelephony"
 #define OFONO_SIM_MANAGER_INTERFACE "org.ofono.SimManager"
 #define OFONO_VOICECALL_INTERFACE "org.ofono.VoiceCall"
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
diff --git a/include/text-telephony.h b/include/text-telephony.h
new file mode 100644
index 0000000..fafa7dd
--- /dev/null
+++ b/include/text-telephony.h
@@ -0,0 +1,71 @@
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
+#ifndef __OFONO_TEXT_TELEPHONY_H
+#define __OFONO_TEXT_TELEPHONY_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_text_telephony;
+
+typedef void (*ofono_text_telephony_set_cb_t)(const struct ofono_error *er=
ror,
+						void *data);
+typedef void (*ofono_text_telephony_query_cb_t)(const struct ofono_error *=
error,
+						ofono_bool_t enable, void *data);
+
+struct ofono_text_telephony_driver {
+	const char *name;
+	int (*probe)(struct ofono_text_telephony *tt, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_text_telephony *tt);
+	void (*query_tty)(struct ofono_text_telephony *tt,
+				ofono_text_telephony_query_cb_t cb,
+				void *data);
+	void (*set_tty)(struct ofono_text_telephony *tt,
+				int enable,
+				ofono_text_telephony_set_cb_t cb,
+				void *data);
+};
+
+int ofono_text_telephony_driver_register(const struct ofono_text_telephony=
_driver *d);
+void ofono_text_telephony_driver_unregister(const struct ofono_text_teleph=
ony_driver *d);
+
+struct ofono_text_telephony *ofono_text_telephony_create(struct ofono_mode=
m *modem,
+								unsigned int vendor,
+								const char *driver,
+								void *data);
+
+void ofono_text_telephony_register(struct ofono_text_telephony *tt);
+void ofono_text_telephony_remove(struct ofono_text_telephony *tt);
+
+void ofono_text_telephony_set_data(struct ofono_text_telephony *tt, void *=
data);
+void *ofono_text_telephony_get_data(struct ofono_text_telephony *tt);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_TEXT_TELEPHONY_H */
diff --git a/src/modem.c b/src/modem.c
index 3776461..6f1db7c 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -857,6 +857,7 @@ static const struct {
 	{ OFONO_SIM_MANAGER_INTERFACE,			"sim"	},
 	{ OFONO_STK_INTERFACE,				"stk"	},
 	{ OFONO_CONNECTION_MANAGER_INTERFACE,		"gprs"	},
+	{ OFONO_TEXT_TELEPHONY_INTERFACE,		"tty"	},
 	{ },
 };
 =

diff --git a/src/ofono.h b/src/ofono.h
index 4d76d20..5218f42 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -124,6 +124,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_AUDIO_SETTINGS =3D 19,
 	OFONO_ATOM_TYPE_STK =3D 20,
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
+	OFONO_ATOM_TYPE_TEXT_TELEPHONY =3D 22
 };
 =

 enum ofono_atom_watch_condition {
@@ -197,6 +198,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
l_settings *cs);
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
+#include <ofono/text-telephony.h>
 =

 #include <ofono/voicecall.h>
 =

diff --git a/src/text-telephony.c b/src/text-telephony.c
new file mode 100644
index 0000000..4640bd8
--- /dev/null
+++ b/src/text-telephony.c
@@ -0,0 +1,333 @@
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
+static GSList *g_drivers =3D NULL;
+
+struct ofono_text_telephony {
+	DBusMessage *pending;
+	ofono_bool_t powered;
+	ofono_bool_t powered_pending;
+	const struct ofono_text_telephony_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static DBusMessage *tt_get_properties_reply(DBusMessage *msg,
+						struct ofono_text_telephony *tt)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D tt->powered;
+	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void tt_set_powered(struct ofono_text_telephony *tt,
+					ofono_bool_t enable)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(tt->atom);
+	dbus_bool_t value =3D enable;
+
+	if (tt->powered =3D=3D enable)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_TEXT_TELEPHONY_INTERFACE,
+						"Powered",
+						DBUS_TYPE_BOOLEAN, &value);
+	tt->powered =3D enable;
+}
+
+static void tt_set_powered_callback(const struct ofono_error *error,
+						void *data)
+{
+	struct ofono_text_telephony *tt =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting powered property");
+
+		tt->powered_pending =3D tt->powered;
+
+		reply =3D __ofono_error_failed(tt->pending);
+		__ofono_dbus_pending_reply(&tt->pending, reply);
+
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(tt->pending);
+	__ofono_dbus_pending_reply(&tt->pending, reply);
+
+	tt_set_powered(tt, tt->powered_pending);
+}
+
+static void tt_send_properties_reply(struct ofono_text_telephony *tt)
+{
+	DBusMessage *reply;
+
+	reply =3D tt_get_properties_reply(tt->pending, tt);
+	__ofono_dbus_pending_reply(&tt->pending, reply);
+}
+
+static void tt_query_powered_callback(const struct ofono_error *error,
+						ofono_bool_t enable, void *data)
+{
+	struct ofono_text_telephony *tt =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBusMessage *reply;
+
+		ofono_debug("Error during powered query");
+
+		reply =3D __ofono_error_failed(tt->pending);
+		__ofono_dbus_pending_reply(&tt->pending, reply);
+
+		return;
+	}
+
+	tt_set_powered(tt, enable);
+	tt_send_properties_reply(tt);
+}
+
+static DBusMessage *tt_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_text_telephony *tt =3D data;
+
+	if (tt->pending)
+		return __ofono_error_busy(msg);
+
+	tt->pending =3D dbus_message_ref(msg);
+	tt->driver->query_tty(tt, tt_query_powered_callback, tt);
+
+	return NULL;
+}
+
+static DBusMessage *tt_set_property(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_text_telephony *tt =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (tt->pending)
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
+	if (g_strcmp0(property, "Powered") =3D=3D 0) {
+		dbus_bool_t value;
+		int target;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		target =3D value;
+
+		if (tt->powered =3D=3D target)
+			return dbus_message_new_method_return(msg);
+
+		tt->pending =3D dbus_message_ref(msg);
+		tt->powered_pending =3D target;
+
+		tt->driver->set_tty(tt, target,
+					tt_set_powered_callback, tt);
+		return NULL;
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable tt_methods[] =3D {
+	{ "GetProperties",  "",    "a{sv}",  tt_get_properties,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetProperty",    "sv",  "",       tt_set_property,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable tt_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+int ofono_text_telephony_driver_register(const struct ofono_text_telephony=
_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (!d || !d->probe)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_text_telephony_driver_unregister(const struct ofono_text_teleph=
ony_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (!d)
+		return;
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void text_telephony_unregister(struct ofono_atom *atom)
+{
+	struct ofono_text_telephony *tt =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(tt->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(tt->atom);
+
+	ofono_modem_remove_interface(modem, OFONO_TEXT_TELEPHONY_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_TEXT_TELEPHONY_INTERFACE);
+}
+
+static void text_telephony_remove(struct ofono_atom *atom)
+{
+	struct ofono_text_telephony *tt =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (!tt)
+		return;
+
+	if (tt->driver && tt->driver->remove)
+		tt->driver->remove(tt);
+
+	g_free(tt);
+}
+
+struct ofono_text_telephony *ofono_text_telephony_create(struct ofono_mode=
m *modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct ofono_text_telephony *tt;
+	GSList *l;
+	if (!driver)
+		return NULL;
+
+	tt =3D g_try_new0(struct ofono_text_telephony, 1);
+	if (!tt)
+		return NULL;
+
+	tt->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_TEXT_TELEPHONY,
+						text_telephony_remove, tt);
+
+	tt->powered =3D -1;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_text_telephony_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver) !=3D 0)
+			continue;
+
+		if (drv->probe(tt, vendor, data) < 0)
+			continue;
+
+		tt->driver =3D drv;
+		break;
+	}
+
+	return tt;
+}
+
+void ofono_text_telephony_register(struct ofono_text_telephony *tt)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(tt->atom);
+	const char *path =3D __ofono_atom_get_path(tt->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_TEXT_TELEPHONY_INTERFACE,
+						tt_methods, tt_signals,
+					NULL, tt, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_TEXT_TELEPHONY_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_TEXT_TELEPHONY_INTERFACE);
+	__ofono_atom_register(tt->atom, text_telephony_unregister);
+}
+
+void ofono_text_telephony_remove(struct ofono_text_telephony *tt)
+{
+	__ofono_atom_free(tt->atom);
+}
+
+void ofono_text_telephony_set_data(struct ofono_text_telephony *tt,
+					void *data)
+{
+	tt->driver_data =3D data;
+}
+
+void *ofono_text_telephony_get_data(struct ofono_text_telephony *tt)
+{
+	return tt->driver_data;
+}
-- =

1.7.3.2


--===============5811674734701974224==--


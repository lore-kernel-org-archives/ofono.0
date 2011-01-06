Content-Type: multipart/mixed; boundary="===============2088161486496245343=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: [PATCH 3/3] message: Code independent of protocol stack
Date: Thu, 06 Jan 2011 11:50:55 -0800
Message-ID: <1294343455-29551-4-git-send-email-faiyaz.baxamusa@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2088161486496245343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |    2 +-
 src/message.c |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 src/ofono.h   |    2 +
 src/sms.c     |  258 ++++++++---------------------------------------------=
---
 4 files changed, 297 insertions(+), 222 deletions(-)
 create mode 100644 src/message.c

diff --git a/Makefile.am b/Makefile.am
index 8b19eef..756e6b7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -329,7 +329,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/message.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/message.c b/src/message.c
new file mode 100644
index 0000000..9e880f6
--- /dev/null
+++ b/src/message.c
@@ -0,0 +1,257 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <gdbus.h>
+#include <stdio.h>
+
+#include <ofono/types.h>
+
+#include "ofono.h"
+#include "common.h"
+
+struct message {
+	struct ofono_uuid uuid;
+	enum message_state state;
+	void *data;
+};
+
+static const char *message_state_to_string(enum message_state s)
+{
+	switch (s) {
+	case MESSAGE_STATE_PENDING:
+		return "pending";
+	case MESSAGE_STATE_SENT:
+		return "sent";
+	case MESSAGE_STATE_FAILED:
+		return "failed";
+	}
+
+	return "invalid";
+}
+
+static DBusMessage *message_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct message *m =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	ofono_message_append_properties(m, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable message_methods[] =3D {
+	{ "GetProperties",  "",    "a{sv}",   message_get_properties },
+	{ }
+};
+
+static GDBusSignalTable message_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+struct message *ofono_message_create(const struct ofono_uuid *uuid,
+								void *data)
+{
+	struct message *v;
+
+	if (uuid =3D=3D NULL)
+		return NULL;
+
+	v =3D g_try_new0(struct message, 1);
+	if (v =3D=3D NULL)
+		return NULL;
+
+	memcpy(&v->uuid, uuid, sizeof(*uuid));
+
+	v->data =3D data;
+
+	return v;
+}
+
+static void message_destroy(gpointer userdata)
+{
+	struct message *m =3D userdata;
+
+	if (m =3D=3D NULL)
+		return;
+
+	m->data =3D NULL;
+	g_free(m);
+}
+
+gboolean ofono_message_dbus_register(const char *atompath, struct message =
*m)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
+		return FALSE;
+
+	path =3D ofono_message_path_from_uuid(atompath, &m->uuid);
+
+	if (!g_dbus_register_interface(conn, path, OFONO_MESSAGE_INTERFACE,
+					message_methods, message_signals,
+					NULL, m, message_destroy)) {
+		ofono_error("Could not register Message %s", path);
+		message_destroy(m);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+void ofono_message_dbus_unregister(const char *atompath, struct message *m)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
+		return;
+
+	path =3D ofono_message_path_from_uuid(atompath, &m->uuid);
+
+	g_dbus_unregister_interface(conn, path, OFONO_MESSAGE_INTERFACE);
+
+	return;
+}
+
+const struct ofono_uuid *ofono_message_get_uuid(const struct message *m)
+{
+	if (m =3D=3D NULL)
+		return NULL;
+
+	return &m->uuid;
+}
+
+void ofono_message_set_state(const char *atompath,
+			struct message *m, enum message_state new_state)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *state;
+	const char *path;
+
+	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
+		return;
+
+	if (m->state =3D=3D new_state)
+		return;
+
+	path =3D ofono_message_path_from_uuid(atompath, &m->uuid);
+
+	m->state =3D new_state;
+	state =3D message_state_to_string(m->state);
+
+	ofono_dbus_signal_property_changed(conn, path, OFONO_MESSAGE_INTERFACE,
+						"State", DBUS_TYPE_STRING,
+									&state);
+}
+
+void ofono_message_append_properties(struct message *m, DBusMessageIter *d=
ict)
+{
+	const char *state;
+
+	if (m =3D=3D NULL)
+		return;
+
+	state =3D message_state_to_string(m->state);
+	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &state);
+}
+
+void ofono_emit_message_added(const char *atompath, const char *interface,
+							struct message *m)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *path;
+
+	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
+		return;
+
+	signal =3D dbus_message_new_signal(atompath, interface, "MessageAdded");
+	if (signal =3D=3D NULL)
+		return;
+
+	path =3D ofono_message_path_from_uuid(atompath, &m->uuid);
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	ofono_message_append_properties(m, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), signal);
+}
+
+void ofono_emit_message_removed(const char *atompath, const char *interfac=
e,
+							struct message *m)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
+		return;
+
+	path =3D ofono_message_path_from_uuid(atompath, &m->uuid);
+
+	g_dbus_emit_signal(conn, atompath, interface,
+				"MessageRemoved", DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+}
+
+const char *ofono_message_path_from_uuid(const char *atompath,
+						const struct ofono_uuid *uuid)
+{
+	static char path[256];
+
+	snprintf(path, sizeof(path), "%s/message_%s", atompath,
+						ofono_uuid_to_str(uuid));
+
+	return path;
+}
+
+void *ofono_message_get_data(struct message *m)
+{
+	return m->data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index cab70cd..eed35d6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -235,6 +235,8 @@ int __ofono_voicecall_tone_send(struct ofono_voicecall =
*vc,
 				ofono_voicecall_tone_cb_t cb, void *user_data);
 void __ofono_voicecall_tone_cancel(struct ofono_voicecall *vc, int id);
 =

+#include <ofono/message.h>
+
 #include <ofono/sms.h>
 =

 struct sms;
diff --git a/src/sms.c b/src/sms.c
index 9bb5c93..57e6c62 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -24,7 +24,6 @@
 #endif
 =

 #include <string.h>
-#include <stdio.h>
 #include <errno.h>
 =

 #include <glib.h>
@@ -52,18 +51,6 @@ static gboolean tx_next(gpointer user_data);
 =

 static GSList *g_drivers =3D NULL;
 =

-enum message_state {
-	MESSAGE_STATE_PENDING =3D		0,
-	MESSAGE_STATE_SENT,
-	MESSAGE_STATE_FAILED
-};
-
-struct message {
-	struct ofono_uuid uuid;
-	enum message_state state;
-	struct tx_queue_entry *entry;
-};
-
 struct sms_handler {
 	struct ofono_watchlist_item item;
 	int dst;
@@ -163,28 +150,6 @@ static int sms_bearer_from_string(const char *str)
 	return -1;
 }
 =

-static const char *message_state_to_string(enum message_state s)
-{
-	switch (s) {
-	case MESSAGE_STATE_PENDING:
-		return "pending";
-	case MESSAGE_STATE_SENT:
-		return "sent";
-	case MESSAGE_STATE_FAILED:
-		return "failed";
-	}
-
-	return "invalid";
-}
-
-static void append_message_properties(struct message *m, DBusMessageIter *=
dict)
-{
-	const char *state;
-
-	state =3D message_state_to_string(m->state);
-	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &state);
-}
-
 static unsigned int add_sms_handler(struct ofono_watchlist *watchlist,
 					int dst, int src, void *notify,
 					void *data, ofono_destroy_func destroy)
@@ -256,181 +221,12 @@ gboolean __ofono_sms_datagram_watch_remove(struct of=
ono_sms *sms,
 	return __ofono_watchlist_remove_item(sms->datagram_handlers, id);
 }
 =

-static DBusMessage *message_get_properties(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct message *m =3D data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-
-	reply =3D dbus_message_new_method_return(msg);
-	if (reply =3D=3D NULL)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-	append_message_properties(m, &dict);
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
-static GDBusMethodTable message_methods[] =3D {
-	{ "GetProperties",  "",    "a{sv}",   message_get_properties },
-	{ }
-};
-
-static GDBusSignalTable message_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-	{ }
-};
-
-static struct message *message_create(const struct ofono_uuid *uuid)
-{
-	struct message *v;
-
-	if (uuid =3D=3D NULL)
-		return NULL;
-
-	v =3D g_try_new0(struct message, 1);
-	if (v =3D=3D NULL)
-		return NULL;
-
-	memcpy(&v->uuid, uuid, sizeof(*uuid));
-
-	return v;
-}
-
-static void message_destroy(gpointer userdata)
-{
-	struct message *m =3D userdata;
-
-	g_free(m);
-}
-
 const char *__ofono_sms_message_path_from_uuid(struct ofono_sms *sms,
 						const struct ofono_uuid *uuid)
 {
-	static char path[256];
-
-	snprintf(path, sizeof(path), "%s/message_%s",
-			__ofono_atom_get_path(sms->atom),
-			ofono_uuid_to_str(uuid));
-
-	return path;
-}
-
-static gboolean message_dbus_register(struct ofono_sms *sms, struct messag=
e *m)
-{
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path;
-
-	if (m =3D=3D NULL)
-		return FALSE;
-
-	path =3D __ofono_sms_message_path_from_uuid(sms, &m->uuid);
-
-	if (!g_dbus_register_interface(conn, path, OFONO_MESSAGE_INTERFACE,
-					message_methods, message_signals,
-					NULL, m, message_destroy)) {
-		ofono_error("Could not register Message %s", path);
-		message_destroy(m);
-
-		return FALSE;
-	}
-
-	return TRUE;
-}
-
-static gboolean message_dbus_unregister(struct ofono_sms *sms,
-						struct message *m)
-{
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_sms_message_path_from_uuid(sms, &m->uuid);
-
-	return g_dbus_unregister_interface(conn, path,
-						OFONO_MESSAGE_INTERFACE);
-}
-
-static void emit_message_added(struct ofono_sms *sms, struct message *m)
-{
-	DBusMessage *signal;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	const char *path;
-
-	path =3D __ofono_atom_get_path(sms->atom);
-
-	signal =3D dbus_message_new_signal(path,
-					OFONO_MESSAGE_MANAGER_INTERFACE,
-					"MessageAdded");
-
-	if (signal =3D=3D NULL)
-		return;
-
-	dbus_message_iter_init_append(signal, &iter);
-
-	path =3D __ofono_sms_message_path_from_uuid(sms, &m->uuid);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-	append_message_properties(m, &dict);
-	dbus_message_iter_close_container(&iter, &dict);
-
-	g_dbus_send_message(ofono_dbus_get_connection(), signal);
-}
-
-static void emit_message_removed(struct ofono_sms *sms, struct message *m)
-{
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *atompath =3D __ofono_atom_get_path(sms->atom);
-	const char *path =3D __ofono_sms_message_path_from_uuid(sms, &m->uuid);
-
-	g_dbus_emit_signal(conn, atompath, OFONO_MESSAGE_MANAGER_INTERFACE,
-				"MessageRemoved", DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-}
-
-static void message_set_state(struct ofono_sms *sms,
-					const struct ofono_uuid *uuid,
-					enum message_state new_state)
-{
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path;
-	const char *state;
-	struct message *m;
-
-	m =3D g_hash_table_lookup(sms->messages, uuid);
-
-	if (m =3D=3D NULL)
-		return;
-
-	if (m->state =3D=3D new_state)
-		return;
-
-	m->state =3D new_state;
-	path =3D __ofono_sms_message_path_from_uuid(sms, uuid);
-	state =3D message_state_to_string(m->state);
-
-	ofono_dbus_signal_property_changed(conn, path,
-						OFONO_MESSAGE_INTERFACE,
-						"State", DBUS_TYPE_STRING,
-						&state);
-
-	if (m->state =3D=3D MESSAGE_STATE_SENT ||
-			m->state =3D=3D MESSAGE_STATE_FAILED) {
-		m->entry =3D NULL;
-
-		g_hash_table_remove(sms->messages, uuid);
-		emit_message_removed(sms, m);
-		message_dbus_unregister(sms, m);
-	}
+	return ofono_message_path_from_uuid(
+					__ofono_atom_get_path(sms->atom),
+					uuid);
 }
 =

 static void set_bearer(struct ofono_sms *sms, int bearer)
@@ -743,6 +539,8 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
 	gboolean ok =3D error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR;
+	struct message *m =3D NULL;
+	const char *atompath;
 =

 	DBG("tx_finished");
 =

@@ -805,7 +603,17 @@ next_q:
 		else
 			ms =3D MESSAGE_STATE_FAILED;
 =

-		message_set_state(sms, &entry->uuid, ms);
+		m =3D g_hash_table_lookup(sms->messages, &entry->uuid);
+
+		if (m !=3D NULL) {
+			atompath =3D __ofono_atom_get_path(sms->atom);
+			ofono_message_set_state(atompath, m, ms);
+			g_hash_table_remove(sms->messages, &entry->uuid);
+			ofono_emit_message_removed(atompath,
+					OFONO_MESSAGE_MANAGER_INTERFACE,
+					m);
+			ofono_message_dbus_unregister(atompath, m);
+		}
 	}
 =

 	tx_queue_entry_destroy(entry);
@@ -1025,6 +833,7 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 	GHashTableIter hashiter;
 	gpointer key, value;
 	struct message *m;
+	const struct ofono_uuid *uuid;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -1047,8 +856,9 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 =

 	while (g_hash_table_iter_next(&hashiter, &key, &value)) {
 		m =3D value;
+		uuid =3D ofono_message_get_uuid(m);
 =

-		path =3D __ofono_sms_message_path_from_uuid(sms, &m->uuid);
+		path =3D __ofono_sms_message_path_from_uuid(sms, uuid);
 =

 		dbus_message_iter_open_container(&array, DBUS_TYPE_STRUCT,
 							NULL, &entry);
@@ -1058,7 +868,7 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

-		append_message_properties(m, &dict);
+		ofono_message_append_properties(m, &dict);
 		dbus_message_iter_close_container(&entry, &dict);
 		dbus_message_iter_close_container(&array, &entry);
 	}
@@ -1618,9 +1428,9 @@ static void sms_unregister(struct ofono_atom *atom)
 	struct ofono_sms *sms =3D __ofono_atom_get_data(atom);
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
-	const char *path =3D __ofono_atom_get_path(atom);
+	const char *atompath =3D __ofono_atom_get_path(atom);
 =

-	g_dbus_unregister_interface(conn, path,
+	g_dbus_unregister_interface(conn, atompath,
 					OFONO_MESSAGE_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_MESSAGE_MANAGER_INTERFACE);
 =

@@ -1639,7 +1449,7 @@ static void sms_unregister(struct ofono_atom *atom)
 =

 		while (g_hash_table_iter_next(&iter, &key, &value)) {
 			m =3D value;
-			message_dbus_unregister(sms, m);
+			ofono_message_dbus_unregister(atompath, m);
 		}
 =

 		g_hash_table_destroy(sms->messages);
@@ -1904,15 +1714,16 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, G=
SList *list,
 		return -ENOMEM;
 =

 	if (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
-		m =3D message_create(&entry->uuid);
+		m =3D ofono_message_create(&entry->uuid, entry);
 		if (m =3D=3D NULL)
 			goto err;
 =

-		if (message_dbus_register(sms, m) =3D=3D FALSE)
+		if (ofono_message_dbus_register(
+					__ofono_atom_get_path(sms->atom),
+								m) =3D=3D FALSE)
 			goto err;
 =

-		g_hash_table_insert(sms->messages, &m->uuid, m);
-		m->entry =3D entry;
+		g_hash_table_insert(sms->messages, &entry->uuid, m);
 	}
 =

 	if (list->next !=3D NULL) {
@@ -1934,7 +1745,9 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 		cb(sms, &entry->uuid, data);
 =

 	if (m && (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS))
-		emit_message_added(sms, m);
+		ofono_emit_message_added(__ofono_atom_get_path(sms->atom),
+					OFONO_MESSAGE_MANAGER_INTERFACE,
+					m);
 =

 	return 0;
 =

@@ -1951,15 +1764,18 @@ int __ofono_sms_txq_set_submit_notify(struct ofono_=
sms *sms,
 					ofono_destroy_func destroy)
 {
 	struct message *m;
+	struct tx_queue_entry *entry;
 =

 	m =3D g_hash_table_lookup(sms->messages, uuid);
 	if (m =3D=3D NULL)
 		return -ENOENT;
 =

-	if (m->entry =3D=3D NULL)
+	entry =3D (struct tx_queue_entry *)ofono_message_get_data(m);
+	if (entry =3D=3D NULL)
 		return -ENOTSUP;
 =

-	tx_queue_entry_set_submit_notify(m->entry, cb, data, destroy);
+	tx_queue_entry_set_submit_notify(entry, cb, data, destroy);
 =

 	return 0;
 }
+
-- =

1.7.0.4


--===============2088161486496245343==--


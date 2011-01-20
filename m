Content-Type: multipart/mixed; boundary="===============0666029652476357628=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: [PATCHv3 2/2] sms: Introduce message code independent of protocol
 stack
Date: Thu, 20 Jan 2011 13:42:37 -0800
Message-ID: <1295559757-22144-3-git-send-email-faiyaz.baxamusa@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0666029652476357628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |    3 +-
 src/message.c |  228 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/message.h |   54 +++++++++++++
 src/sms.c     |  247 +++++++----------------------------------------------=
----
 4 files changed, 312 insertions(+), 220 deletions(-)
 create mode 100644 src/message.c
 create mode 100644 src/message.h

diff --git a/Makefile.am b/Makefile.am
index 2618fa3..9933e32 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -354,7 +354,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c src/sim-auth.c
+			src/cdma-voicecall.c src/sim-auth.c \
+			src/message.h src/message.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/message.c b/src/message.c
new file mode 100644
index 0000000..050a522
--- /dev/null
+++ b/src/message.c
@@ -0,0 +1,228 @@
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
+#include "ofono.h"
+#include "message.h"
+
+struct message {
+	struct ofono_uuid uuid;
+	enum message_state state;
+	struct ofono_atom *atom;
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
+	return NULL;
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
+	message_append_properties(m, &dict);
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
+struct message *message_create(const struct ofono_uuid *uuid,
+							struct ofono_atom *atom)
+{
+	struct message *v;
+
+	v =3D g_try_new0(struct message, 1);
+	if (v =3D=3D NULL)
+		return NULL;
+
+	memcpy(&v->uuid, uuid, sizeof(*uuid));
+
+	v->atom =3D atom;
+
+	return v;
+}
+
+static void message_destroy(gpointer userdata)
+{
+	struct message *m =3D userdata;
+
+	g_free(m);
+}
+
+gboolean message_dbus_register(struct message *m)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D message_path_from_uuid(m->atom, &m->uuid);
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
+void message_dbus_unregister(struct message *m)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D message_path_from_uuid(m->atom, &m->uuid);
+
+	g_dbus_unregister_interface(conn, path, OFONO_MESSAGE_INTERFACE);
+
+	return;
+}
+
+const struct ofono_uuid *message_get_uuid(const struct message *m)
+{
+	return &m->uuid;
+}
+
+void message_set_state(struct message *m, enum message_state new_state)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *state;
+
+	if (m->state =3D=3D new_state)
+		return;
+
+	path =3D message_path_from_uuid(m->atom, &m->uuid);
+
+	m->state =3D new_state;
+	state =3D message_state_to_string(m->state);
+
+	ofono_dbus_signal_property_changed(conn, path, OFONO_MESSAGE_INTERFACE,
+							"State",
+							DBUS_TYPE_STRING,
+							&state);
+}
+
+void message_append_properties(struct message *m, DBusMessageIter *dict)
+{
+	const char *state =3D message_state_to_string(m->state);
+
+	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &state);
+}
+
+void message_emit_added(struct message *m, const char *interface)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *path;
+	const char *atompath =3D __ofono_atom_get_path(m->atom);
+
+	signal =3D dbus_message_new_signal(atompath, interface, "MessageAdded");
+	if (signal =3D=3D NULL)
+		return;
+
+	path =3D message_path_from_uuid(m->atom, &m->uuid);
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	message_append_properties(m, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), signal);
+}
+
+void message_emit_removed(struct message *m, const char *interface)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *atompath =3D __ofono_atom_get_path(m->atom);
+	const char *path =3D message_path_from_uuid(m->atom, &m->uuid);
+
+	g_dbus_emit_signal(conn, atompath, interface, "MessageRemoved",
+							DBUS_TYPE_OBJECT_PATH,
+							&path,
+							DBUS_TYPE_INVALID);
+}
+
+const char *message_path_from_uuid(struct ofono_atom *atom,
+						const struct ofono_uuid *uuid)
+{
+	static char path[256];
+	const char *atompath =3D __ofono_atom_get_path(atom);
+
+	snprintf(path, sizeof(path), "%s/message_%s", atompath,
+						ofono_uuid_to_str(uuid));
+
+	return path;
+}
+
+void *message_get_data(struct message *m)
+{
+	return m->data;
+}
+
+void message_set_data(struct message *m, void *data)
+{
+	m->data =3D data;
+}
diff --git a/src/message.h b/src/message.h
new file mode 100644
index 0000000..14e66c3
--- /dev/null
+++ b/src/message.h
@@ -0,0 +1,54 @@
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
+#include <ofono/types.h>
+
+enum message_state {
+	MESSAGE_STATE_PENDING,
+	MESSAGE_STATE_SENT,
+	MESSAGE_STATE_FAILED
+};
+
+struct ofono_atom;
+struct message;
+
+struct message *message_create(const struct ofono_uuid *uuid,
+						struct ofono_atom *atom);
+
+gboolean message_dbus_register(struct message *m);
+void message_dbus_unregister(struct message *m);
+
+const struct ofono_uuid *message_get_uuid(const struct message *m);
+
+void message_set_state(struct message *m, enum message_state new_state);
+
+void message_append_properties(struct message *m, DBusMessageIter *dict);
+
+void message_emit_added(struct message *m, const char *interface);
+
+void message_emit_removed(struct message *m, const char *interface);
+
+void *message_get_data(struct message *m);
+
+void message_set_data(struct message *m, void *data);
+
+const char *message_path_from_uuid(struct ofono_atom *atom,
+						const struct ofono_uuid *uuid);
diff --git a/src/sms.c b/src/sms.c
index 4d1a929..7224bdf 100644
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
@@ -38,6 +37,7 @@
 #include "smsutil.h"
 #include "storage.h"
 #include "simutil.h"
+#include "message.h"
 =

 #define uninitialized_var(x) x =3D x
 =

@@ -52,18 +52,6 @@ static gboolean tx_next(gpointer user_data);
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
@@ -167,28 +155,6 @@ static int sms_bearer_from_string(const char *str)
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
@@ -260,181 +226,10 @@ gboolean __ofono_sms_datagram_watch_remove(struct of=
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
+	return message_path_from_uuid(sms->atom, uuid);
 }
 =

 static void set_bearer(struct ofono_sms *sms, int bearer)
@@ -747,6 +542,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
 	gboolean ok =3D error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR;
+	struct message *m =3D NULL;
 =

 	DBG("tx_finished");
 =

@@ -814,7 +610,15 @@ next_q:
 		else
 			ms =3D MESSAGE_STATE_FAILED;
 =

-		message_set_state(sms, &entry->uuid, ms);
+		m =3D g_hash_table_lookup(sms->messages, &entry->uuid);
+
+		if (m !=3D NULL) {
+			message_set_state(m, ms);
+			g_hash_table_remove(sms->messages, &entry->uuid);
+			message_emit_removed(m,
+					OFONO_MESSAGE_MANAGER_INTERFACE);
+			message_dbus_unregister(m);
+		}
 	}
 =

 	tx_queue_entry_destroy(entry);
@@ -1089,6 +893,7 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 	GHashTableIter hashiter;
 	gpointer key, value;
 	struct message *m;
+	const struct ofono_uuid *uuid;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -1111,8 +916,9 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 =

 	while (g_hash_table_iter_next(&hashiter, &key, &value)) {
 		m =3D value;
+		uuid =3D message_get_uuid(m);
 =

-		path =3D __ofono_sms_message_path_from_uuid(sms, &m->uuid);
+		path =3D __ofono_sms_message_path_from_uuid(sms, uuid);
 =

 		dbus_message_iter_open_container(&array, DBUS_TYPE_STRUCT,
 							NULL, &entry);
@@ -1122,7 +928,7 @@ static DBusMessage *sms_get_messages(DBusConnection *c=
onn, DBusMessage *msg,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

-		append_message_properties(m, &dict);
+		message_append_properties(m, &dict);
 		dbus_message_iter_close_container(&entry, &dict);
 		dbus_message_iter_close_container(&array, &entry);
 	}
@@ -1716,7 +1522,7 @@ static void sms_unregister(struct ofono_atom *atom)
 =

 		while (g_hash_table_iter_next(&iter, &key, &value)) {
 			m =3D value;
-			message_dbus_unregister(sms, m);
+			message_dbus_unregister(m);
 		}
 =

 		g_hash_table_destroy(sms->messages);
@@ -1989,15 +1795,16 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, G=
SList *list,
 		return -ENOMEM;
 =

 	if (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
-		m =3D message_create(&entry->uuid);
+		m =3D message_create(&entry->uuid, sms->atom);
 		if (m =3D=3D NULL)
 			goto err;
 =

-		if (message_dbus_register(sms, m) =3D=3D FALSE)
+		if (message_dbus_register(m) =3D=3D FALSE)
 			goto err;
 =

-		g_hash_table_insert(sms->messages, &m->uuid, m);
-		m->entry =3D entry;
+		message_set_data(m, entry);
+
+		g_hash_table_insert(sms->messages, &entry->uuid, m);
 	}
 =

 	if (list->next !=3D NULL) {
@@ -2019,7 +1826,7 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 		cb(sms, &entry->uuid, data);
 =

 	if (m && (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS))
-		emit_message_added(sms, m);
+		message_emit_added(m, OFONO_MESSAGE_MANAGER_INTERFACE);
 =

 	return 0;
 =

@@ -2036,15 +1843,17 @@ int __ofono_sms_txq_set_submit_notify(struct ofono_=
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
+	entry =3D message_get_data(m);
+	if (entry =3D=3D NULL)
 		return -ENOTSUP;
 =

-	tx_queue_entry_set_submit_notify(m->entry, cb, data, destroy);
+	tx_queue_entry_set_submit_notify(entry, cb, data, destroy);
 =

 	return 0;
 }
-- =

1.7.0.4


--===============0666029652476357628==--


Content-Type: multipart/mixed; boundary="===============6551667836642034880=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 02/16] emulator: Add ofono_emulator and emulator
Date: Thu, 13 May 2010 18:02:25 +0800
Message-ID: <1273744959-3711-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6551667836642034880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It implements the emulator manager to create or destroy emulators. The
type of emulator can be DUN, HFP AG or SPP.
---
 Makefile.am        |    6 +-
 include/dbus.h     |    2 +
 include/emulator.h |   41 ++++++
 src/emulator.c     |  355 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |   10 ++
 5 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 include/emulator.h
 create mode 100644 src/emulator.c

diff --git a/Makefile.am b/Makefile.am
index 463e52e..707c622 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,7 +12,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
-			include/radio-settings.h include/stk.h
+			include/radio-settings.h include/stk.h \
+			include/emulator.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -259,7 +260,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
-			src/radio-settings.c src/stkutil.h src/stkutil.c
+			src/radio-settings.c src/stkutil.h src/stkutil.c \
+			src/emulator.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/dbus.h b/include/dbus.h
index 5bf0505..948bec5 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -47,6 +47,8 @@ extern "C" {
 #define OFONO_SMS_MANAGER_INTERFACE "org.ofono.SmsManager"
 #define OFONO_VOICECALL_INTERFACE "org.ofono.VoiceCall"
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
+#define OFONO_EMULATOR_INTERFACE "org.ofono.Emulator"
+#define OFONO_EMULATOR_MANAGER_INTERFACE "org.ofono.EmulatorManager"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/include/emulator.h b/include/emulator.h
new file mode 100644
index 0000000..c3bdaa9
--- /dev/null
+++ b/include/emulator.h
@@ -0,0 +1,41 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_EMULATOR_H
+#define __OFONO_EMULATOR_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_emulator;
+
+void ofono_emulator_register(struct ofono_emulator *emulator);
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem);
+void ofono_emulator_remove(struct ofono_emulator *emulator);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
diff --git a/src/emulator.c b/src/emulator.c
new file mode 100644
index 0000000..ef8fe70
--- /dev/null
+++ b/src/emulator.c
@@ -0,0 +1,355 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <time.h>
+#include <errno.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "common.h"
+
+#include "gatserver.h"
+
+#define MAX_EMULATOR_NUMS 3
+
+struct ofono_emulator {
+	unsigned int emulator_ids;
+	GSList *emulator_list;
+	struct ofono_atom *atom;
+};
+
+struct emulator {
+	struct ofono_emulator *oe;
+	unsigned int id;
+	enum ofono_emulator_type type;
+	GAtServer *server;
+	unsigned int timeout_source;
+};
+
+static void emulator_dbus_unregister(void *data, void *user_data);
+
+static unsigned int emulator_next_id(struct ofono_emulator *oe)
+{
+	unsigned int i;
+
+	for (i =3D 1; i < sizeof(oe->emulator_ids) * 8; i++) {
+		if (oe->emulator_ids & (0x1 << i))
+			continue;
+
+		oe->emulator_ids |=3D (0x1 << i);
+
+		return i;
+	}
+
+	return 0;
+}
+
+static void emulator_release_id(struct ofono_emulator *oe, int id)
+{
+	oe->emulator_ids &=3D ~(0x1 << id);
+}
+
+static enum ofono_emulator_type emulator_str_to_type(const char *type)
+{
+	if (!strcmp(type, "DUN"))
+		return OFONO_EMULATOR_TYPE_DUN;
+	else if (!strcmp(type, "HFP AG"))
+		return OFONO_EMULATOR_TYPE_HFPAG;
+	else if (!strcmp(type, "SPP"))
+		return OFONO_EMULATOR_TYPE_SPP;
+
+	return OFONO_EMULATOR_TYPE_NONE;
+}
+
+static const char *emulator_build_path(const struct ofono_emulator *oe,
+					const struct emulator *e)
+{
+	static char path[256];
+
+	snprintf(path, sizeof(path), "%s/emulator%02d",
+			__ofono_atom_get_path(oe->atom), e->id);
+
+	return path;
+}
+
+static void emulator_remove(void *data)
+{
+	struct emulator *e =3D data;
+	struct ofono_emulator *oe =3D e->oe;
+	GAtServer *server =3D e->server;
+
+	oe->emulator_list =3D g_slist_remove(oe->emulator_list, e);
+	emulator_release_id(oe, e->id);
+
+	g_at_server_shutdown(server);
+	g_at_server_unref(server);
+	server =3D NULL;
+
+	g_free(e);
+	e =3D NULL;
+}
+
+static struct emulator *emulator_create(struct ofono_emulator *oe,
+					enum ofono_emulator_type type,
+					int fd)
+{
+	struct emulator *e;
+	GAtServer *server;
+	GIOChannel *channel;
+
+	if (fd <=3D 0)
+		return NULL;
+
+	channel =3D g_io_channel_unix_new(fd);
+
+	server =3D g_at_server_new(channel);
+	if (!server)
+		goto error;
+
+	e =3D g_try_new0(struct emulator, 1);
+	if (!e)
+		goto error;
+
+	e->oe =3D oe;
+	e->id =3D emulator_next_id(oe);
+	e->type =3D type;
+	e->server =3D server;
+
+	oe->emulator_list =3D g_slist_prepend(oe->emulator_list, e);
+
+	g_io_channel_unref(channel);
+
+	return e;
+
+error:
+	if (channel) {
+		g_io_channel_shutdown(channel, FALSE, NULL);
+		g_io_channel_unref(channel);
+	}
+
+	if (server) {
+		g_at_server_shutdown(server);
+		g_at_server_unref(server);
+	}
+
+	g_free(e);
+
+	return NULL;
+}
+
+static gboolean real_destroy(void *data)
+{
+	struct emulator *e =3D data;
+
+	e->timeout_source =3D 0;
+
+	emulator_dbus_unregister(e, NULL);
+
+	return FALSE;
+}
+
+static DBusMessage *emulator_destroy(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct emulator *e =3D data;
+	DBusMessage *reply;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	e->timeout_source =3D g_timeout_add_seconds(1, real_destroy, e);
+
+	return reply;
+}
+
+static GDBusMethodTable emulator_methods[] =3D {
+	{ "Destroy",		"",	"",		emulator_destroy },
+	{ }
+};
+
+static GDBusSignalTable emulator_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+};
+
+static void emulator_dbus_unregister(void *data, void *user_data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct emulator *e =3D data;
+	struct ofono_emulator *oe =3D e->oe;
+	const char *path;
+
+	if (e->timeout_source)
+		g_source_remove(e->timeout_source);
+
+	path =3D emulator_build_path(oe, e);
+
+	g_dbus_unregister_interface(conn, path, OFONO_EMULATOR_INTERFACE);
+
+	return;
+}
+
+static gboolean emulator_dbus_register(struct ofono_emulator *oe,
+						struct emulator *e)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D emulator_build_path(oe, e);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_EMULATOR_INTERFACE,
+					emulator_methods, emulator_signals,
+					NULL, e, emulator_remove)) {
+		ofono_error("Could not create emulator %s", path);
+		emulator_remove(e);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static DBusMessage *manager_create(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	DBusMessage *reply;
+	struct ofono_emulator *oe =3D data;
+	struct emulator *e;
+	enum ofono_emulator_type type;
+	const char *type_str, *path;
+	int fd;
+
+	if (!oe)
+		return FALSE;
+
+	if (g_slist_length(oe->emulator_list) >=3D MAX_EMULATOR_NUMS)
+		return __ofono_error_failed(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &type_str,
+					DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	type =3D emulator_str_to_type(type_str);
+	if (type =3D=3D OFONO_EMULATOR_TYPE_NONE)
+		return __ofono_error_invalid_args(msg);
+
+	e =3D emulator_create(oe, type, fd);
+	if (!e)
+		return __ofono_error_failed(msg);
+
+	if (!emulator_dbus_register(oe, e))
+		return __ofono_error_failed(msg);
+
+	reply =3D dbus_message_new_method_return(msg);
+	path =3D emulator_build_path(oe, e);
+	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+	emit_emulator_list_changed(oe);
+
+	return reply;
+}
+
+static GDBusMethodTable emulator_manager_methods[] =3D {
+	{ "Create",		"sh",	"",	manager_create },
+	{ }
+};
+
+static GDBusSignalTable emulator_manager_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+};
+
+static void emulator_remove_all(struct ofono_atom *atom)
+{
+	struct ofono_emulator *oe =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (oe =3D=3D NULL)
+		return;
+
+	if (oe->emulator_list) {
+		g_slist_foreach(oe->emulator_list, emulator_dbus_unregister,
+						NULL);
+		g_slist_free(oe->emulator_list);
+	}
+
+	g_free(oe);
+}
+
+static void ofono_emulator_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	ofono_modem_remove_interface(modem, OFONO_EMULATOR_MANAGER_INTERFACE);
+
+	g_dbus_unregister_interface(conn, path,
+					OFONO_EMULATOR_MANAGER_INTERFACE);
+}
+
+void ofono_emulator_register(struct ofono_emulator *oe)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(oe->atom);
+	const char *path =3D __ofono_atom_get_path(oe->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_EMULATOR_MANAGER_INTERFACE,
+					emulator_manager_methods,
+					emulator_manager_signals,
+					NULL, oe, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_EMULATOR_MANAGER_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_EMULATOR_MANAGER_INTERFACE);
+
+	__ofono_atom_register(oe->atom, ofono_emulator_unregister);
+}
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem)
+{
+	struct ofono_emulator *oe;
+
+	oe =3D g_try_new0(struct ofono_emulator, 1);
+	if (oe =3D=3D NULL)
+		return NULL;
+
+	oe->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_EMULATOR,
+						emulator_remove_all, oe);
+
+	return oe;
+}
+
+void ofono_emulator_remove(struct ofono_emulator *oe)
+{
+	__ofono_atom_free(oe->atom);
+}
diff --git a/src/ofono.h b/src/ofono.h
index f93760e..4995830 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -116,6 +116,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
 	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
 	OFONO_ATOM_TYPE_STK =3D 19,
+	OFONO_ATOM_TYPE_EMULATOR =3D 20,
 };
 =

 enum ofono_atom_watch_condition {
@@ -265,3 +266,12 @@ struct sms;
 =

 void __ofono_message_waiting_mwi(struct ofono_message_waiting *mw,
 				struct sms *sms, gboolean *out_discard);
+
+#include <ofono/emulator.h>
+
+enum ofono_emulator_type {
+	OFONO_EMULATOR_TYPE_NONE =3D 0,
+	OFONO_EMULATOR_TYPE_DUN,
+	OFONO_EMULATOR_TYPE_HFPAG,
+	OFONO_EMULATOR_TYPE_SPP,
+};
-- =

1.6.3.3


--===============6551667836642034880==--


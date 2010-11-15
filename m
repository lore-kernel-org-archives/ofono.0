Content-Type: multipart/mixed; boundary="===============8724566926792091483=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 4/5] voicecall: add call counters
Date: Mon, 15 Nov 2010 13:50:25 +0200
Message-ID: <68a1a9e9cf371358b6c100b372ae93a50e095bd7.1289819191.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8724566926792091483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/callcounters.c |  388 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 388 insertions(+), 0 deletions(-)
 create mode 100644 src/callcounters.c

diff --git a/src/callcounters.c b/src/callcounters.c
new file mode 100644
index 0000000..a1306e5
--- /dev/null
+++ b/src/callcounters.c
@@ -0,0 +1,388 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+#include <time.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "storage.h"
+
+#define CC_TIMEOUT		10000
+#define CC_STORE		"callcounters"
+#define CC_GROUP		"CallCounters"
+#define CC_INTERFACE	"org.ofono.CallCounters"
+
+struct call_item {
+	unsigned int id;
+	int dir;
+	time_t start_time;
+};
+
+struct call_counters {
+	struct ofono_history_context *context;
+	const char *imsi;
+	GKeyFile *file;
+	time_t ibase;
+	time_t obase;
+	time_t incoming;
+	time_t outgoing;
+	gint timeout_source;
+	GSList *calls;
+};
+
+static time_t cc_time()
+{
+	struct timespec now;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	return now.tv_sec;
+}
+
+static gboolean cc_no_calls(struct call_counters *cc)
+{
+	return cc->calls =3D=3D NULL;
+}
+
+static struct call_item *cc_find_ci(struct call_counters *cc, unsigned int=
 id)
+{
+	struct call_item *ci;
+	GSList *l;
+
+	for (l =3D cc->calls; l; l =3D l->next) {
+		ci =3D l->data;
+		if (ci->id =3D=3D id)
+			return ci;
+	}
+
+	return NULL;
+}
+
+static void cc_load(struct call_counters *cc)
+{
+	struct ofono_modem *modem =3D cc->context->modem;
+	struct ofono_atom *atom;
+	struct ofono_sim *sim;
+	GError *error1 =3D NULL, *error2 =3D NULL;
+
+	cc->incoming =3D cc->ibase =3D 0;
+	cc->outgoing =3D cc->obase =3D 0;
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	sim =3D __ofono_atom_get_data(atom);
+
+	cc->imsi =3D ofono_sim_get_imsi(sim);
+	if (cc->imsi =3D=3D NULL)
+		return;
+
+	cc->file =3D storage_open(cc->imsi, CC_STORE);
+	if (cc->file =3D=3D NULL)
+		return;
+
+	cc->incoming =3D g_key_file_get_integer(cc->file, CC_GROUP,
+						"Incoming", &error1);
+
+	if (error1) {
+		g_key_file_set_integer(cc->file, CC_GROUP,
+					"Incoming", cc->incoming);
+		storage_sync(cc->imsi, CC_STORE, cc->file);
+	}
+
+	cc->ibase =3D cc->incoming;
+
+	cc->outgoing =3D g_key_file_get_integer(cc->file, CC_GROUP,
+						"Outgoing", &error2);
+
+	if (error2) {
+		g_key_file_set_integer(cc->file, CC_GROUP,
+					"Outgoing", cc->outgoing);
+	}
+
+	cc->obase =3D cc->outgoing;
+
+	if (error1 !=3D NULL || error2 !=3D NULL)
+		storage_sync(cc->imsi, CC_STORE, cc->file);
+}
+
+static void cc_save(struct call_counters *cc)
+{
+	if (cc->file =3D=3D NULL)
+		return;
+
+	g_key_file_set_integer(cc->file, CC_GROUP,
+				"Incoming", cc->incoming);
+	g_key_file_set_integer(cc->file, CC_GROUP,
+				"Outgoing", cc->outgoing);
+	storage_sync(cc->imsi, CC_STORE, cc->file);
+}
+
+static void cc_close(struct call_counters *cc)
+{
+	if (cc->file)
+		storage_close(cc->imsi, CC_STORE, cc->file, TRUE);
+
+	cc->file =3D NULL;
+}
+
+static void cc_update(struct call_counters *cc, struct call_item *ci)
+{
+	time_t now =3D cc_time();
+	time_t idiff =3D 0, odiff =3D 0;
+	struct call_item *lci;
+	GSList *l;
+
+	for (l =3D cc->calls; l; l =3D l->next) {
+		lci =3D l->data;
+		if (lci->dir =3D=3D CALL_DIRECTION_MOBILE_ORIGINATED) {
+			if (lci !=3D ci)
+				odiff +=3D now - lci->start_time;
+			else
+				cc->obase +=3D now - lci->start_time;
+		} else {
+			if (lci !=3D ci)
+				idiff +=3D now - lci->start_time;
+			else
+				cc->ibase +=3D now - lci->start_time;
+		}
+	}
+
+	cc->outgoing =3D cc->obase + odiff;
+	cc->incoming =3D cc->ibase + idiff;
+
+	cc_save(cc);
+}
+
+static gboolean cc_timeout(gpointer user_data)
+{
+	struct call_counters *cc =3D user_data;
+	cc_update(cc, NULL);
+	return TRUE;
+}
+
+static DBusMessage *cc_dbus_get(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct call_counters *cc =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	if (cc_no_calls(cc)) {
+		cc_load(cc);
+		cc_close(cc);
+	} else {
+		cc_update(cc, NULL);
+	}
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	ofono_dbus_dict_append(&dict, "Incoming", DBUS_TYPE_UINT32,
+				&cc->incoming);
+	ofono_dbus_dict_append(&dict, "Outgoing", DBUS_TYPE_UINT32,
+				&cc->outgoing);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *cc_dbus_clear(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct call_counters *cc =3D data;
+	DBusMessage *reply;
+
+	if (cc_no_calls(cc)) {
+		cc_load(cc);
+		cc->incoming =3D cc->ibase =3D 0;
+		cc->outgoing =3D cc->obase =3D 0;
+		cc_save(cc);
+		cc_close(cc);
+		reply =3D dbus_message_new_method_return(msg);
+	} else {
+		reply =3D __ofono_error_failed(msg);
+	}
+
+	return reply;
+}
+
+static GDBusMethodTable cc_methods[] =3D {
+	{"Get",   "", "a{sv}", cc_dbus_get},
+	{"Clear", "", "",      cc_dbus_clear},
+	{ }
+};
+
+static void cc_dbus_register(struct call_counters *cc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(cc->context->modem);
+
+	if (!g_dbus_register_interface(conn, path,
+					CC_INTERFACE,
+					cc_methods, NULL, NULL,
+					cc, NULL)) {
+		ofono_error("Could not create %s interface", CC_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(cc->context->modem, CC_INTERFACE);
+}
+
+static gboolean cc_dbus_unregister(struct call_counters *cc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(cc->context->modem);
+
+	ofono_modem_remove_interface(cc->context->modem, CC_INTERFACE);
+
+	return g_dbus_unregister_interface(conn, path, CC_INTERFACE);
+}
+
+static int cc_probe(struct ofono_history_context *context)
+{
+	struct call_counters *cc;
+
+	ofono_debug("Call Counters probe for modem: %p", context->modem);
+
+	cc =3D g_try_new0(struct call_counters, 1);
+	if (cc =3D=3D NULL)
+		return -1;
+
+	context->data =3D cc;
+	cc->context =3D context;
+	cc_dbus_register(cc);
+
+	return 0;
+}
+
+static void cc_remove(struct ofono_history_context *context)
+{
+	struct call_counters *cc =3D context->data;
+
+	ofono_debug("Call Counters remove for modem: %p", context->modem);
+
+	cc_dbus_unregister(cc);
+
+	if (cc->timeout_source !=3D 0)
+		g_source_remove(cc->timeout_source);
+
+	cc_update(cc, NULL);
+	g_slist_free(cc->calls);
+
+	if (cc->file)
+		storage_close(cc->imsi, CC_STORE, cc->file, TRUE);
+
+	g_free(context->data);
+}
+
+static void cc_call_started(struct ofono_history_context *context,
+				const struct ofono_call *call, time_t start)
+{
+	time_t now =3D cc_time();
+	struct call_counters *cc =3D context->data;
+	struct call_item *ci;
+
+	ofono_debug("Call started on modem: %p", context->modem);
+
+	if (call->type !=3D 0)
+		return;
+
+	ci =3D g_try_new0(struct call_item, 1);
+	if (ci =3D=3D NULL)
+		return;
+
+	if (cc_no_calls(cc))
+		cc_load(context->data);
+
+	ci->id =3D call->id;
+	ci->dir =3D call->direction;
+	ci->start_time =3D now;
+	cc->calls =3D g_slist_append(cc->calls, ci);
+
+	if (cc->timeout_source =3D=3D 0)
+		cc->timeout_source =3D g_timeout_add(CC_TIMEOUT, cc_timeout, cc);
+}
+
+static void cc_call_ended(struct ofono_history_context *context,
+				const struct ofono_call *call,
+				time_t start, time_t end)
+{
+	struct call_counters *cc =3D context->data;
+	struct call_item *ci =3D cc_find_ci(cc, call->id);
+
+	ofono_debug("Call ended on modem: %p", context->modem);
+
+	if (call->type !=3D 0)
+		return;
+
+	if (ci =3D=3D NULL)
+		return;
+
+	cc_update(cc, ci);
+	cc->calls =3D g_slist_remove(cc->calls, ci);
+
+	if (cc_no_calls(cc)) {
+		if (cc->timeout_source !=3D 0)
+			g_source_remove(cc->timeout_source);
+
+		cc->timeout_source =3D 0;
+
+		if (cc->file)
+			storage_close(cc->imsi, CC_STORE, cc->file, TRUE);
+
+		cc->file =3D NULL;
+	}
+}
+
+static struct ofono_history_driver cc_driver =3D {
+	.name =3D "Call Counters",
+	.probe =3D cc_probe,
+	.remove =3D cc_remove,
+	.call_started =3D cc_call_started,
+	.call_ended =3D cc_call_ended,
+};
+
+static int cc_init(void)
+{
+	return ofono_history_driver_register(&cc_driver);
+}
+
+static void cc_exit(void)
+{
+	ofono_history_driver_unregister(&cc_driver);
+}
+
+OFONO_PLUGIN_DEFINE(cc, "Call Counters plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			cc_init, cc_exit)
-- =

1.7.0.4


--===============8724566926792091483==--


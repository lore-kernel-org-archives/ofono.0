Content-Type: multipart/mixed; boundary="===============5463861566752205686=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] plugins: Add allowed APN list
Date: Wed, 20 Apr 2016 08:58:10 +0530
Message-ID: <1461122890-7163-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5463861566752205686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                     |   9 +-
 doc/allowed-apns-api.txt        |  17 +++
 plugins/allowed-apns.c          | 272 ++++++++++++++++++++++++++++++++++++=
++++
 src/simutil.c                   |   1 +
 test/list-allowed-access-points |  25 ++++
 5 files changed, 322 insertions(+), 2 deletions(-)
 create mode 100644 doc/allowed-apns-api.txt
 create mode 100644 plugins/allowed-apns.c
 create mode 100755 test/list-allowed-access-points

diff --git a/Makefile.am b/Makefile.am
index 5cd9766..5215b2e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -572,6 +572,9 @@ builtin_sources +=3D plugins/smart-messaging.c
 builtin_modules +=3D push_notification
 builtin_sources +=3D plugins/push-notification.c
 =

+builtin_modules +=3D allowed_apns
+builtin_sources +=3D plugins/allowed-apns.c
+
 sbin_PROGRAMS =3D src/ofonod
 =

 src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sources) src/ofono.ver=
 \
@@ -646,7 +649,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/location-reporting-api.txt \
 			doc/certification.txt doc/siri-api.txt \
 			doc/telit-modem.txt \
-			doc/networkmonitor-api.txt
+			doc/networkmonitor-api.txt \
+			doc/allowed-apns-api.txt
 =

 =

 test_scripts =3D test/backtrace \
@@ -745,7 +749,8 @@ test_scripts =3D test/backtrace \
 		test/register-operator \
 		test/set-sms-smsc \
 		test/set-sms-bearer \
-		test/get-serving-cell-info
+		test/get-serving-cell-info \
+		test/list-allowed-access-points
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/doc/allowed-apns-api.txt b/doc/allowed-apns-api.txt
new file mode 100644
index 0000000..6bc95d0
--- /dev/null
+++ b/doc/allowed-apns-api.txt
@@ -0,0 +1,17 @@
+Allowed APNs hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Service		org.ofono
+Interface	org.ofono.AllowedAccessPoints
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		array{string} GetAllowedAccessPoints()
+
+			Get the list of allowed access points provided
+			in the SIM card.
+
+			This method returns an array of strings which
+			contains a list of Access Point Names supported
+			by network provider. Returns with an error if
+			SIM reading failed or an empty list if there
+			are no access points listed on the SIM.
diff --git a/plugins/allowed-apns.c b/plugins/allowed-apns.c
new file mode 100644
index 0000000..77ede86
--- /dev/null
+++ b/plugins/allowed-apns.c
@@ -0,0 +1,272 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2016  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <ofono.h>
+#include <simutil.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+#include <ofono/dbus.h>
+#include <gdbus.h>
+
+#define SIM_EFACL_FILEID	0x6f57
+
+#define ALLOWED_ACCESS_POINTS_INTERFACE "org.ofono.AllowedAccessPoints"
+
+guint modemwatch_id;
+
+struct allowed_apns_ctx {
+	guint simwatch_id;
+	guint atomwatch_id;
+	struct ofono_modem *modem;
+	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
+	DBusMessage *pending;
+	DBusMessage *reply;
+};
+
+GSList *context_list;
+
+static void context_destroy(gpointer data)
+{
+	struct allowed_apns_ctx *ctx =3D data;
+
+	if (ctx->simwatch_id)
+		ofono_sim_remove_state_watch(ctx->sim,
+					ctx->simwatch_id);
+
+	if (ctx->atomwatch_id)
+		__ofono_modem_remove_atom_watch(ctx->modem,
+					ctx->atomwatch_id);
+
+	if (ctx->sim_context)
+		ofono_sim_context_free(ctx->sim_context);
+
+	context_list =3D g_slist_remove(context_list, ctx);
+
+	g_free(ctx);
+}
+
+static void sim_acl_read_cb(int ok, int total_length, int record,
+			const unsigned char *data, int record_length,
+			void *userdata)
+{
+	struct allowed_apns_ctx *ctx =3D userdata;
+	DBusMessage *reply =3D ctx->reply;
+	DBusMessageIter iter;
+	DBusMessageIter array;
+	struct simple_tlv_iter tlv_iter;
+	char *apn;
+
+	if (!ok) {
+		reply =3D __ofono_error_failed(ctx->pending);
+		__ofono_dbus_pending_reply(&ctx->pending, reply);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(ctx->pending);
+	if (reply =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING,
+					&array);
+
+	if (data[0] =3D=3D 0)
+		goto done;
+
+	simple_tlv_iter_init(&tlv_iter, &data[1], total_length - 1);
+
+	while (simple_tlv_iter_next(&tlv_iter)) {
+		if (simple_tlv_iter_get_tag(&tlv_iter) !=3D 0xDD)
+			continue;
+
+		apn =3D g_strndup(
+			(char *) simple_tlv_iter_get_data(&tlv_iter),
+			simple_tlv_iter_get_length(&tlv_iter));
+
+		dbus_message_iter_append_basic(&array,
+					DBUS_TYPE_STRING,
+					&apn);
+
+		g_free(apn);
+	}
+
+done:
+	dbus_message_iter_close_container(&iter, &array);
+
+	__ofono_dbus_pending_reply(&ctx->pending, reply);
+}
+
+static DBusMessage *get_allowed_apns(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct allowed_apns_ctx *ctx =3D data;
+
+	if (ctx->pending)
+		return __ofono_error_busy(msg);
+
+	ctx->pending =3D dbus_message_ref(msg);
+
+	ofono_sim_read(ctx->sim_context, SIM_EFACL_FILEID,
+		OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		sim_acl_read_cb, ctx);
+
+	return NULL;
+}
+
+static const GDBusMethodTable allowed_apns_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("GetAllowedAccessPoints",
+			NULL, GDBUS_ARGS({ "apnlist", "as" }),
+			get_allowed_apns) },
+	{ }
+};
+
+static void sim_state_watch(enum ofono_sim_state new_state, void *data)
+{
+	struct allowed_apns_ctx *ctx =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		g_dbus_unregister_interface(conn,
+				ofono_modem_get_path(ctx->modem),
+				ALLOWED_ACCESS_POINTS_INTERFACE);
+
+		ofono_modem_remove_interface(ctx->modem,
+				ALLOWED_ACCESS_POINTS_INTERFACE);
+
+		return;
+	}
+
+	if (!g_dbus_register_interface(conn,
+				ofono_modem_get_path(ctx->modem),
+				ALLOWED_ACCESS_POINTS_INTERFACE,
+				allowed_apns_methods, NULL, NULL,
+				ctx, NULL)) {
+		ofono_error("Cannot create %s Interface\n",
+			ALLOWED_ACCESS_POINTS_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(ctx->modem,
+			ALLOWED_ACCESS_POINTS_INTERFACE);
+}
+
+static void sim_watch(struct ofono_atom *atom,
+		enum ofono_atom_watch_condition cond,
+		void *data)
+{
+	struct allowed_apns_ctx *ctx =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		if (ctx->sim_context)
+			ofono_sim_context_free(ctx->sim_context);
+
+		return;
+	}
+
+	ctx->sim =3D __ofono_atom_get_data(atom);
+
+	ctx->sim_context =3D ofono_sim_context_create(ctx->sim);
+
+	ctx->simwatch_id =3D ofono_sim_add_state_watch(ctx->sim,
+						sim_state_watch,
+						ctx, NULL);
+}
+
+static gint context_list_modem_compare(gconstpointer data1,
+				gconstpointer data2)
+{
+	const struct allowed_apns_ctx *ctx =3D data1;
+	const struct ofono_modem *modem =3D data2;
+	return (ctx->modem =3D=3D modem);
+}
+
+static void modem_watch(struct ofono_modem *modem,
+		gboolean added, void *userdata)
+{
+	struct allowed_apns_ctx *ctx;
+	GSList *l;
+
+	if (added =3D=3D FALSE) {
+		l =3D g_slist_find_custom(context_list,
+				modem, context_list_modem_compare);
+
+		if (l) {
+			ctx =3D l->data;
+			context_destroy(ctx);
+			context_list =3D g_slist_delete_link(context_list, l);
+		}
+
+		return;
+	}
+
+	ctx =3D g_try_new0(struct allowed_apns_ctx, 1);
+	if (ctx =3D=3D NULL)
+		return;
+
+	context_list =3D g_slist_prepend(context_list, ctx);
+
+	ctx->modem =3D modem;
+
+	ctx->atomwatch_id =3D __ofono_modem_add_atom_watch(ctx->modem,
+						OFONO_ATOM_TYPE_SIM,
+						sim_watch, ctx, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *userdata)
+{
+	modem_watch(modem, TRUE, userdata);
+}
+
+static int allowed_apns_init(void)
+{
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
+
+	__ofono_modem_foreach(call_modemwatch, NULL);
+
+	return 0;
+}
+
+static void allowed_apns_exit(void)
+{
+	__ofono_modemwatch_remove(modemwatch_id);
+
+	g_slist_free_full(context_list, context_destroy);
+}
+
+OFONO_PLUGIN_DEFINE(allowed_apns, "Plugin to read EFACL from SIM",
+		VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+		allowed_apns_init, allowed_apns_exit)
diff --git a/src/simutil.c b/src/simutil.c
index a7745ae..5f8c8b8 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -95,6 +95,7 @@ static struct sim_ef_info ef_db[] =3D {
 {	0x6F4D, 0x7F20, 0x7FFF, EF, RECORD, 0,		PIN,	PIN2	},
 {	0x6F50, 0x7F20, 0x7FFF, EF, BINARY, 0,		PIN,	PIN	},
 {	0x6F56, 0x0000, 0x7FFF, EF, BINARY, 0,		PIN,	PIN2	},
+{	0x6F57,	0x7F20,	0x7FFF,	EF, BINARY, 0,		PIN,	PIN2	},
 {	0x6FAD, 0x7F20, 0x7FFF, EF, BINARY, 0,		ALW,	ADM	},
 {	0x6FAE, 0x7F20, 0x0000, EF, BINARY, 1,		ALW,	ADM	},
 {	0x6FB7, 0x7F20, 0x7FFF, EF, BINARY, 0,		ALW,	ADM	},
diff --git a/test/list-allowed-access-points b/test/list-allowed-access-poi=
nts
new file mode 100755
index 0000000..c7bb50c
--- /dev/null
+++ b/test/list-allowed-access-points
@@ -0,0 +1,25 @@
+#!/usr/bin/python3
+
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+for path, properties in modems:
+	if "org.ofono.AllowedAccessPoints" not in properties["Interfaces"]:
+		continue
+
+	allowedAccessPoints =3D dbus.Interface(bus.get_object('org.ofono',
+					path), 'org.ofono.AllowedAccessPoints')
+
+	apns =3D allowedAccessPoints.GetAllowedAccessPoints()
+
+	print("Allowed Access Points for [ %s ]" % (path))
+	for apn in apns:
+		print("    [ %s]" % (apn))
+
+print("")
-- =

1.9.1


--===============5463861566752205686==--


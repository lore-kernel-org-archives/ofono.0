Content-Type: multipart/mixed; boundary="===============5501687587713315512=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/4] gprs: Add DBus method to reset contexts
Date: Mon, 18 May 2015 08:47:06 +0200
Message-ID: <1431931629-7771-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5501687587713315512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add DBus method that removes the current contexts and re-provisions
using the APN database.
---
 src/gprs.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 118 insertions(+), 24 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 05ab499..64fa6f1 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -149,6 +149,8 @@ struct pri_context {
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
+static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
+				const char *mnc, const char *spn);
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -1885,6 +1887,36 @@ static struct pri_context *add_context(struct ofono_=
gprs *gprs,
 	return context;
 }
 =

+static void send_context_added_signal(struct ofono_gprs *gprs,
+					struct pri_context *context,
+					DBusConnection *conn)
+{
+	const char *path;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	path =3D __ofono_atom_get_path(gprs->atom);
+	signal =3D dbus_message_new_signal(path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					"ContextAdded");
+	if (!signal)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	path =3D context->path;
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	append_context_properties(context, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(conn, signal);
+}
+
 static DBusMessage *gprs_add_context(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1894,7 +1926,6 @@ static DBusMessage *gprs_add_context(DBusConnection *=
conn,
 	const char *name;
 	const char *path;
 	enum ofono_gprs_context_type type;
-	DBusMessage *signal;
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
 					DBUS_TYPE_INVALID))
@@ -1916,29 +1947,7 @@ static DBusMessage *gprs_add_context(DBusConnection =
*conn,
 	g_dbus_send_reply(conn, msg, DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID);
 =

-	path =3D __ofono_atom_get_path(gprs->atom);
-	signal =3D dbus_message_new_signal(path,
-					OFONO_CONNECTION_MANAGER_INTERFACE,
-					"ContextAdded");
-
-	if (signal) {
-		DBusMessageIter iter;
-		DBusMessageIter dict;
-
-		dbus_message_iter_init_append(signal, &iter);
-
-		path =3D context->path;
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
-						&path);
-
-		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-		append_context_properties(context, &dict);
-		dbus_message_iter_close_container(&iter, &dict);
-
-		g_dbus_send_message(conn, signal);
-	}
+	send_context_added_signal(gprs, context, conn);
 =

 	return NULL;
 }
@@ -2173,6 +2182,89 @@ static DBusMessage *gprs_get_contexts(DBusConnection=
 *conn,
 	return reply;
 }
 =

+static void remove_non_active_context(struct ofono_gprs *gprs,
+				struct pri_context *ctx, DBusConnection *conn)
+{
+	char *path;
+	const char *atompath;
+
+	if (gprs->settings) {
+		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+
+	/* Make a backup copy of path for signal emission below */
+	path =3D g_strdup(ctx->path);
+
+	context_dbus_unregister(ctx);
+	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
+
+	atompath =3D __ofono_atom_get_path(gprs->atom);
+	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
+				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+	g_free(path);
+}
+
+static DBusMessage *gprs_reset_contexts(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_gprs *gprs =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	DBusMessage *reply;
+	GSList *l;
+
+	if (gprs->pending)
+		return __ofono_error_busy(msg);
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->pending)
+			return __ofono_error_busy(msg);
+	}
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (gprs->powered)
+		return __ofono_error_not_allowed(msg);
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->active)
+			return __ofono_error_not_allowed(msg);
+	}
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	/* Remove first the current contexts, re-provision after */
+
+	while (gprs->contexts !=3D NULL) {
+		struct pri_context *ctx =3D gprs->contexts->data;
+		remove_non_active_context(gprs, ctx, conn);
+	}
+
+	gprs->last_context_id =3D 0;
+
+	provision_contexts(gprs, ofono_sim_get_mcc(sim),
+				ofono_sim_get_mnc(sim), ofono_sim_get_spn(sim));
+
+	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
+		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+		send_context_added_signal(gprs, ctx, conn);
+	}
+
+	return reply;
+}
+
 static const GDBusMethodTable manager_methods[] =3D {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -2192,6 +2284,8 @@ static const GDBusMethodTable manager_methods[] =3D {
 	{ GDBUS_METHOD("GetContexts", NULL,
 			GDBUS_ARGS({ "contexts_with_properties", "a(oa{sv})" }),
 			gprs_get_contexts) },
+	{ GDBUS_ASYNC_METHOD("ResetContexts", NULL, NULL,
+			gprs_reset_contexts) },
 	{ }
 };
 =

-- =

2.1.4


--===============5501687587713315512==--


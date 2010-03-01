Content-Type: multipart/mixed; boundary="===============0749764462649832998=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 3/4] Fix calling watch callbacks after it has been removed
Date: Mon, 01 Mar 2010 18:09:47 +0200
Message-ID: <2d5a2c101003010809k45bfeb03u8d74cc5b36ad45cc@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0749764462649832998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pending call should be removed if the watch is removed since the
application no longer expect that to be reached and may already freed the
data associated with it.
---
 gdbus/watch.c |   79 +++++++++++++++++++++++++++++++++++------------------=
---
 1 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index a1acb72..c0dcc93 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -43,11 +43,21 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,
 static guint listener_id =3D 0;
 static GSList *listeners =3D NULL;

+struct service_data {
+	DBusConnection *conn;
+	DBusPendingCall *call;
+	char *name;
+	const char *owner;
+	guint id;
+	struct filter_callback *callback;
+};
+
 struct filter_callback {
 	GDBusWatchFunction conn_func;
 	GDBusWatchFunction disc_func;
 	GDBusSignalFunction signal_func;
 	GDBusDestroyFunction destroy_func;
+	struct service_data *data;
 	void *user_data;
 	guint id;
 };
@@ -302,7 +312,7 @@ static struct filter_callback *filter_data_add_callback(
 {
 	struct filter_callback *cb =3D NULL;

-	cb =3D g_new(struct filter_callback, 1);
+	cb =3D g_new0(struct filter_callback, 1);

 	cb->conn_func =3D connect;
 	cb->disc_func =3D disconnect;
@@ -319,6 +329,24 @@ static struct filter_callback *filter_data_add_callbac=
k(
 	return cb;
 }

+static void service_data_free(struct service_data *data)
+{
+	struct filter_callback *callback =3D data->callback;
+
+	dbus_connection_unref(data->conn);
+
+	if (data->call)
+		dbus_pending_call_unref(data->call);
+
+	if (data->id)
+		g_source_remove(data->id);
+
+	g_free(data->name);
+	g_free(data);
+
+	callback->data =3D NULL;
+}
+
 static gboolean filter_data_remove_callback(struct filter_data *data,
 						struct filter_callback *cb)
 {
@@ -327,6 +355,13 @@ static gboolean
filter_data_remove_callback(struct filter_data *data,
 	data->callbacks =3D g_slist_remove(data->callbacks, cb);
 	data->processed =3D g_slist_remove(data->processed, cb);

+	/* Cancel pending operations */
+	if (cb->data) {
+		if (cb->data->call)
+			dbus_pending_call_cancel(cb->data->call);
+		service_data_free(cb->data);
+	}
+
 	if (cb->destroy_func)
 		cb->destroy_func(cb->user_data);

@@ -515,28 +550,14 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }

-struct service_data {
-	DBusConnection *conn;
-	char *name;
-	const char *owner;
-	GDBusWatchFunction conn_func;
-	void *user_data;
-};
-
-static void service_data_free(struct service_data *data)
-{
-	dbus_connection_unref(data->conn);
-	g_free(data->name);
-	g_free(data);
-}
-
 static gboolean update_service(void *user_data)
 {
 	struct service_data *data =3D user_data;
+	struct filter_callback *cb =3D data->callback;

 	update_name_cache(data->name, data->owner);
-	if (data->conn_func)
-		data->conn_func(data->conn, data->user_data);
+	if (cb->conn_func)
+		cb->conn_func(data->conn, cb->user_data);

 	service_data_free(data);

@@ -575,11 +596,11 @@ done:
 	dbus_message_unref(reply);
 }

-static void check_service(DBusConnection *connection, const char *name,
-				GDBusWatchFunction connect, void *user_data)
+static void check_service(DBusConnection *connection,
+					const char *name,
+					struct filter_callback *callback)
 {
 	DBusMessage *message;
-	DBusPendingCall *call;
 	struct service_data *data;

 	data =3D g_try_malloc0(sizeof(*data));
@@ -590,12 +611,12 @@ static void check_service(DBusConnection
*connection, const char *name,

 	data->conn =3D dbus_connection_ref(connection);
 	data->name =3D g_strdup(name);
-	data->conn_func =3D connect;
-	data->user_data =3D user_data;
+	data->callback =3D callback;
+	callback->data =3D data;

 	data->owner =3D check_name_cache(name);
 	if (data->owner !=3D NULL) {
-		g_idle_add(update_service, data);
+		data->id =3D g_idle_add(update_service, data);
 		return;
 	}

@@ -611,21 +632,19 @@ static void check_service(DBusConnection
*connection, const char *name,
 							DBUS_TYPE_INVALID);

 	if (dbus_connection_send_with_reply(connection, message,
-							&call, -1) =3D=3D FALSE) {
+							&data->call, -1) =3D=3D FALSE) {
 		error("Failed to execute method call");
 		g_free(data);
 		goto done;
 	}

-	if (call =3D=3D NULL) {
+	if (data->call =3D=3D NULL) {
 		error("D-Bus connection not available");
 		g_free(data);
 		goto done;
 	}

-	dbus_pending_call_set_notify(call, service_reply, data, NULL);
-
-	dbus_pending_call_unref(call);
+	dbus_pending_call_set_notify(data->call, service_reply, data, NULL);

 done:
 	dbus_message_unref(message);
@@ -654,7 +673,7 @@ guint g_dbus_add_service_watch(DBusConnection
*connection, const char *name,
 		return 0;

 	if (connect)
-		check_service(connection, name, connect, user_data);
+		check_service(connection, name, cb);

 	return cb->id;
 }
-- =

1.6.3.3

-- =

Luiz Augusto von Dentz
Computer Engineer

--===============0749764462649832998==--


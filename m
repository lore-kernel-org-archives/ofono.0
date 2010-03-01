Content-Type: multipart/mixed; boundary="===============4851796515222148426=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 2/4] Fix signal watch when a service name is given
Date: Mon, 01 Mar 2010 18:08:47 +0200
Message-ID: <2d5a2c101003010808n77ab8d91ye5a6d62d11578dd1@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4851796515222148426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bus name should be resolved when adding a watch by service name since
messages do always come with sender set to owner's bus name, also it
should listen to owner updates since it can change without invalidating
the watch.
---
 gdbus/watch.c |  161 +++++++++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 128 insertions(+), 33 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index e85f288..a1acb72 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -55,19 +55,22 @@ struct filter_callback {
 struct filter_data {
 	DBusConnection *connection;
 	DBusHandleMessageFunction handle_func;
-	char *sender;
+	char *name;
+	char *owner;
 	char *path;
 	char *interface;
 	char *member;
 	char *argument;
 	GSList *callbacks;
 	GSList *processed;
+	guint name_watch;
 	gboolean lock;
 	gboolean registered;
 };

 static struct filter_data *filter_data_find(DBusConnection *connection,
-							const char *sender,
+							const char *name,
+							const char *owner,
 							const char *path,
 							const char *interface,
 							const char *member,
@@ -82,8 +85,12 @@ static struct filter_data
*filter_data_find(DBusConnection *connection,
 		if (connection !=3D data->connection)
 			continue;

-		if (sender && data->sender &&
-				g_str_equal(sender, data->sender) =3D=3D FALSE)
+		if (name && data->name &&
+				g_str_equal(name, data->name) =3D=3D FALSE)
+			continue;
+
+		if (owner && data->owner &&
+				g_str_equal(owner, data->owner) =3D=3D FALSE)
 			continue;

 		if (path && data->path &&
@@ -110,13 +117,15 @@ static struct filter_data
*filter_data_find(DBusConnection *connection,

 static void format_rule(struct filter_data *data, char *rule, size_t size)
 {
+	const char *sender;
 	int offset;

 	offset =3D snprintf(rule, size, "type=3D'signal'");
+	sender =3D data->name ? : data->owner;

-	if (data->sender)
+	if (sender)
 		offset +=3D snprintf(rule + offset, size - offset,
-				",sender=3D'%s'", data->sender);
+				",sender=3D'%s'", sender);
 	if (data->path)
 		offset +=3D snprintf(rule + offset, size - offset,
 				",path=3D'%s'", data->path);
@@ -183,8 +192,10 @@ static struct filter_data
*filter_data_get(DBusConnection *connection,
 					const char *argument)
 {
 	struct filter_data *data;
+	const char *name =3D NULL, *owner =3D NULL;

-	if (!filter_data_find(connection, NULL, NULL, NULL, NULL, NULL)) {
+	if (!filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
+				NULL)) {
 		if (!dbus_connection_add_filter(connection,
 					message_filter, NULL, NULL)) {
 			error("dbus_connection_add_filter() failed");
@@ -192,15 +203,25 @@ static struct filter_data
*filter_data_get(DBusConnection *connection,
 		}
 	}

-	data =3D filter_data_find(connection, sender, path, interface, member,
-					argument);
+	if (sender =3D=3D NULL)
+		goto proceed;
+
+	if (sender[0] =3D=3D ':')
+		owner =3D sender;
+	else
+		name =3D sender;
+
+proceed:
+	data =3D filter_data_find(connection, name, owner, path, interface,
+					member, argument);
 	if (data)
 		return data;

 	data =3D g_new0(struct filter_data, 1);

 	data->connection =3D dbus_connection_ref(connection);
-	data->sender =3D g_strdup(sender);
+	data->name =3D name ? g_strdup(name) : NULL;
+	data->owner =3D owner ? g_strdup(owner) : NULL;
 	data->path =3D g_strdup(path);
 	data->interface =3D g_strdup(interface);
 	data->member =3D g_strdup(member);
@@ -244,7 +265,9 @@ static void filter_data_free(struct filter_data *data)
 		g_free(l->data);

 	g_slist_free(data->callbacks);
-	g_free(data->sender);
+	g_dbus_remove_watch(data->connection, data->name_watch);
+	g_free(data->name);
+	g_free(data->owner);
 	g_free(data->path);
 	g_free(data->interface);
 	g_free(data->member);
@@ -322,7 +345,8 @@ static gboolean filter_data_remove_callback(struct
filter_data *data,
 	filter_data_free(data);

 	/* Remove filter if there are no listeners left for the connection */
-	data =3D filter_data_find(connection, NULL, NULL, NULL, NULL, NULL);
+	data =3D filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
+					NULL);
 	if (!data)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
@@ -359,6 +383,37 @@ static DBusHandlerResult
signal_filter(DBusConnection *connection,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }

+static void update_name_cache(const char *name, const char *owner)
+{
+	GSList *l;
+
+	for (l =3D listeners; l !=3D NULL; l =3D l->next) {
+		struct filter_data *data =3D l->data;
+
+		if (g_strcmp0(data->name, name) !=3D 0)
+			continue;
+
+		g_free(data->owner);
+		data->owner =3D g_strdup(owner);
+	}
+}
+
+static const char *check_name_cache(const char *name)
+{
+	GSList *l;
+
+	for (l =3D listeners; l !=3D NULL; l =3D l->next) {
+		struct filter_data *data =3D l->data;
+
+		if (g_strcmp0(data->name, name) !=3D 0)
+			continue;
+
+		return data->owner;
+	}
+
+	return NULL;
+}
+
 static DBusHandlerResult service_filter(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -375,6 +430,8 @@ static DBusHandlerResult
service_filter(DBusConnection *connection,
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}

+	update_name_cache(name, new);
+
 	while (data->callbacks) {
 		cb =3D data->callbacks->data;

@@ -422,7 +479,9 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,
 	member =3D dbus_message_get_member(message);
 	dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &arg,
DBUS_TYPE_INVALID);

-	data =3D filter_data_find(connection, sender, path, iface, member, arg);
+	/* Sender is always bus name */
+	data =3D filter_data_find(connection, NULL, sender, path, iface, member,
+					arg);
 	if (!data) {
 		error("Got %s.%s signal which has no listeners", iface, member);
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
@@ -447,7 +506,8 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,
 	filter_data_free(data);

 	/* Remove filter if there no listener left for the connection */
-	data =3D filter_data_find(connection, NULL, NULL, NULL, NULL, NULL);
+	data =3D filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
+					NULL);
 	if (!data)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
@@ -457,38 +517,60 @@ static DBusHandlerResult
message_filter(DBusConnection *connection,

 struct service_data {
 	DBusConnection *conn;
+	char *name;
+	const char *owner;
 	GDBusWatchFunction conn_func;
 	void *user_data;
 };

+static void service_data_free(struct service_data *data)
+{
+	dbus_connection_unref(data->conn);
+	g_free(data->name);
+	g_free(data);
+}
+
+static gboolean update_service(void *user_data)
+{
+	struct service_data *data =3D user_data;
+
+	update_name_cache(data->name, data->owner);
+	if (data->conn_func)
+		data->conn_func(data->conn, data->user_data);
+
+	service_data_free(data);
+
+	return FALSE;
+}
+
 static void service_reply(DBusPendingCall *call, void *user_data)
 {
 	struct service_data *data =3D user_data;
 	DBusMessage *reply;
-	DBusError error;
-	dbus_bool_t has_owner;
+	DBusError err;

 	reply =3D dbus_pending_call_steal_reply(call);
 	if (reply =3D=3D NULL)
 		return;

-	dbus_error_init(&error);
+	dbus_error_init(&err);

-	if (dbus_message_get_args(reply, &error,
-					DBUS_TYPE_BOOLEAN, &has_owner,
-						DBUS_TYPE_INVALID) =3D=3D FALSE) {
-		if (dbus_error_is_set(&error) =3D=3D TRUE) {
-			error("%s", error.message);
-			dbus_error_free(&error);
-		} else {
-			error("Wrong arguments for NameHasOwner reply");
-		}
-		goto done;
-	}
+	if (dbus_set_error_from_message(&err, reply))
+		goto fail;

-	if (has_owner && data->conn_func)
-		data->conn_func(data->conn, data->user_data);
+	if (dbus_message_get_args(reply, &err,
+					DBUS_TYPE_STRING, &data->owner,
+						DBUS_TYPE_INVALID) =3D=3D FALSE)
+		goto fail;

+	update_service(data);
+
+	goto done;
+
+fail:
+	error("%s", err.message);
+	dbus_error_free(&err);
+	service_data_free(data);
 done:
 	dbus_message_unref(reply);
 }
@@ -506,12 +588,19 @@ static void check_service(DBusConnection
*connection, const char *name,
 		return;
 	}

-	data->conn =3D connection;
+	data->conn =3D dbus_connection_ref(connection);
+	data->name =3D g_strdup(name);
 	data->conn_func =3D connect;
 	data->user_data =3D user_data;

+	data->owner =3D check_name_cache(name);
+	if (data->owner !=3D NULL) {
+		g_idle_add(update_service, data);
+		return;
+	}
+
 	message =3D dbus_message_new_method_call(DBUS_SERVICE_DBUS,
-			DBUS_PATH_DBUS, DBUS_INTERFACE_DBUS, "NameHasOwner");
+			DBUS_PATH_DBUS, DBUS_INTERFACE_DBUS, "GetNameOwner");
 	if (message =3D=3D NULL) {
 		error("Can't allocate new message");
 		g_free(data);
@@ -597,6 +686,11 @@ guint g_dbus_add_signal_watch(DBusConnection *connecti=
on,
 	if (!cb)
 		return 0;

+	if (data->name !=3D NULL && data->name_watch =3D=3D 0)
+		data->name_watch =3D g_dbus_add_service_watch(connection,
+							data->name, NULL,
+							NULL, NULL, NULL);
+
 	return cb->id;
 }

@@ -626,7 +720,8 @@ void g_dbus_remove_all_watches(DBusConnection *connecti=
on)
 {
 	struct filter_data *data;

-	while ((data =3D filter_data_find(connection, NULL, NULL, NULL, NULL, NUL=
L))) {
+	while ((data =3D filter_data_find(connection, NULL, NULL, NULL, NULL,
+					NULL, NULL))) {
 		listeners =3D g_slist_remove(listeners, data);
 		filter_data_call_and_free(data);
 	}
-- =

1.6.3.3


-- =

Luiz Augusto von Dentz
Computer Engineer

--===============4851796515222148426==--


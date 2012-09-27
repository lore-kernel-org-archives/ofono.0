Content-Type: multipart/mixed; boundary="===============7536828500799236093=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] gdbus: Fix wrong signal handler match
Date: Thu, 27 Sep 2012 08:58:58 -0300
Message-ID: <1348747139-1881-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1348747139-1881-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7536828500799236093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we add a signal handler with g_dbus_add_signal_watch(), this
function tries to multiplex the matches added in libdbus by checking
if there's a previous filter_data with the same fields. However, if the
field is NULL it accepts as being the same. The result is that the
following watches will use the same filter data:

watch1 =3D g_dbus_add_signal_watch(conn, BUS_NAME, NULL, iface, member,
						cb1, data1, NULL);
watch2 =3D g_dbus_add_signal_watch(conn, BUS_NAME, "/path2", iface, member,
						cb2, data2, NULL);
watch3 =3D g_dbus_add_signal_watch(conn, BUS_NAME, "/path3", iface, member,
						cb3, data3, NULL);

The result is that when a signal arrives with path =3D=3D "/path2", all 3
callbacks above will be called, with the same signal delivered to all of
them.

Another problem is that, if we invert the calls like below, only signals
to cb1 will never be trigerred, nonetheless it used path =3D=3D NULL.

watch2 =3D g_dbus_add_signal_watch(conn, BUS_NAME, "/path2", iface, member,
						cb2, data2, NULL);
watch1 =3D g_dbus_add_signal_watch(conn, BUS_NAME, NULL, iface, member,
						cb1, data1, NULL);
watch3 =3D g_dbus_add_signal_watch(conn, BUS_NAME, "/path3", iface, member,
						cb3, data3, NULL);

This is fixed by not multiplexing the matchs with filter data if any of
the fields are different, including being NULL. When a signal arrives,
if a field is NULL we accept it as a match, but not when adding the
signal handler.
---
 gdbus/watch.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 94 insertions(+), 21 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index d749176..2661928 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -78,6 +78,47 @@ struct filter_data {
 	gboolean registered;
 };
 =

+static struct filter_data *filter_data_find_match(DBusConnection *connecti=
on,
+							const char *name,
+							const char *owner,
+							const char *path,
+							const char *interface,
+							const char *member,
+							const char *argument)
+{
+	GSList *current;
+
+	for (current =3D listeners;
+			current !=3D NULL; current =3D current->next) {
+		struct filter_data *data =3D current->data;
+
+		if (connection !=3D data->connection)
+			continue;
+
+		if (g_strcmp0(name, data->name) !=3D 0)
+			continue;
+
+		if (g_strcmp0(owner, data->owner) !=3D 0)
+			continue;
+
+		if (g_strcmp0(path, data->path) !=3D 0)
+			continue;
+
+		if (g_strcmp0(interface, data->interface) !=3D 0)
+			continue;
+
+		if (g_strcmp0(member, data->member) !=3D 0)
+			continue;
+
+		if (g_strcmp0(argument, data->argument) !=3D 0)
+			continue;
+
+		return data;
+	}
+
+	return NULL;
+}
+
 static struct filter_data *filter_data_find(DBusConnection *connection,
 							const char *name,
 							const char *owner,
@@ -221,8 +262,8 @@ static struct filter_data *filter_data_get(DBusConnecti=
on *connection,
 		name =3D sender;
 =

 proceed:
-	data =3D filter_data_find(connection, name, owner, path, interface,
-					member, argument);
+	data =3D filter_data_find_match(connection, name, owner, path,
+						interface, member, argument);
 	if (data)
 		return data;
 =

@@ -501,6 +542,7 @@ static DBusHandlerResult message_filter(DBusConnection =
*connection,
 {
 	struct filter_data *data;
 	const char *sender, *path, *iface, *member, *arg =3D NULL;
+	GSList *current, *delete_listener =3D NULL;
 =

 	/* Only filter signals */
 	if (dbus_message_get_type(message) !=3D DBUS_MESSAGE_TYPE_SIGNAL)
@@ -512,30 +554,63 @@ static DBusHandlerResult message_filter(DBusConnectio=
n *connection,
 	member =3D dbus_message_get_member(message);
 	dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &arg, DBUS_TYPE_IN=
VALID);
 =

-	/* Sender is always bus name */
-	data =3D filter_data_find(connection, NULL, sender, path, iface, member,
-					arg);
-	if (data =3D=3D NULL) {
-		error("Got %s.%s signal which has no listeners", iface, member);
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-	}
+	/* Sender is always the owner */
+
+	for (current =3D listeners; current !=3D NULL; current =3D current->next)=
 {
+		data =3D current->data;
+
+		if (connection !=3D data->connection)
+			continue;
+
+		if (data->owner && g_str_equal(sender, data->owner) =3D=3D FALSE)
+			continue;
 =

-	if (data->handle_func) {
-		data->lock =3D TRUE;
+		if (data->path && g_str_equal(path, data->path) =3D=3D FALSE)
+			continue;
+
+		if (data->interface && g_str_equal(iface,
+						data->interface) =3D=3D FALSE)
+			continue;
 =

-		data->handle_func(connection, message, data);
+		if (data->member && g_str_equal(member, data->member) =3D=3D FALSE)
+			continue;
 =

-		data->callbacks =3D data->processed;
-		data->processed =3D NULL;
-		data->lock =3D FALSE;
+		if (data->argument && g_str_equal(arg,
+						data->argument) =3D=3D FALSE)
+			continue;
+
+		if (data->handle_func) {
+			data->lock =3D TRUE;
+
+			data->handle_func(connection, message, data);
+
+			data->callbacks =3D data->processed;
+			data->processed =3D NULL;
+			data->lock =3D FALSE;
+		}
+
+		if (!data->callbacks)
+			delete_listener =3D g_slist_prepend(delete_listener,
+								current);
 	}
 =

-	if (data->callbacks)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	for (current =3D delete_listener; current !=3D NULL;
+					current =3D delete_listener->next) {
+		GSList *l =3D current->data;
 =

-	remove_match(data);
+		data =3D l->data;
 =

-	listeners =3D g_slist_remove(listeners, data);
+		/* Has any other callback added callbacks back to this data? */
+		if (data->callbacks !=3D NULL)
+			continue;
+
+		remove_match(data);
+		listeners =3D g_slist_remove_link(listeners, l);
+
+		filter_data_free(data);
+	}
+
+	g_slist_free(delete_listener);
 =

 	/* Remove filter if there are no listeners left for the connection */
 	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
@@ -543,8 +618,6 @@ static DBusHandlerResult message_filter(DBusConnection =
*connection,
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 =

-	filter_data_free(data);
-
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 =

-- =

1.7.12.1


--===============7536828500799236093==--


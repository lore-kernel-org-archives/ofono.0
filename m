Content-Type: multipart/mixed; boundary="===============7408006229073003854=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 3/4] gdbus: Refactor filter_data_find()
Date: Wed, 03 Oct 2012 14:57:23 +0300
Message-ID: <1349265444-15527-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349265444-15527-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7408006229073003854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

Now this function is only used for searching the listeners of a
connection and the other parameters are not needed anymore.
---
 gdbus/watch.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 2661928..a402ca9 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -119,13 +119,7 @@ static struct filter_data *filter_data_find_match(DBus=
Connection *connection,
 	return NULL;
 }
 =

-static struct filter_data *filter_data_find(DBusConnection *connection,
-							const char *name,
-							const char *owner,
-							const char *path,
-							const char *interface,
-							const char *member,
-							const char *argument)
+static struct filter_data *filter_data_find(DBusConnection *connection)
 {
 	GSList *current;
 =

@@ -136,30 +130,6 @@ static struct filter_data *filter_data_find(DBusConnec=
tion *connection,
 		if (connection !=3D data->connection)
 			continue;
 =

-		if (name && data->name &&
-				g_str_equal(name, data->name) =3D=3D FALSE)
-			continue;
-
-		if (owner && data->owner &&
-				g_str_equal(owner, data->owner) =3D=3D FALSE)
-			continue;
-
-		if (path && data->path &&
-				g_str_equal(path, data->path) =3D=3D FALSE)
-			continue;
-
-		if (interface && data->interface &&
-				g_str_equal(interface, data->interface) =3D=3D FALSE)
-			continue;
-
-		if (member && data->member &&
-				g_str_equal(member, data->member) =3D=3D FALSE)
-			continue;
-
-		if (argument && data->argument &&
-				g_str_equal(argument, data->argument) =3D=3D FALSE)
-			continue;
-
 		return data;
 	}
 =

@@ -245,7 +215,7 @@ static struct filter_data *filter_data_get(DBusConnecti=
on *connection,
 	struct filter_data *data;
 	const char *name =3D NULL, *owner =3D NULL;
 =

-	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL, NULL) =3D=
=3D NULL) {
+	if (filter_data_find(connection) =3D=3D NULL) {
 		if (!dbus_connection_add_filter(connection,
 					message_filter, NULL, NULL)) {
 			error("dbus_connection_add_filter() failed");
@@ -419,8 +389,7 @@ static gboolean filter_data_remove_callback(struct filt=
er_data *data,
 	listeners =3D g_slist_remove(listeners, data);
 =

 	/* Remove filter if there are no listeners left for the connection */
-	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-								NULL) =3D=3D NULL)
+	if (filter_data_find(connection) =3D=3D NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 =

@@ -613,8 +582,7 @@ static DBusHandlerResult message_filter(DBusConnection =
*connection,
 	g_slist_free(delete_listener);
 =

 	/* Remove filter if there are no listeners left for the connection */
-	if (filter_data_find(connection, NULL, NULL, NULL, NULL, NULL,
-								NULL) =3D=3D NULL)
+	if (filter_data_find(connection) =3D=3D NULL)
 		dbus_connection_remove_filter(connection, message_filter,
 						NULL);
 =

@@ -810,8 +778,7 @@ void g_dbus_remove_all_watches(DBusConnection *connecti=
on)
 {
 	struct filter_data *data;
 =

-	while ((data =3D filter_data_find(connection, NULL, NULL, NULL, NULL,
-					NULL, NULL))) {
+	while ((data =3D filter_data_find(connection))) {
 		listeners =3D g_slist_remove(listeners, data);
 		filter_data_call_and_free(data);
 	}
-- =

1.7.11.4


--===============7408006229073003854==--


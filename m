Content-Type: multipart/mixed; boundary="===============2742976350281716511=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] location-reporting: don't add client-exit watch too early
Date: Mon, 28 Feb 2011 10:43:53 -0300
Message-ID: <1298900634-2337-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1298900634-2337-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2742976350281716511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Wait until driver gives us a file descriptor to start watching for
client exit. This fixes a race when client exits before the driver
calls location_reporting_enable_cb().
---
 src/location-reporting.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/location-reporting.c b/src/location-reporting.c
index 6ab0914..f19ccf5 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -170,13 +170,12 @@ static void location_reporting_enable_cb(const struct=
 ofono_error *error,
 							int fd,	void *data)
 {
 	struct ofono_location_reporting *lr =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
 	DBusMessage *reply;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Enabling location-reporting failed");
 =

-		client_remove(lr);
-
 		reply =3D __ofono_error_failed(lr->pending);
 		__ofono_dbus_pending_reply(&lr->pending, reply);
 =

@@ -184,6 +183,9 @@ static void location_reporting_enable_cb(const struct o=
fono_error *error,
 	}
 =

 	lr->enabled =3D TRUE;
+	lr->client_owner =3D g_strdup(dbus_message_get_sender(lr->pending));
+	lr->disconnect_watch =3D g_dbus_add_disconnect_watch(conn,
+				lr->client_owner, client_exited, lr, NULL);
 =

 	reply =3D dbus_message_new_method_return(lr->pending);
 	dbus_message_append_args(reply, DBUS_TYPE_UNIX_FD, &fd,
@@ -198,7 +200,6 @@ static DBusMessage *location_reporting_request(DBusConn=
ection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct ofono_location_reporting *lr =3D data;
-	const char *caller =3D dbus_message_get_sender(msg);
 =

 	if (lr->pending !=3D NULL)
 		return __ofono_error_busy(msg);
@@ -206,9 +207,6 @@ static DBusMessage *location_reporting_request(DBusConn=
ection *conn,
 	if (lr->enabled)
 		return __ofono_error_in_use(msg);
 =

-	lr->client_owner =3D g_strdup(caller);
-	lr->disconnect_watch =3D g_dbus_add_disconnect_watch(conn,
-				lr->client_owner, client_exited, lr, NULL);
 	lr->pending =3D dbus_message_ref(msg);
 =

 	lr->driver->enable(lr, location_reporting_enable_cb, lr);
-- =

1.7.4.1


--===============2742976350281716511==--


Content-Type: multipart/mixed; boundary="===============3204282876687730811=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH 1/2] Allow users to specify dbus name replacement behaviour.
Date: Wed, 02 Apr 2014 16:56:20 +0300
Message-ID: <1396446981-19749-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3204282876687730811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jussi Pakkanen <jussi.pakkanen@canonical.com>

Hello

In testing it is sometimes useful to be able to replace the system ofono da=
emon
instance with our own. This patch makes this possible using dbus' name repl=
acement
feature. This patch has the plumbing changes to make it possible to set the
name replacement settings. The next patch allows you to set these parameters
from the command line. The default behaviour does not change, i.e. the serv=
ice
name is not replaceable and the daemon will not try to replace an existing =
ofono
instance.

---
 dundee/main.c        |  2 +-
 gdbus/gdbus.h        | 12 +++++++++---
 gdbus/mainloop.c     | 22 ++++++++++++++--------
 src/main.c           |  3 ++-
 tools/auto-enable.c  |  2 +-
 tools/huawei-audio.c |  2 +-
 tools/stktest.c      |  2 +-
 7 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/dundee/main.c b/dundee/main.c
index 791425b..2264d42 100644
--- a/dundee/main.c
+++ b/dundee/main.c
@@ -201,7 +201,7 @@ int main(int argc, char **argv)
 =

 	dbus_error_init(&error);
 =

-	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, DUNDEE_SERVICE, &error);
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, DUNDEE_SERVICE, 0, &error);
 	if (conn =3D=3D NULL) {
 		if (dbus_error_is_set(&error) =3D=3D TRUE) {
 			ofono_error("Unable to hop onto D-Bus: %s",
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 551c306..0eedd1e 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -35,6 +35,7 @@ typedef enum GDBusMethodFlags GDBusMethodFlags;
 typedef enum GDBusSignalFlags GDBusSignalFlags;
 typedef enum GDBusPropertyFlags GDBusPropertyFlags;
 typedef enum GDBusSecurityFlags GDBusSecurityFlags;
+typedef enum GDBusNameBehaviourFlags GDBusNameBehaviourFlags;
 =

 typedef struct GDBusArgInfo GDBusArgInfo;
 typedef struct GDBusMethodTable GDBusMethodTable;
@@ -52,13 +53,13 @@ typedef gboolean (* GDBusSignalFunction) (DBusConnectio=
n *connection,
 					DBusMessage *message, void *user_data);
 =

 DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
-							DBusError *error);
+							GDBusNameBehaviourFlags name_flags, DBusError *error);
 =

 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
-							DBusError *error);
+							GDBusNameBehaviourFlags name_flags, DBusError *error);
 =

 gboolean g_dbus_request_name(DBusConnection *connection, const char *name,
-							DBusError *error);
+							GDBusNameBehaviourFlags name_flags, DBusError *error);
 =

 gboolean g_dbus_set_disconnect_function(DBusConnection *connection,
 				GDBusWatchFunction function,
@@ -115,6 +116,11 @@ enum GDBusSecurityFlags {
 	G_DBUS_SECURITY_FLAG_ALLOW_INTERACTION =3D (1 << 2),
 };
 =

+enum GDBusNameBehaviourFlags {
+	G_DBUS_NAME_ALLOW_REPLACEMENT  =3D (1 << 0),
+	G_DBUS_NAME_TRY_REPLACEMENT    =3D (1 << 1),
+};
+
 struct GDBusArgInfo {
 	const char *name;
 	const char *signature;
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 435fb93..6417818 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -252,13 +252,13 @@ static inline void setup_dbus_with_main_loop(DBusConn=
ection *conn)
 }
 =

 static gboolean setup_bus(DBusConnection *conn, const char *name,
-						DBusError *error)
+						GDBusNameBehaviourFlags name_flags, DBusError *error)
 {
 	gboolean result;
 	DBusDispatchStatus status;
 =

 	if (name !=3D NULL) {
-		result =3D g_dbus_request_name(conn, name, error);
+		result =3D g_dbus_request_name(conn, name, name_flags, error);
 =

 		if (error !=3D NULL) {
 			if (dbus_error_is_set(error) =3D=3D TRUE)
@@ -278,7 +278,7 @@ static gboolean setup_bus(DBusConnection *conn, const c=
har *name,
 }
 =

 DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
-							DBusError *error)
+							GDBusNameBehaviourFlags name_flags, DBusError *error)
 {
 	DBusConnection *conn;
 =

@@ -292,7 +292,7 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, cons=
t char *name,
 	if (conn =3D=3D NULL)
 		return NULL;
 =

-	if (setup_bus(conn, name, error) =3D=3D FALSE) {
+	if (setup_bus(conn, name, name_flags, error) =3D=3D FALSE) {
 		dbus_connection_unref(conn);
 		return NULL;
 	}
@@ -301,7 +301,7 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, cons=
t char *name,
 }
 =

 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
-							DBusError *error)
+							GDBusNameBehaviourFlags name_flags, DBusError *error)
 {
 	DBusConnection *conn;
 =

@@ -315,7 +315,7 @@ DBusConnection *g_dbus_setup_private(DBusBusType type, =
const char *name,
 	if (conn =3D=3D NULL)
 		return NULL;
 =

-	if (setup_bus(conn, name, error) =3D=3D FALSE) {
+	if (setup_bus(conn, name, name_flags, error) =3D=3D FALSE) {
 		dbus_connection_unref(conn);
 		return NULL;
 	}
@@ -324,12 +324,18 @@ DBusConnection *g_dbus_setup_private(DBusBusType type=
, const char *name,
 }
 =

 gboolean g_dbus_request_name(DBusConnection *connection, const char *name,
-							DBusError *error)
+							GDBusNameBehaviourFlags name_flags, DBusError *error)
 {
 	int result;
+	unsigned int dbus_flags =3D DBUS_NAME_FLAG_DO_NOT_QUEUE;
+
+	if (name_flags & G_DBUS_NAME_TRY_REPLACEMENT)
+		dbus_flags |=3D DBUS_NAME_FLAG_REPLACE_EXISTING;
+	if (name_flags & G_DBUS_NAME_ALLOW_REPLACEMENT)
+		dbus_flags |=3D DBUS_NAME_FLAG_ALLOW_REPLACEMENT;
 =

 	result =3D dbus_bus_request_name(connection, name,
-					DBUS_NAME_FLAG_DO_NOT_QUEUE, error);
+					dbus_flags, error);
 =

 	if (error !=3D NULL) {
 		if (dbus_error_is_set(error) =3D=3D TRUE)
diff --git a/src/main.c b/src/main.c
index d6349cb..d2042c5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -168,6 +168,7 @@ int main(int argc, char **argv)
 	DBusConnection *conn;
 	DBusError error;
 	guint signal;
+	GDBusNameBehaviourFlags name_flags =3D 0;
 =

 #ifdef NEED_THREADS
 	if (g_thread_supported() =3D=3D FALSE)
@@ -217,7 +218,7 @@ int main(int argc, char **argv)
 =

 	dbus_error_init(&error);
 =

-	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, OFONO_SERVICE, &error);
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, OFONO_SERVICE, name_flags, &er=
ror);
 	if (conn =3D=3D NULL) {
 		if (dbus_error_is_set(&error) =3D=3D TRUE) {
 			ofono_error("Unable to hop onto D-Bus: %s",
diff --git a/tools/auto-enable.c b/tools/auto-enable.c
index 87fb0a8..86c4b39 100644
--- a/tools/auto-enable.c
+++ b/tools/auto-enable.c
@@ -527,7 +527,7 @@ int main(int argc, char **argv)
 =

 	dbus_error_init(&err);
 =

-	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, 0, &err);
 	if (conn =3D=3D NULL) {
 		if (dbus_error_is_set(&err) =3D=3D TRUE) {
 			fprintf(stderr, "%s\n", err.message);
diff --git a/tools/huawei-audio.c b/tools/huawei-audio.c
index 9997a58..8f95ade 100644
--- a/tools/huawei-audio.c
+++ b/tools/huawei-audio.c
@@ -810,7 +810,7 @@ int main(int argc, char **argv)
 =

 	dbus_error_init(&err);
 =

-	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, 0, &err);
 	if (conn =3D=3D NULL) {
 		if (dbus_error_is_set(&err) =3D=3D TRUE) {
 			fprintf(stderr, "%s\n", err.message);
diff --git a/tools/stktest.c b/tools/stktest.c
index c015e09..4e7e645 100644
--- a/tools/stktest.c
+++ b/tools/stktest.c
@@ -4501,7 +4501,7 @@ int main(int argc, char **argv)
 =

 	dbus_error_init(&err);
 =

-	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, 0, &err);
 	if (conn =3D=3D NULL) {
 		if (dbus_error_is_set(&err) =3D=3D TRUE) {
 			fprintf(stderr, "%s\n", err.message);
-- =

1.9.1


--===============3204282876687730811==--


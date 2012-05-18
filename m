Content-Type: multipart/mixed; boundary="===============4865427127579534535=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 07/12] gdbus: loop over args to check message signature
Date: Fri, 18 May 2012 16:44:07 -0300
Message-ID: <1337370252-29346-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337370252-29346-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4865427127579534535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/object.c |   34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 3ac6a0b..b187bb5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -374,6 +374,27 @@ static struct interface_data *find_interface(GSList *i=
nterfaces,
 	return NULL;
 }
 =

+static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
+							DBusMessage *message)
+{
+	const char *sig =3D dbus_message_get_signature(message);
+	const char *p =3D NULL;
+
+	for (; args && args->signature && *sig; args++) {
+		p =3D args->signature;
+
+		for (; *sig && *p; sig++, p++) {
+			if (*p !=3D *sig)
+				return FALSE;
+		}
+	}
+
+	if (*sig || (p && *p) || (args && args->signature))
+		return FALSE;
+
+	return TRUE;
+}
+
 static DBusHandlerResult generic_message(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -394,8 +415,8 @@ static DBusHandlerResult generic_message(DBusConnection=
 *connection,
 							method->name) =3D=3D FALSE)
 			continue;
 =

-		if (dbus_message_has_signature(message,
-						method->signature) =3D=3D FALSE)
+		if (g_dbus_args_have_signature(method->in_args,
+							message) =3D=3D FALSE)
 			continue;
 =

 		if (check_privilege(connection, message, method,
@@ -552,7 +573,7 @@ static void object_path_unref(DBusConnection *connectio=
n, const char *path)
 =

 static gboolean check_signal(DBusConnection *conn, const char *path,
 				const char *interface, const char *name,
-				const char **args)
+				const GDBusArgInfo **args)
 {
 	struct generic_data *data =3D NULL;
 	struct interface_data *iface;
@@ -575,7 +596,7 @@ static gboolean check_signal(DBusConnection *conn, cons=
t char *path,
 =

 	for (signal =3D iface->signals; signal && signal->name; signal++) {
 		if (!strcmp(signal->name, name)) {
-			*args =3D signal->signature;
+			*args =3D signal->args;
 			break;
 		}
 	}
@@ -597,7 +618,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection *c=
onn,
 {
 	DBusMessage *signal;
 	dbus_bool_t ret;
-	const char *signature, *args;
+	const GDBusArgInfo *args;
 =

 	if (!check_signal(conn, path, interface, name, &args))
 		return FALSE;
@@ -612,8 +633,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection *c=
onn,
 	if (!ret)
 		goto fail;
 =

-	signature =3D dbus_message_get_signature(signal);
-	if (strcmp(args, signature) !=3D 0) {
+	if (g_dbus_args_have_signature(args, signal) =3D=3D FALSE) {
 		error("%s.%s: expected signature'%s' but got '%s'",
 				interface, name, args, signature);
 		ret =3D FALSE;
-- =

1.7.10.2


--===============4865427127579534535==--


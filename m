Content-Type: multipart/mixed; boundary="===============5487901848476162771=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 09/12] gdbus: remove signature and reply from tables
Date: Fri, 18 May 2012 16:44:09 -0300
Message-ID: <1337370252-29346-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337370252-29346-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5487901848476162771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/gdbus.h  |   60 ----------------------------------------------------=
----
 gdbus/object.c |    2 +-
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 868c8d5..0a8a27c 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -89,8 +89,6 @@ typedef struct {
 =

 typedef struct {
 	const char *name;
-	const char *signature;
-	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
@@ -100,7 +98,6 @@ typedef struct {
 =

 typedef struct {
 	const char *name;
-	const char *signature;
 	GDBusSignalFlags flags;
 	const GDBusArgInfo *args;
 } GDBusSignalTable;
@@ -120,63 +117,6 @@ typedef struct {
 =

 #define GDBUS_ARGS(args...) (const GDBusArgInfo[]) { args, { } }
 =

-#define _GDBUS_METHOD(_name, _signature, _reply, _in_args, _out_args, _fun=
ction) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.reply =3D _reply, \
-	.in_args =3D _in_args, \
-	.out_args =3D _out_args, \
-	.function =3D _function
-
-#define _GDBUS_ASYNC_METHOD(_name, _signature, _reply, _in_args, _out_args=
, _function) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.reply =3D _reply, \
-	.in_args =3D _in_args, \
-	.out_args =3D _out_args, \
-	.function =3D _function, \
-	.flags =3D G_DBUS_METHOD_FLAG_ASYNC
-
-#define _GDBUS_DEPRECATED_METHOD(_name, _signature, _reply, _in_args, _out=
_args, _function) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.reply =3D _reply, \
-	.in_args =3D _in_args, \
-	.out_args =3D _out_args, \
-	.function =3D _function, \
-	.flags =3D G_DBUS_METHOD_FLAG_DEPRECATED
-
-#define _GDBUS_DEPRECATED_ASYNC_METHOD(_name, _signature, _reply, _in_args=
, _out_args, _function) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.reply =3D _reply, \
-	.in_args =3D _in_args, \
-	.out_args =3D _out_args, \
-	.function =3D _function, \
-	.flags =3D G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
-
-#define _GDBUS_NOREPLY_METHOD(_name, _signature, _reply, _in_args, _out_ar=
gs, _function) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.reply =3D _reply, \
-	.in_args =3D _in_args, \
-	.out_args =3D _out_args, \
-	.function =3D _function, \
-	.flags =3D G_DBUS_METHOD_FLAG_NOREPLY
-
-#define _GDBUS_SIGNAL(_name, _signature, _args) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.args =3D _args
-
-#define _GDBUS_DEPRECATED_SIGNAL(_name, _signature, _args) \
-	.name =3D _name, \
-	.signature =3D _signature, \
-	.args =3D _args, \
-	.flags =3D G_DBUS_SIGNAL_FLAG_DEPRECATED
-
-/* Helpers with no signature and reply */
-
 #define GDBUS_METHOD(_name, _in_args, _out_args, _function) \
 	.name =3D _name, \
 	.in_args =3D _in_args, \
diff --git a/gdbus/object.c b/gdbus/object.c
index b187bb5..fcdd6ec 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -471,7 +471,7 @@ done:
 }
 =

 static const GDBusMethodTable introspect_methods[] =3D {
-	{ _GDBUS_METHOD("Introspect", "", "s", NULL,
+	{ GDBUS_METHOD("Introspect", NULL,
 			GDBUS_ARGS({ "xml", "s" }), introspect) },
 	{ }
 };
-- =

1.7.10.2


--===============5487901848476162771==--


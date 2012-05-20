Content-Type: multipart/mixed; boundary="===============3211049908567481406=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 04/12] gdbus: add and use helpers for table declarations
Date: Sun, 20 May 2012 02:07:28 -0300
Message-ID: <1337490456-10941-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3211049908567481406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/gdbus.h  |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gdbus/object.c |    3 +-
 2 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e5e7938..868c8d5 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -118,6 +118,108 @@ typedef struct {
 	GDBusSecurityFunction function;
 } GDBusSecurityTable;
 =

+#define GDBUS_ARGS(args...) (const GDBusArgInfo[]) { args, { } }
+
+#define _GDBUS_METHOD(_name, _signature, _reply, _in_args, _out_args, _fun=
ction) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.reply =3D _reply, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function
+
+#define _GDBUS_ASYNC_METHOD(_name, _signature, _reply, _in_args, _out_args=
, _function) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.reply =3D _reply, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_ASYNC
+
+#define _GDBUS_DEPRECATED_METHOD(_name, _signature, _reply, _in_args, _out=
_args, _function) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.reply =3D _reply, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define _GDBUS_DEPRECATED_ASYNC_METHOD(_name, _signature, _reply, _in_args=
, _out_args, _function) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.reply =3D _reply, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define _GDBUS_NOREPLY_METHOD(_name, _signature, _reply, _in_args, _out_ar=
gs, _function) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.reply =3D _reply, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_NOREPLY
+
+#define _GDBUS_SIGNAL(_name, _signature, _args) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.args =3D _args
+
+#define _GDBUS_DEPRECATED_SIGNAL(_name, _signature, _args) \
+	.name =3D _name, \
+	.signature =3D _signature, \
+	.args =3D _args, \
+	.flags =3D G_DBUS_SIGNAL_FLAG_DEPRECATED
+
+/* Helpers with no signature and reply */
+
+#define GDBUS_METHOD(_name, _in_args, _out_args, _function) \
+	.name =3D _name, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function
+
+#define GDBUS_ASYNC_METHOD(_name, _in_args, _out_args, _function) \
+	.name =3D _name, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_ASYNC
+
+#define GDBUS_DEPRECATED_METHOD(_name, _in_args, _out_args, _function) \
+	.name =3D _name, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define GDBUS_DEPRECATED_ASYNC_METHOD(_name, _in_args, _out_args, _functio=
n) \
+	.name =3D _name, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
+
+#define GDBUS_NOREPLY_METHOD(_name, _in_args, _out_args, _function) \
+	.name =3D _name, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_NOREPLY
+
+#define GDBUS_SIGNAL(_name, _args) \
+	.name =3D _name, \
+	.args =3D _args
+
+#define GDBUS_DEPRECATED_SIGNAL(_name, _args) \
+	.name =3D _name, \
+	.args =3D _args, \
+	.flags =3D G_DBUS_SIGNAL_FLAG_DEPRECATED
+
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
diff --git a/gdbus/object.c b/gdbus/object.c
index 0ef6c80..2ddc574 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -497,7 +497,8 @@ done:
 }
 =

 static const GDBusMethodTable introspect_methods[] =3D {
-	{ "Introspect",	"",	"s", introspect	},
+	{ _GDBUS_METHOD("Introspect", "", "s", NULL,
+			GDBUS_ARGS({ "xml", "s" }), introspect) },
 	{ }
 };
 =

-- =

1.7.10.2


--===============3211049908567481406==--


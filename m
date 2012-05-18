Content-Type: multipart/mixed; boundary="===============5077665412234403508=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 04/12] gdbus: add macro for methods marked as NOREPLY
Date: Fri, 18 May 2012 16:59:51 -0300
Message-ID: <1337371199-29496-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337371199-29496-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5077665412234403508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/gdbus.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8354633..868c8d5 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -155,6 +155,15 @@ typedef struct {
 	.function =3D _function, \
 	.flags =3D G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
 =

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
 #define _GDBUS_SIGNAL(_name, _signature, _args) \
 	.name =3D _name, \
 	.signature =3D _signature, \
@@ -195,6 +204,13 @@ typedef struct {
 	.function =3D _function, \
 	.flags =3D G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
 =

+#define GDBUS_NOREPLY_METHOD(_name, _in_args, _out_args, _function) \
+	.name =3D _name, \
+	.in_args =3D _in_args, \
+	.out_args =3D _out_args, \
+	.function =3D _function, \
+	.flags =3D G_DBUS_METHOD_FLAG_NOREPLY
+
 #define GDBUS_SIGNAL(_name, _args) \
 	.name =3D _name, \
 	.args =3D _args
-- =

1.7.10.2


--===============5077665412234403508==--


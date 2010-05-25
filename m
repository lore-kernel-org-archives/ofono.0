Content-Type: multipart/mixed; boundary="===============3617438858318118688=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/9] Add g_dbus_interface_is_registered()
Date: Tue, 25 May 2010 04:18:00 -0300
Message-ID: <1274771888-2565-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274771888-2565-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3617438858318118688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This funcion checks if a DBus interface is registered and return TRUE case
yes, otherwise it returns FALSE.
---
 gdbus/gdbus.h  |    2 ++
 gdbus/object.c |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 47e18cf..13c015a 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -98,6 +98,8 @@ gboolean g_dbus_register_interface(DBusConnection *connec=
tion,
 					GDBusDestroyFunction destroy);
 gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name);
+gboolean g_dbus_interface_is_registered(DBusConnection *connection,
+					const char *path, const char *name);
 =

 DBusMessage *g_dbus_create_error(DBusMessage *message, const char *name,
 						const char *format, ...);
diff --git a/gdbus/object.c b/gdbus/object.c
index ff69641..7cad0b4 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -556,6 +556,21 @@ gboolean g_dbus_unregister_interface(DBusConnection *c=
onnection,
 	return TRUE;
 }
 =

+gboolean g_dbus_interface_is_registered(DBusConnection *connection,
+					const char *path, const char *name)
+{
+	struct generic_data *data;
+
+	data =3D object_path_ref(connection, path);
+	if (data =3D=3D NULL)
+		return FALSE;
+
+	if (find_interface(data->interfaces, name))
+		return TRUE;
+	else
+		return FALSE;
+}
+
 DBusMessage *g_dbus_create_error_valist(DBusMessage *message, const char *=
name,
 					const char *format, va_list args)
 {
-- =

1.7.1


--===============3617438858318118688==--


Content-Type: multipart/mixed; boundary="===============3487701163841292377=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 06/16] emulator: Add emulator get_properties method
Date: Thu, 13 May 2010 18:02:29 +0800
Message-ID: <1273744959-3711-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3487701163841292377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index bed0f46..f1cb9ef 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -212,7 +212,40 @@ static DBusMessage *emulator_destroy(DBusConnection *c=
onn,
 	return reply;
 }
 =

+static DBusMessage *emulator_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct emulator *e =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *type, *path;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	type =3D emulator_type_to_str(e->type);
+
+	ofono_dbus_dict_append(&dict, "TYPE", DBUS_TYPE_STRING, &type);
+
+	path =3D emulator_build_path(e->oe, e);
+
+	ofono_dbus_dict_append(&dict, "PATH", DBUS_TYPE_STRING, &path);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static GDBusMethodTable emulator_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	emulator_get_properties },
 	{ "Destroy",		"",	"",		emulator_destroy },
 	{ }
 };
-- =

1.6.3.3


--===============3487701163841292377==--


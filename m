Content-Type: multipart/mixed; boundary="===============8088998365614042462=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/16] emulator: Add ofono_emulator get_properties method
Date: Thu, 13 May 2010 18:02:27 +0800
Message-ID: <1273744959-3711-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8088998365614042462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To list the object path of all available emulators.
---
 src/emulator.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index f9f7108..e6ffb78 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -257,6 +257,25 @@ static gboolean emulator_dbus_register(struct ofono_em=
ulator *oe,
 	return TRUE;
 }
 =

+static int emulators_path_list(struct ofono_emulator *oe, char ***objlist)
+{
+	GSList *emulator_list =3D oe->emulator_list;
+	GSList *l;
+	struct emulator *e;
+	int i;
+
+	*objlist =3D g_new0(char *, g_slist_length(emulator_list) + 1);
+	if (*objlist =3D=3D NULL)
+		return -1;
+
+	for (i =3D 0, l =3D emulator_list; l; l =3D l->next, i++) {
+		e =3D l->data;
+		(*objlist)[i] =3D g_strdup(emulator_build_path(oe, e));
+	}
+
+	return 0;
+}
+
 static DBusMessage *manager_create(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -299,7 +318,40 @@ static DBusMessage *manager_create(DBusConnection *con=
n, DBusMessage *msg,
 	return reply;
 }
 =

+
+static DBusMessage *manager_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_emulator *oe =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	char **objpath_list;
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
+	emulators_path_list(oe, &objpath_list);
+
+	ofono_dbus_dict_append_array(&dict, "Emulators", DBUS_TYPE_OBJECT_PATH,
+					&objpath_list);
+
+	g_strfreev(objpath_list);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static GDBusMethodTable emulator_manager_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}", manager_get_properties },
 	{ "Create",		"sh",	"",	manager_create },
 	{ }
 };
-- =

1.6.3.3


--===============8088998365614042462==--


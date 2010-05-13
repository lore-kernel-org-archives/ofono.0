Content-Type: multipart/mixed; boundary="===============0502898673877039094=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 05/16] emulator: Add ofono_emulator manager_destroy
Date: Thu, 13 May 2010 18:02:28 +0800
Message-ID: <1273744959-3711-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0502898673877039094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To destroy all available emulators.
---
 src/emulator.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e6ffb78..bed0f46 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -276,6 +276,23 @@ static int emulators_path_list(struct ofono_emulator *=
oe, char ***objlist)
 	return 0;
 }
 =

+static DBusMessage *manager_destroy(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	struct ofono_emulator *oe =3D data;
+
+	if (oe->emulator_list) {
+		g_slist_foreach(oe->emulator_list, emulator_dbus_unregister,
+						NULL);
+		g_slist_free(oe->emulator_list);
+		oe->emulator_list =3D NULL;
+	}
+
+	__ofono_watchlist_remove_all(oe->status_watches);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *manager_create(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -353,6 +370,7 @@ static DBusMessage *manager_get_properties(DBusConnecti=
on *conn,
 static GDBusMethodTable emulator_manager_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}", manager_get_properties },
 	{ "Create",		"sh",	"",	manager_create },
+	{ "DestroyAll",		"", 	"",	manager_destroy	},
 	{ }
 };
 =

-- =

1.6.3.3


--===============0502898673877039094==--


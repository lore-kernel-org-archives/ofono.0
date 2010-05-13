Content-Type: multipart/mixed; boundary="===============7266434871995565509=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 07/16] emulator: Add emit_emulator_list_changed method
Date: Thu, 13 May 2010 18:02:30 +0800
Message-ID: <1273744959-3711-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-7-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7266434871995565509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To emit emulator object list when any emulator is created or removed.
---
 src/emulator.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index f1cb9ef..5ad0d78 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -55,6 +55,7 @@ struct emulator {
 =

 static void notify_status_watches(struct emulator *e, void *data);
 static void emulator_dbus_unregister(void *data, void *user_data);
+static gboolean emit_emulator_list_changed(void *data);
 =

 static unsigned int emulator_next_id(struct ofono_emulator *oe)
 {
@@ -189,11 +190,14 @@ error:
 static gboolean real_destroy(void *data)
 {
 	struct emulator *e =3D data;
+	struct ofono_emulator *oe =3D e->oe;
 =

 	e->timeout_source =3D 0;
 =

 	emulator_dbus_unregister(e, NULL);
 =

+	emit_emulator_list_changed(oe);
+
 	return FALSE;
 }
 =

@@ -309,6 +313,25 @@ static int emulators_path_list(struct ofono_emulator *=
oe, char ***objlist)
 	return 0;
 }
 =

+static gboolean emit_emulator_list_changed(void *data)
+{
+	struct ofono_emulator *oe =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(oe->atom);
+	char **objpath_list;
+
+	emulators_path_list(oe, &objpath_list);
+
+	ofono_dbus_signal_array_property_changed(conn, path,
+					OFONO_EMULATOR_MANAGER_INTERFACE,
+					"Emulators", DBUS_TYPE_OBJECT_PATH,
+					&objpath_list);
+
+	g_strfreev(objpath_list);
+
+	return FALSE;
+}
+
 static DBusMessage *manager_destroy(DBusConnection *conn, DBusMessage *msg,
 						void *data)
 {
@@ -323,6 +346,8 @@ static DBusMessage *manager_destroy(DBusConnection *con=
n, DBusMessage *msg,
 =

 	__ofono_watchlist_remove_all(oe->status_watches);
 =

+	emit_emulator_list_changed(oe);
+
 	return dbus_message_new_method_return(msg);
 }
 =

@@ -472,6 +497,8 @@ static void emulator_remove_all(struct ofono_atom *atom)
 		g_slist_free(oe->emulator_list);
 	}
 =

+	emit_emulator_list_changed(oe);
+
 	__ofono_watchlist_free(oe->status_watches);
 =

 	g_free(oe);
-- =

1.6.3.3


--===============7266434871995565509==--


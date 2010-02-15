Content-Type: multipart/mixed; boundary="===============2828993016024623815=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/3] hfp: remove modems if bluetoothd shutdowns without
 calling Release
Date: Mon, 15 Feb 2010 17:26:36 -0200
Message-ID: <1266261996-15507-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1266261996-15507-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2828993016024623815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 3776dc6..c63e332 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -911,6 +911,23 @@ done:
 	dbus_message_unref(reply);
 }
 =

+static gboolean hfp_remove_each_modem(gpointer key, gpointer value, gpoint=
er user_data)
+{
+	struct ofono_modem *modem =3D value;
+
+	ofono_modem_remove(modem);
+
+	return TRUE;
+}
+
+static void bluetooth_disconnect(DBusConnection *connection, void *user_da=
ta)
+{
+	if (uuid_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(uuid_hash, hfp_remove_each_modem, NULL);
+}
+
 static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
@@ -1098,6 +1115,7 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

+static guint watch;
 static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint uuid_watch;
@@ -1111,6 +1129,10 @@ static int hfp_init()
 =

 	connection =3D ofono_dbus_get_connection();
 =

+	watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
+			NULL, bluetooth_disconnect, NULL, NULL);
+
+
 	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
 						BLUEZ_MANAGER_INTERFACE,
 						"AdapterAdded",
@@ -1126,8 +1148,8 @@ static int hfp_init()
 						"PropertyChanged",
 						property_changed, NULL, NULL);
 =

-	if (adapter_added_watch =3D=3D 0 || adapter_removed_watch =3D=3D 0||
-			uuid_watch =3D=3D 0) {
+	if (watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
+			adapter_removed_watch =3D=3D 0|| uuid_watch =3D=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -1150,6 +1172,7 @@ static int hfp_init()
 	return 0;
 =

 remove:
+	g_dbus_remove_watch(connection, watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, uuid_watch);
@@ -1165,6 +1188,7 @@ remove:
 =

 static void hfp_exit()
 {
+	g_dbus_remove_watch(connection, watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, uuid_watch);
-- =

1.6.4.4


--===============2828993016024623815==--


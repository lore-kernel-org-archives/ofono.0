Content-Type: multipart/mixed; boundary="===============0806689649803951366=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/4] tools: watch for signals only on OFONO_SERVICE
Date: Thu, 28 Jun 2012 10:59:21 -0300
Message-ID: <1340891961-9809-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1340891961-9809-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0806689649803951366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/auto-enable.c  | 20 ++++++++++----------
 tools/huawei-audio.c | 17 +++++++++--------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/tools/auto-enable.c b/tools/auto-enable.c
index 1d5b53b..87fb0a8 100644
--- a/tools/auto-enable.c
+++ b/tools/auto-enable.c
@@ -246,7 +246,7 @@ static void create_modem(DBusConnection *conn,
 	modem->conn =3D dbus_connection_ref(conn);
 =

 	modem->sim_changed_watch =3D g_dbus_add_signal_watch(conn,
-				NULL, NULL, OFONO_SIM_INTERFACE,
+				OFONO_SERVICE, NULL, OFONO_SIM_INTERFACE,
 				"PropertyChanged", sim_changed, modem, NULL);
 =

 	g_hash_table_replace(modem_list, modem->path, modem);
@@ -420,15 +420,15 @@ static void ofono_connect(DBusConnection *conn, void =
*user_data)
 	modem_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, destroy_modem);
 =

-	modem_added_watch =3D g_dbus_add_signal_watch(conn, NULL, NULL,
-				OFONO_MANAGER_INTERFACE, "ModemAdded",
-						modem_added, NULL, NULL);
-	modem_removed_watch =3D g_dbus_add_signal_watch(conn, NULL, NULL,
-				OFONO_MANAGER_INTERFACE, "ModemRemoved",
-						modem_removed, NULL, NULL);
-	modem_changed_watch =3D g_dbus_add_signal_watch(conn, NULL, NULL,
-				OFONO_MODEM_INTERFACE, "PropertyChanged",
-						modem_changed, NULL, NULL);
+	modem_added_watch =3D g_dbus_add_signal_watch(conn, OFONO_SERVICE,
+				NULL, OFONO_MANAGER_INTERFACE, "ModemAdded",
+				modem_added, NULL, NULL);
+	modem_removed_watch =3D g_dbus_add_signal_watch(conn, OFONO_SERVICE,
+				NULL, OFONO_MANAGER_INTERFACE, "ModemRemoved",
+				modem_removed, NULL, NULL);
+	modem_changed_watch =3D g_dbus_add_signal_watch(conn, OFONO_SERVICE,
+				NULL, OFONO_MODEM_INTERFACE, "PropertyChanged",
+				modem_changed, NULL, NULL);
 =

 	get_modems(conn);
 }
diff --git a/tools/huawei-audio.c b/tools/huawei-audio.c
index 8f3c572..9997a58 100644
--- a/tools/huawei-audio.c
+++ b/tools/huawei-audio.c
@@ -514,17 +514,18 @@ static void create_modem(DBusConnection *conn,
 =

 	modem->conn =3D conn;
 =

-	modem->call_added_watch =3D g_dbus_add_signal_watch(conn, NULL,
+	modem->call_added_watch =3D g_dbus_add_signal_watch(conn, OFONO_SERVICE,
 				modem->path, OFONO_CALLMANAGER_INTERFACE,
 				"CallAdded", call_added, modem, NULL);
-	modem->call_removed_watch =3D g_dbus_add_signal_watch(conn, NULL,
-				modem->path, OFONO_CALLMANAGER_INTERFACE,
-				"CallRemoved", call_removed, modem, NULL);
-	modem->call_changed_watch =3D g_dbus_add_signal_watch(conn, NULL,
-				NULL, OFONO_CALL_INTERFACE,
+	modem->call_removed_watch =3D g_dbus_add_signal_watch(conn,
+				OFONO_SERVICE, modem->path,
+				OFONO_CALLMANAGER_INTERFACE, "CallRemoved",
+				call_removed, modem, NULL);
+	modem->call_changed_watch =3D g_dbus_add_signal_watch(conn,
+				OFONO_SERVICE, NULL, OFONO_CALL_INTERFACE,
 				"PropertyChanged", call_changed, modem, NULL);
-	modem->audio_changed_watch =3D g_dbus_add_signal_watch(conn, NULL,
-				NULL, OFONO_AUDIO_INTERFACE,
+	modem->audio_changed_watch =3D g_dbus_add_signal_watch(conn,
+				OFONO_SERVICE, NULL, OFONO_AUDIO_INTERFACE,
 				"PropertyChanged", audio_changed, modem, NULL);
 =

 	g_hash_table_replace(modem_list, modem->path, modem);
-- =

1.7.11.1


--===============0806689649803951366==--


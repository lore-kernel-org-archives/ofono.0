Content-Type: multipart/mixed; boundary="===============4843310923740047961=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 4/5] bluetooth: fix crash by removing record
Date: Thu, 17 Feb 2011 19:00:48 -0300
Message-ID: <1297980049-30760-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297980049-30760-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4843310923740047961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When bluetoothd is not running we should not call RemoveRecord()
---
 plugins/bluetooth.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 161ae4b..5f2d80d 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -445,6 +445,9 @@ static void remove_record(struct server *server)
 {
 	DBusMessage *msg;
 =

+	if (server->handle =3D=3D 0)
+		return;
+
 	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, adapter_any_path,
 					BLUEZ_SERVICE_INTERFACE,
 					"RemoveRecord");
@@ -596,6 +599,13 @@ static void new_connection(GIOChannel *io, gpointer us=
er_data)
 					client_event, cbd);
 }
 =

+static void remove_service_handle(gpointer data, gpointer user_data)
+{
+	struct server *server =3D data;
+
+	server->handle =3D 0;
+}
+
 static void add_record_cb(DBusPendingCall *call, gpointer user_data)
 {
 	struct server *server =3D user_data;
@@ -767,6 +777,8 @@ static void bluetooth_disconnect(DBusConnection *connec=
tion, void *user_data)
 		return;
 =

 	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
+
+	g_slist_foreach(server_list, (GFunc) remove_service_handle, NULL);
 }
 =

 static guint bluetooth_watch;
-- =

1.7.4


--===============4843310923740047961==--


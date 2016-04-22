Content-Type: multipart/mixed; boundary="===============7951778772762949797=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 07/24] bluez4: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-8-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-7-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7951778772762949797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 plugins/bluez4.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/bluez4.c b/plugins/bluez4.c
index 6a29d9f..0558da3 100644
--- a/plugins/bluez4.c
+++ b/plugins/bluez4.c
@@ -225,8 +225,7 @@ void bluetooth_parse_properties(DBusMessage *reply, con=
st char *property, ...)
 	}
 =

 done:
-	g_slist_foreach(prop_handlers, (GFunc) g_free, NULL);
-	g_slist_free(prop_handlers);
+	g_slist_free_full(prop_handlers, g_free);
 }
 =

 static void parse_uuids(DBusMessageIter *array, gpointer user_data)
@@ -692,7 +691,7 @@ static void find_adapter_cb(DBusPendingCall *call, gpoi=
nter user_data)
 =

 	adapter_any_path =3D g_strdup(path);
 =

-	g_slist_foreach(server_list, (GFunc) add_record, NULL);
+	g_slist_foreach(server_list, add_record, NULL);
 =

 done:
 	dbus_message_unref(reply);
@@ -820,7 +819,7 @@ static void bluetooth_disconnect(DBusConnection *conn, =
void *user_data)
 =

 	g_hash_table_foreach(uuid_hash, bluetooth_remove, NULL);
 =

-	g_slist_foreach(server_list, (GFunc) remove_service_handle, NULL);
+	g_slist_foreach(server_list, remove_service_handle, NULL);
 }
 =

 static guint bluetooth_watch;
-- =

1.9.1

--===============7951778772762949797==--


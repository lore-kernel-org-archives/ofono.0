Content-Type: multipart/mixed; boundary="===============2040542839119492476=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 5/8] handsfree-audio: Add function to append properties
Date: Mon, 25 Feb 2013 11:34:18 -0300
Message-ID: <1361802861-18267-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2040542839119492476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds a common function to append Handsfree Audio Card properties used
when replying GetProperties and emitting CardAdded signal.
---
 src/handsfree-audio.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 64d1ed0..2a4b3d5 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -84,6 +84,24 @@ static void agent_disconnect(DBusConnection *conn, void =
*user_data)
 	agent =3D NULL;
 }
 =

+static void card_append_properties(DBusMessageIter *iter,
+						struct ofono_modem *modem)
+{
+	DBusMessageIter dict;
+	const char *address;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	address =3D ofono_modem_get_string(modem, "Remote");
+
+	ofono_dbus_dict_append(&dict, "RemoteAddress",
+					DBUS_TYPE_STRING, &address);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -183,10 +201,8 @@ static DBusMessage *card_get_properties(DBusConnection=
 *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
-	const char *address;
 	DBusMessage *reply;
 	DBusMessageIter iter;
-	DBusMessageIter dict;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -194,16 +210,7 @@ static DBusMessage *card_get_properties(DBusConnection=
 *conn,
 =

 	dbus_message_iter_init_append(reply, &iter);
 =

-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-
-	address =3D ofono_modem_get_string(modem, "Remote");
-
-	ofono_dbus_dict_append(&dict, "RemoteAddress",
-					DBUS_TYPE_STRING, &address);
-
-	dbus_message_iter_close_container(&iter, &dict);
+	card_append_properties(&iter, modem);
 =

 	return reply;
 }
@@ -219,8 +226,6 @@ static void am_emit_card_added(const char *path, struct=
 ofono_modem *modem)
 {
 	DBusMessage *signal;
 	DBusMessageIter iter;
-	DBusMessageIter dict;
-	const char *address;
 =

 	signal =3D dbus_message_new_signal("/", HFP_AUDIO_MANAGER_INTERFACE,
 								"CardAdded");
@@ -233,16 +238,7 @@ static void am_emit_card_added(const char *path, struc=
t ofono_modem *modem)
 =

 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
 =

-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-
-	address =3D ofono_modem_get_string(modem, "Remote");
-
-	ofono_dbus_dict_append(&dict, "RemoteAddress",
-					DBUS_TYPE_STRING, &address);
-
-	dbus_message_iter_close_container(&iter, &dict);
+	card_append_properties(&iter, modem);
 =

 	g_dbus_send_message(ofono_dbus_get_connection(), signal);
 }
-- =

1.7.11.7


--===============2040542839119492476==--


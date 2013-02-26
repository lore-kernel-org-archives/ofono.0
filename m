Content-Type: multipart/mixed; boundary="===============9142651516992381378=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 9/9] handsfree-audio: Add Audio Manager GetCards
Date: Tue, 26 Feb 2013 10:50:53 -0300
Message-ID: <1361886653-30873-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9142651516992381378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Handsfree Audio Manager GetCards() method
implementation. It returns an array of Audio Cards, where each
entry is composed by the object path of the Audio Card, and a
dictionary of it's properties.
---
 src/handsfree-audio.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index d839131..b562859 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -111,10 +111,54 @@ static void card_append_properties(DBusMessageIter *i=
ter,
 	dbus_message_iter_close_container(iter, &dict);
 }
 =

+static void hash_card_entry(gpointer key, gpointer value, gpointer user_da=
ta)
+{
+	const char *path =3D key;
+	struct audio_card *card =3D value;
+	DBusMessageIter entry, *array =3D user_data;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_STRUCT,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH, &path);
+
+	card_append_properties(&entry, card);
+
+	dbus_message_iter_close_container(array, &entry);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return __ofono_error_not_implemented(msg);
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	/*
+	 * a{oa{sv}}: Array of cards containing the object path of the
+	 * Audio Card and a dictionary of it's properties
+	 */
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&array);
+
+	g_hash_table_foreach(cards_hash, hash_card_entry, &iter);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
 }
 =

 static DBusMessage *am_agent_register(DBusConnection *conn,
-- =

1.7.11.7


--===============9142651516992381378==--


Content-Type: multipart/mixed; boundary="===============7781948343469985353=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 8/8] handsfree-audio: Add GetCards
Date: Mon, 25 Feb 2013 11:34:21 -0300
Message-ID: <1361802861-18267-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7781948343469985353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Handsfree Audio Manager GetCards() method
implementation. It returns an array of Audio Cards, where each entry in
the array is the object path of the Audio Card and a dictionary of it's
properties.
---
 src/handsfree-audio.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 9db2a83..623cfe5 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -103,10 +103,55 @@ static void card_append_properties(DBusMessageIter *i=
ter,
 	dbus_message_iter_close_container(iter, &dict);
 }
 =

+static void append_card(gpointer data, gpointer user_data)
+{
+	struct ofono_atom *atom =3D data;
+	DBusMessageIter *array =3D user_data;
+	const char *path =3D __ofono_atom_get_path(atom);
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_STRUCT,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH, &path);
+
+	card_append_properties(&entry, __ofono_atom_get_modem(atom));
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
+	g_slist_foreach(cards, append_card, &array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
 }
 =

 static DBusMessage *am_agent_register(DBusConnection *conn,
-- =

1.7.11.7


--===============7781948343469985353==--


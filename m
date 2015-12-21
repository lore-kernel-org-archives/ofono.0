Content-Type: multipart/mixed; boundary="===============3837895315846595894=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] gprs: Make the ContextAdded return a variant.
Date: Mon, 21 Dec 2015 10:10:55 +0000
Message-ID: <1450692676-30962-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3837895315846595894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

This matches the behavior described by the documentation and the signal
value described in the introspection. This was causing a headache when
using stricter D-Bus wrappers like dbus-c++.
---
 src/gprs.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index ba797dd..b583c28 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1879,7 +1879,17 @@ static void send_context_added_signal(struct ofono_g=
prs *gprs,
 	const char *path;
 	DBusMessage *signal;
 	DBusMessageIter iter;
+	DBusMessageIter var;
 	DBusMessageIter dict;
+	char typesig[5];
+	char arraysig[6];
+
+	arraysig[0] =3D DBUS_TYPE_ARRAY;
+	arraysig[1] =3D typesig[0] =3D DBUS_DICT_ENTRY_BEGIN_CHAR;
+	arraysig[2] =3D typesig[1] =3D DBUS_TYPE_STRING;
+	arraysig[3] =3D typesig[2] =3D DBUS_TYPE_VARIANT;
+	arraysig[4] =3D typesig[3] =3D DBUS_DICT_ENTRY_END_CHAR;
+	arraysig[5] =3D typesig[4] =3D '\0';
 =

 	path =3D __ofono_atom_get_path(gprs->atom);
 	signal =3D dbus_message_new_signal(path,
@@ -1893,11 +1903,15 @@ static void send_context_added_signal(struct ofono_=
gprs *gprs,
 	path =3D context->path;
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
 =

-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+					arraysig, &var);
+
+	dbus_message_iter_open_container(&var, DBUS_TYPE_ARRAY,
+					typesig,
 					&dict);
 	append_context_properties(context, &dict);
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_close_container(&var, &dict);
+	dbus_message_iter_close_container(&iter, &var);
 =

 	g_dbus_send_message(conn, signal);
 }
-- =

1.9.1

--===============3837895315846595894==--


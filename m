Content-Type: multipart/mixed; boundary="===============6576929780434479860=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 20:16:50 -0200
Message-ID: <1294179410-3857-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294171882.5852.105.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6576929780434479860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to dbus documentation, dbus_message_iter_append_basic()
expects a "const char**" if type is string and a simple pointer for
other types. Since we a iterating an array, the value passed is already
a pointer.
---
 src/dbus.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index c24615f..b719217 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -139,8 +139,24 @@ static void append_dict_variant(DBusMessageIter *iter,=
 int type, void *val)
 =

 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
 						&(val_array[i + 0]));
-		dbus_message_iter_append_basic(&entry, type,
-						&(val_array[i + 1]));
+
+		/*
+		 * D-Bus expects a char** or uint8* depending on the type
+		 * given. Since we are dealing with an array through a void**
+		 * (and thus val_array[i] is a pointer) we need to
+		 * differentiate DBUS_TYPE_STRING from the others. The other
+		 * option would be the user to pass the exact type to this
+		 * function, instead of a pointer to it. However in this case
+		 * a cast from type to void* would be needed, which is not
+		 * good.
+		 */
+		if (type =3D=3D DBUS_TYPE_STRING) {
+			dbus_message_iter_append_basic(&entry, type,
+							&(val_array[i + 1]));
+		} else {
+			dbus_message_iter_append_basic(&entry, type,
+							val_array[i + 1]);
+		}
 =

 		dbus_message_iter_close_container(&array, &entry);
 	}
-- =

1.7.3.4


--===============6576929780434479860==--


Content-Type: multipart/mixed; boundary="===============9212742281780818650=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/15] emulator: Add get properities for emulator
Date: Wed, 07 Jul 2010 18:01:41 +0800
Message-ID: <1278496912-13777-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9212742281780818650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

oFono properties:
"Powered": Whether the emulator is powered on.
"Type": Type could be one of supported emulator type, default is DUN.
---
 src/emulator.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 7551eb6..86a2eee 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -288,7 +288,33 @@ error:
 static DBusMessage *emulator_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return dbus_message_new_method_return(msg);
+	struct ofono_emulator *e =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *type_str;
+	int type;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN,
+					&e->powered);
+
+	type =3D e->driver->type;
+	type_str =3D ofono_emulator_type_to_str(type);
+	ofono_dbus_dict_append(&dict, "Type", DBUS_TYPE_STRING, &type_str);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
 }
 =

 static DBusMessage *emulator_enable(DBusConnection *conn,
-- =

1.6.3.3


--===============9212742281780818650==--


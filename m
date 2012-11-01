Content-Type: multipart/mixed; boundary="===============2928632327917281251=="
MIME-Version: 1.0
From: Holger Hans Peter Freyther <holger@freyther.de>
Subject: [PATCH] modem: Make it possible to identify the physical device of
 the modem
Date: Thu, 01 Nov 2012 11:39:28 +0100
Message-ID: <1351766368-30075-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2928632327917281251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Holger Hans Peter Freyther <hfreyther@sysmocom.de>

The naming of modems might not reflect the physical order of devices.
E.g. /dev/ttyUSB0 might end up as /wavecom_3 and /dev/ttyUSB2 might be
/wavecom_1. Add a 'Device' property to be able to identify the port.

An application can then use sysfs to identify the bus and device to
rebuild the physical order. This way we can map the modem path to the
port number on our modem bank.
---
 doc/modem-api.txt |    5 +++++
 src/modem.c       |    6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 1c4e440..68e719e 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -168,3 +168,8 @@ Properties	boolean Powered [readwrite]
 			supported by this modem.
 =

 			Possible values are "hfp", "sap" and "hardware".
+
+		string Device [readonly, optional]
+
+			The physical device the modem is connected to. This
+			can be used to identify the physical port of the modem.
diff --git a/src/modem.c b/src/modem.c
index db62e2d..e542fac 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -771,6 +771,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	struct ofono_devinfo *info;
 	dbus_bool_t emergency =3D ofono_modem_get_emergency_mode(modem);
 	const char *strtype;
+	const char *device;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -826,6 +827,11 @@ void __ofono_modem_append_properties(struct ofono_mode=
m *modem,
 =

 	strtype =3D modem_type_to_string(modem->driver->modem_type);
 	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING, &strtype);
+
+	device =3D ofono_modem_get_string(modem, "Device");
+	if (device)
+		ofono_dbus_dict_append(dict, "Device", DBUS_TYPE_STRING,
+					&device);
 }
 =

 static DBusMessage *modem_get_properties(DBusConnection *conn,
-- =

1.7.10.4


--===============2928632327917281251==--


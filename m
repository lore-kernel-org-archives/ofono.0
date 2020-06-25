Content-Type: multipart/mixed; boundary="===============0013428435462579829=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH 1/2] modem: add a driver reset function
Date: Thu, 25 Jun 2020 11:28:50 +0200
Message-ID: <20200625092851.4548-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0013428435462579829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a reset function to the modem driver. This function can be used to hard
reset the device. This is an alternative in case the (*enable) and
(*disable) functions are not supported.

A reset will not work when emergency mode is active.

For dbus: dbus-send \
			--system \
			--print-reply \
			--dest=3Dorg.ofono \
			<modem_path> \
			org.ofono.Modem.Reset
---
 include/modem.h |  3 +++
 src/modem.c     | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/modem.h b/include/modem.h
index 9b12cfad..519ffe97 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -75,6 +75,9 @@ struct ofono_modem_driver {
 =

 	/* Populate the atoms available online */
 	void (*post_online)(struct ofono_modem *modem);
+
+	/* Reset device */
+	int (*reset)(struct ofono_modem *modem);
 };
 =

 void ofono_modem_add_interface(struct ofono_modem *modem,
diff --git a/src/modem.c b/src/modem.c
index 52988cf3..8c633edb 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1082,6 +1082,24 @@ done:
 	return NULL;
 }
 =

+static DBusMessage *modem_reset(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	const struct ofono_modem_driver *driver =3D modem->driver;
+
+	if (ofono_modem_get_emergency_mode(modem) =3D=3D TRUE)
+		return __ofono_error_emergency_active(msg);
+
+	if (!driver->reset)
+		return __ofono_error_not_implemented(msg);
+
+	if (driver->reset(modem))
+		return __ofono_error_failed(msg);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *modem_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1179,6 +1197,8 @@ static const GDBusMethodTable modem_methods[] =3D {
 	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, modem_set_property) },
+	{ GDBUS_METHOD("Reset",
+			NULL, NULL, modem_reset) },
 	{ }
 };
 =

-- =

2.17.1

--===============0013428435462579829==--


Content-Type: multipart/mixed; boundary="===============6685003720093834295=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 03/11] hfp_hf: Add parsing of Profile NewConnection call
Date: Thu, 22 Nov 2012 14:53:20 -0300
Message-ID: <1353606808-25032-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353606808-25032-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6685003720093834295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the parsing of the mandatory arguments in NewConnection
method call implemented in Profile1 interface.
---
 plugins/bluetooth.h |  1 +
 plugins/hfp_hf.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 96f3a53..a9355f6 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -24,6 +24,7 @@
 =

 #define	BLUEZ_SERVICE "org.bluez"
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define	BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
 #define	BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 405ada2..edb7671 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -342,8 +342,41 @@ static int hfp_unregister_ofono_handsfree(struct ofono=
_modem *modem)
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
+	struct ofono_modem *modem;
+	const char *device;
+	DBusMessageIter entry;
+	int fd;
+
 	DBG("Profile handler NewConnection");
+
+	if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
+		goto error;
+
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto error;
+
+	dbus_message_iter_get_basic(&entry, &device);
+	modem =3D g_hash_table_lookup(modem_hash, device);
+	if (modem =3D=3D NULL) {
+		DBG("%s: modem not found", device);
+		goto error;
+	}
+
+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
+		goto error;
+
+	dbus_message_iter_get_basic(&entry, &fd);
+	if (fd < 0)
+		goto error;
+
+	DBG("modem %p, SLC FD: %d", modem, fd);
+
 	return dbus_message_new_method_return(msg);
+
+error:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static DBusMessage *profile_release(DBusConnection *conn,
-- =

1.7.11.7


--===============6685003720093834295==--


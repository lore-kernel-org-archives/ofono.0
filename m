Content-Type: multipart/mixed; boundary="===============8755959858065019192=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 03/14] hfp_hf: Add parsing of Profile NewConnection call
Date: Mon, 03 Dec 2012 10:11:44 -0300
Message-ID: <1354540315-27731-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8755959858065019192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the parsing of the mandatory arguments in NewConnection
method call implemented in Profile1 interface.
---
 plugins/hfp_hf.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 6836c45..03f3371 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -342,10 +342,41 @@ static int hfp_unregister_ofono_handsfree(struct ofon=
o_modem *modem)
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
+	struct ofono_modem *modem;
+	const char *device;
+	DBusMessageIter entry;
+	int fd;
+
 	DBG("Profile handler NewConnection");
-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".NotImplemented",
-					"Implementation not provided");
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
+	return dbus_message_new_method_return(msg);
+
+error:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static DBusMessage *profile_release(DBusConnection *conn,
-- =

1.7.11.7


--===============8755959858065019192==--


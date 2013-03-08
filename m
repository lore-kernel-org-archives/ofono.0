Content-Type: multipart/mixed; boundary="===============3440910532503197872=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 03/13] hfp_hf_bluez5: Add extracting version
Date: Fri, 08 Mar 2013 20:11:15 -0300
Message-ID: <1362784285-22731-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3440910532503197872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch parses and reads the profile "Version" that comes in the fd
dictionary of the NewConnection method. "Version" is input for Audio Card
registration.
---
 plugins/hfp_hf_bluez5.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 0b9061d..56aa7ef 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -343,6 +343,37 @@ static ofono_bool_t device_path_compare(struct ofono_m=
odem *modem,
 	return g_str_equal(path, value);
 }
 =

+static int get_version(DBusMessageIter *iter, uint16_t *version)
+{
+	DBusMessageIter dict, entry, valiter;
+	const char *key;
+	uint16_t value;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	/* Dict entry key */
+	dbus_message_iter_recurse(&dict, &entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
+		return -EINVAL;
+
+	dbus_message_iter_get_basic(&entry, &key);
+	if (g_str_equal("Version", key) =3D=3D FALSE)
+		return -EINVAL;
+
+	/* Dict entry value */
+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(&entry, &valiter);
+	dbus_message_iter_get_basic(&valiter, &value);
+
+	if (version)
+		*version =3D value;
+
+	return 0;
+}
+
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -353,6 +384,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	DBusMessageIter entry;
 	const char *device;
 	char local[18], remote[18];
+	uint16_t version;
 	int fd, err;
 =

 	DBG("Profile handler NewConnection");
@@ -373,6 +405,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto invalid;
 =

+	dbus_message_iter_next(&entry);
+
+	if (get_version(&entry, &version) < 0)
+		goto invalid;
+
 	modem =3D ofono_modem_find(device_path_compare, (void *) device);
 	if (modem =3D=3D NULL) {
 		close(fd);
-- =

1.7.11.7


--===============3440910532503197872==--


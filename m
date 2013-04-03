Content-Type: multipart/mixed; boundary="===============6272010535885040334=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/5] hfp_hf_bluez5: Add extracting version
Date: Wed, 03 Apr 2013 20:24:37 -0300
Message-ID: <1365031481-10467-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6272010535885040334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch parses and reads the profile "Version" that comes in the fd
dictionary of the NewConnection method. "Version" is input for Audio Card
registration.
---
 plugins/hfp_hf_bluez5.c | 49 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f068c70..a6cc156 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -350,6 +350,45 @@ static ofono_bool_t device_path_compare(struct ofono_m=
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
+	/* Points to dict */
+	dbus_message_iter_recurse(iter, &dict);
+
+	/* For each entry in this dict */
+	while (dbus_message_iter_get_arg_type(&dict) !=3D DBUS_TYPE_INVALID) {
+		/* I want to access the entry's contents */
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
+			return -EINVAL;
+
+		/* If the current key isn't "Version", keep looking */
+		dbus_message_iter_get_basic(&entry, &key);
+		if (!g_str_equal("Version", key)) {
+			dbus_message_iter_next(&dict);
+			continue;
+		}
+
+		dbus_message_iter_next(&entry);
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+			return -EINVAL;
+
+		dbus_message_iter_recurse(&entry, &valiter);
+		dbus_message_iter_get_basic(&valiter, &value);
+		break;
+	}
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
@@ -360,6 +399,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	DBusMessageIter entry;
 	const char *device;
 	char local[18], remote[18];
+	uint16_t version =3D HFP_VERSION_1_5;
 	int fd, err;
 =

 	DBG("Profile handler NewConnection");
@@ -380,6 +420,13 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto invalid;
 =

+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_ARRAY)
+		goto invalid;
+
+	if (get_version(&entry, &version) < 0)
+		goto invalid;
+
 	modem =3D ofono_modem_find(device_path_compare, (void *) device);
 	if (modem =3D=3D NULL) {
 		close(fd);
@@ -388,7 +435,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 					"Unknown Bluetooth device");
 	}
 =

-	err =3D service_level_connection(modem, fd, HFP_VERSION_LATEST);
+	err =3D service_level_connection(modem, fd, version);
 	if (err < 0 && err !=3D -EINPROGRESS) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-- =

1.8.2


--===============6272010535885040334==--


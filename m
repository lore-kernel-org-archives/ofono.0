Content-Type: multipart/mixed; boundary="===============8902662368984662926=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 12/22] hfp_ag_bluez5: Send HFP version to card creation
Date: Thu, 16 May 2013 14:16:32 -0300
Message-ID: <1368724602-27781-13-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8902662368984662926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extract the version from the fd_properties dictionary, if present.
Fallback to HFP version 1.5 if not present.

After that, send it to the card creation.
---
 plugins/hfp_ag_bluez5.c |   47 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 6451be4..4523165 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -70,6 +70,45 @@ static gboolean io_hup_cb(GIOChannel *io, GIOCondition c=
ond, gpointer data)
 	return FALSE;
 }
 =

+static int get_version(DBusMessageIter *iter, uint16_t *version)
+{
+	DBusMessageIter dict, entry, valiter;
+	const char *key;
+	uint16_t value =3D HFP_VERSION_1_5;
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
 						DBusMessage *msg, void *data)
 {
@@ -79,6 +118,7 @@ static DBusMessage *profile_new_connection(DBusConnectio=
n *conn,
 	int fd, fd_dup;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	uint16_t version;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -100,6 +140,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto invalid;
 =

+	if (get_version(&entry, &version) < 0) {
+		close(fd);
+		goto invalid;
+	}
+
 	DBG("%s", device);
 =

 	/* Pick the first voicecall capable modem */
@@ -123,7 +168,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	ofono_emulator_register(em, fd);
 =

-	if (ofono_emulator_create_card(em, 0) < 0) {
+	if (ofono_emulator_create_card(em, version) < 0) {
 		close(fd);
 		ofono_emulator_remove(em);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-- =

1.7.9.5


--===============8902662368984662926==--


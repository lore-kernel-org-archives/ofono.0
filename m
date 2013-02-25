Content-Type: multipart/mixed; boundary="===============5838864589694968534=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/8] handsfree-audio: Add Audio Card GetProperties
Date: Mon, 25 Feb 2013 11:34:16 -0300
Message-ID: <1361802861-18267-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5838864589694968534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial implementation of the GetProperties method
of the Handsfree Audio Card. Only the Bluetooth address of the remote
peer is supported, the local adapter address requires changes in
hfp_hf_bluez5 plugin.
---
 src/handsfree-audio.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index d14a767..cdb8f8f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -176,7 +176,30 @@ static const GDBusMethodTable am_methods[] =3D {
 static DBusMessage *card_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return __ofono_error_not_implemented(msg);
+	struct ofono_modem *modem =3D user_data;
+	const char *address;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	address =3D ofono_modem_get_string(modem, "Remote");
+
+	ofono_dbus_dict_append(&dict, "RemoteAddress",
+					DBUS_TYPE_STRING, &address);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
 }
 =

 static const GDBusMethodTable card_methods[] =3D {
@@ -189,12 +212,13 @@ static const GDBusMethodTable card_methods[] =3D {
 static void handsfree_modem_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *user_data)
 {
+	struct ofono_modem *modem =3D user_data;
 	const char *path =3D __ofono_atom_get_path(atom);
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
 		g_dbus_register_interface(ofono_dbus_get_connection(), path,
 					HFP_AUDIO_CARD_INTERFACE, card_methods,
-					NULL, NULL, NULL, NULL);
+					NULL, NULL, modem, NULL);
 =

 		DBG("Audio Card added: %s", path);
 	} else {
-- =

1.7.11.7


--===============5838864589694968534==--


Content-Type: multipart/mixed; boundary="===============1372189905024999141=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/4] hfp_hf_bluez5: Add Profile RequestDisconnection
Date: Fri, 01 Feb 2013 20:33:08 -0300
Message-ID: <1359761589-18561-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359761589-18561-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1372189905024999141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch implements RequestDisconnection method of the Profile1
interface. This method gets called when the profile gets disconnected.
The profile implementation needs to cleanup the resources related to
the informed device.
---
 plugins/hfp_hf_bluez5.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index cd3f9a6..0d6bdd9 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -340,11 +340,40 @@ static DBusMessage *profile_cancel(DBusConnection *co=
nn,
 static DBusMessage *profile_disconnection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct ofono_modem *modem;
+	struct hfp *hfp;
+	const char *device;
+	struct hfp_slc_info *info;
+	DBusMessageIter entry;
+
 	DBG("Profile handler RequestDisconnection");
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".NotImplemented",
-					"Implementation not provided");
+	if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
+		goto error;
+
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto error;
+
+	dbus_message_iter_get_basic(&entry, &device);
+
+	modem =3D g_hash_table_lookup(modem_hash, device);
+	if (modem =3D=3D NULL)
+		goto error;
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	hfp =3D ofono_modem_get_data(modem);
+	info =3D &hfp->info;
+
+	g_at_chat_unref(info->chat);
+	info->chat =3D NULL;
+
+	return dbus_message_new_method_return(msg);
+
+error:
+	return g_dbus_create_error(msg,
+			BLUEZ_ERROR_INTERFACE ".Rejected",
+			"Invalid arguments in method call");
 }
 =

 static const GDBusMethodTable profile_methods[] =3D {
-- =

1.8.1.1


--===============1372189905024999141==--


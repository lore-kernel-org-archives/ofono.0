Content-Type: multipart/mixed; boundary="===============5047382244820952133=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/2] hfp_hf_bluez5: Fix registering modem on NewConnection
Date: Thu, 31 Jan 2013 16:01:53 -0300
Message-ID: <1359658914-24892-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5047382244820952133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HFP modem will be registered when Proxy Added callback gets called
or when Pair is True. This patch removes the support for dynamic modem
registration when a new connection is notified and there isn't a modem
associated with the Bluetooth remote device.

BlueZ behaviour has been changed and a NewConnection is not notified
before the service discovery finishes.
---
 plugins/hfp_hf_bluez5.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index ff4dbad..d2f3abb 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -270,10 +270,8 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 {
 	struct hfp *hfp;
 	struct ofono_modem *modem;
-	DBusMessageIter iter;
-	GDBusProxy *proxy;
 	DBusMessageIter entry;
-	const char *device, *alias, *address;
+	const char *device;
 	int fd, err;
 =

 	DBG("Profile handler NewConnection");
@@ -286,21 +284,6 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	dbus_message_iter_get_basic(&entry, &device);
 =

-	proxy =3D g_hash_table_lookup(devices_proxies, device);
-	if (proxy =3D=3D NULL)
-		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".Rejected",
-					"Unknown Bluetooth device");
-
-	g_dbus_proxy_get_property(proxy, "Alias", &iter);
-
-	dbus_message_iter_get_basic(&iter, &alias);
-
-	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
-		goto invalid;
-
-	dbus_message_iter_get_basic(&iter, &address);
-
 	dbus_message_iter_next(&entry);
 	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
 		goto invalid;
@@ -309,12 +292,12 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 	if (fd < 0)
 		goto invalid;
 =

-	modem =3D modem_register(device, address, alias);
+	modem =3D g_hash_table_lookup(modem_hash, device);
 	if (modem =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
 					".Rejected",
-					"Could not register HFP modem");
+					"Unknown Bluetooth device");
 	}
 =

 	err =3D service_level_connection(modem, fd, HFP_VERSION_LATEST);
-- =

1.7.11.7


--===============5047382244820952133==--


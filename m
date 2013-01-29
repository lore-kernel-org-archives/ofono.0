Content-Type: multipart/mixed; boundary="===============8520010718855653445=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/4] hfp_hf_bluez5: Set the 'Remote' and 'Local' properties
Date: Tue, 29 Jan 2013 17:38:38 -0300
Message-ID: <1359491920-15963-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359491920-15963-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8520010718855653445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

On modem registration, set both these properties so later on, the modem can=
 be
fully indentified by both addresses. For example, if an incoming SCO connec=
tion
comes and do not match this pair, the connection will be rejected.
---
 plugins/hfp_hf_bluez5.c | 55 +++++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index c4a3f32..49a84c5 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -166,15 +166,22 @@ static int service_level_connection(struct ofono_mode=
m *modem,
 	return -EINPROGRESS;
 }
 =

-static struct ofono_modem *modem_register(const char *device,
-				const char *device_address, const char *alias)
+static struct ofono_modem *modem_register(const char *device, const char *=
local,
+				const char *remote, const char *alias)
 {
 	struct ofono_modem *modem;
 	char *path;
 =

 	modem =3D g_hash_table_lookup(modem_hash, device);
-	if (modem !=3D NULL)
+	if (modem !=3D NULL) {
+		/*
+		 * When the modem is created, it may be created with
+		 * only the Remote property, in the case that the modem
+		 * was registered from a device proxy
+		 */
+		ofono_modem_set_string(modem, "Local", local);
 		return modem;
+	}
 =

 	path =3D g_strconcat("hfp", device, NULL);
 =

@@ -185,7 +192,9 @@ static struct ofono_modem *modem_register(const char *d=
evice,
 	if (modem =3D=3D NULL)
 		return NULL;
 =

-	ofono_modem_set_string(modem, "Remote", device_address);
+	/* The "Remote" property needs to be available before pre-sim */
+	ofono_modem_set_string(modem, "Local", local);
+	ofono_modem_set_string(modem, "Remote", remote);
 =

 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
@@ -275,14 +284,15 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 {
 	struct hfp *hfp;
 	struct ofono_modem *modem;
+	struct sockaddr_rc laddr, raddr;
+	socklen_t alen;
 	DBusMessageIter iter;
 	GDBusProxy *proxy;
 	DBusMessageIter entry;
-	const char *device, *alias, *address;
+	const char *device, *alias;
+	char local[18], remote[18];
 	int fd, err;
 =

-	DBG("Profile handler NewConnection");
-
 	if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
 		goto invalid;
 =

@@ -301,11 +311,6 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	dbus_message_iter_get_basic(&iter, &alias);
 =

-	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
-		goto invalid;
-
-	dbus_message_iter_get_basic(&iter, &address);
-
 	dbus_message_iter_next(&entry);
 	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
 		goto invalid;
@@ -314,7 +319,25 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto invalid;
 =

-	modem =3D modem_register(device, address, alias);
+	memset(&laddr, 0, sizeof(laddr));
+	alen =3D sizeof(laddr);
+	if (getsockname(fd, (struct sockaddr *) &laddr, &alen) < 0) {
+		close(fd);
+		goto invalid;
+	}
+
+	memset(&raddr, 0, sizeof(raddr));
+	alen =3D sizeof(raddr);
+	if (getpeername(fd, (struct sockaddr *) &raddr, &alen) < 0) {
+		close(fd);
+		goto invalid;
+	}
+
+	bt_ba2str(&laddr.rc_bdaddr, local);
+	bt_ba2str(&raddr.rc_bdaddr, remote);
+	DBG("Profile handler NewConnection: %s", remote);
+
+	modem =3D modem_register(device, local, remote, alias);
 	if (modem =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
@@ -479,7 +502,7 @@ static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
 =

 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	const char *interface, *path, *alias, *address;
+	const char *interface, *path, *alias, *remote;
 	DBusMessageIter iter;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
@@ -507,9 +530,9 @@ static void proxy_added(GDBusProxy *proxy, void *user_d=
ata)
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
 		return;
 =

-	dbus_message_iter_get_basic(&iter, &address);
+	dbus_message_iter_get_basic(&iter, &remote);
 =

-	modem_register(path, address, alias);
+	modem_register(path, NULL, remote, alias);
 }
 =

 static void proxy_removed(GDBusProxy *proxy, void *user_data)
-- =

1.7.11.7


--===============8520010718855653445==--


Content-Type: multipart/mixed; boundary="===============2928022877928851193=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 8/9] hfp_hf_bluez5: Reject SCO if source doesn't match
Date: Mon, 28 Jan 2013 11:44:18 -0300
Message-ID: <1359384259-5384-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359384259-5384-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2928022877928851193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implements additional verification checking the Bluetooth
source address instead of the remote address only.
---
 plugins/hfp_hf_bluez5.c | 64 ++++++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index d79647b..504b0f3 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -60,6 +60,12 @@
 struct hfp {
 	struct hfp_slc_info info;
 	DBusMessage *msg;
+	char adapter[18];
+};
+
+struct bt_peer {
+	char adapter[18];
+	char device[18];
 };
 =

 static GHashTable *modem_hash =3D NULL;
@@ -70,11 +76,18 @@ static guint sco_watch =3D 0;
 static gboolean modem_address_cmp(gpointer key, gpointer value,
 						gpointer user_data)
 {
-	const char *dst =3D user_data;
+	const struct bt_peer *bt_peer =3D user_data;
 	struct ofono_modem *modem =3D value;
-	const char *address =3D ofono_modem_get_string(modem, "Address");
+	const char *device =3D ofono_modem_get_string(modem, "Address");
+	struct hfp *hfp;
+	gboolean ret;
 =

-	return g_strcmp0(address, dst) !=3D 0 ? FALSE : TRUE;
+	ret =3D g_strcmp0(device, bt_peer->device);
+	if (ret !=3D 0)
+		return FALSE;
+
+	hfp =3D ofono_modem_get_data(modem);
+	return g_strcmp0(hfp->adapter, bt_peer->adapter) !=3D 0 ? FALSE : TRUE;
 }
 =

 static void hfp_debug(const char *str, void *user_data)
@@ -284,14 +297,14 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 {
 	struct hfp *hfp;
 	struct ofono_modem *modem;
+	struct sockaddr_rc src, dst;
 	DBusMessageIter iter;
 	GDBusProxy *proxy;
 	DBusMessageIter entry;
-	const char *device, *alias, *address;
+	const char *device, *alias;
+	char device_address[18];
 	int fd, err;
 =

-	DBG("Profile handler NewConnection");
-
 	if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
 		goto invalid;
 =

@@ -310,11 +323,6 @@ static DBusMessage *profile_new_connection(DBusConnect=
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
@@ -323,7 +331,13 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto invalid;
 =

-	modem =3D modem_register(device, address, alias);
+	if (bt_getsockpeers(fd, (struct sockaddr *) &src,
+				(struct sockaddr *) &dst,
+				sizeof(struct sockaddr_rc)) < 0)
+		goto invalid;
+
+	bt_ba2str(&dst.rc_bdaddr, device_address);
+	modem =3D modem_register(device, device_address, alias);
 	if (modem =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
@@ -339,6 +353,9 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
+	bt_ba2str(&src.rc_bdaddr, hfp->adapter);
+
+	DBG("Profile handler NewConnection: %s", device_address);
 =

 	return NULL;
 =

@@ -394,9 +411,9 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 							gpointer user_data)
 {
 	struct ofono_modem *modem;
-	struct sockaddr_sco saddr;
+	struct sockaddr_sco src, dst;
+	struct bt_peer bt_peer;
 	socklen_t optlen;
-	char dst[18];
 	int sk, nsk;
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -404,15 +421,24 @@ static gboolean sco_accept(GIOChannel *io, GIOConditi=
on cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

-	memset(&saddr, 0, sizeof(saddr));
-	optlen =3D sizeof(saddr);
+	memset(&dst, 0, sizeof(dst));
+	optlen =3D sizeof(dst);
 =

-	nsk =3D accept(sk, (struct sockaddr *) &saddr, &optlen);
+	nsk =3D accept(sk, (struct sockaddr *) &dst, &optlen);
 	if (nsk < 0)
 		return TRUE;
 =

-	bt_ba2str(&saddr.sco_bdaddr, dst);
-	modem =3D g_hash_table_find(modem_hash, modem_address_cmp, dst);
+	if (bt_getsockpeers(nsk, (struct sockaddr *) &src, NULL, optlen) < 0) {
+		close(nsk);
+		return TRUE;
+	}
+
+	bt_ba2str(&src.sco_bdaddr, bt_peer.adapter);
+	bt_ba2str(&dst.sco_bdaddr, bt_peer.device);
+
+	DBG("SCO: %s < %s", bt_peer.adapter, bt_peer.device);
+
+	modem =3D g_hash_table_find(modem_hash, modem_address_cmp, &bt_peer);
 	if (modem =3D=3D NULL) {
 		ofono_error("Rejecting SCO: SLC connection missing!");
 		close(nsk);
-- =

1.7.11.7


--===============2928022877928851193==--


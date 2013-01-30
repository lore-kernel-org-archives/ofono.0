Content-Type: multipart/mixed; boundary="===============0317664075395659488=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 1/2] hfp_hf_bluez5: Add SLC hash table
Date: Wed, 30 Jan 2013 10:32:44 -0300
Message-ID: <1359552765-9851-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359552765-9851-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0317664075395659488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a service level connection hash table to track the
address of the active connections. For now, only one connection per
remote address is allowed. The remote address will be used as key,
and the local adapter address as hash entry value.
---
 plugins/hfp_hf_bluez5.c | 48 +++++++++++++++++++++++++++++++++++++++------=
---
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2aabdd2..45f4cdd 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -65,6 +65,7 @@ struct hfp {
 =

 static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
+static GHashTable *slc_hash =3D NULL;
 static GDBusClient *bluez =3D NULL;
 static guint sco_watch =3D 0;
 =

@@ -96,6 +97,7 @@ static void slc_failed(gpointer userdata)
 	struct ofono_modem *modem =3D userdata;
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
 	struct hfp_slc_info *info =3D &hfp->info;
+	const char *remote =3D ofono_modem_get_string(modem, "Remote");
 	DBusMessage *msg;
 =

 	msg =3D g_dbus_create_error(hfp->msg, BLUEZ_ERROR_INTERFACE
@@ -111,6 +113,8 @@ static void slc_failed(gpointer userdata)
 =

 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
+
+	g_hash_table_remove(slc_hash, remote);
 }
 =

 static void hfp_disconnected_cb(gpointer user_data)
@@ -118,6 +122,7 @@ static void hfp_disconnected_cb(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
 	struct hfp_slc_info *info =3D &hfp->info;
+	const char *remote =3D ofono_modem_get_string(modem, "Remote");
 =

 	DBG("HFP disconnected");
 =

@@ -125,6 +130,8 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
+
+	g_hash_table_remove(slc_hash, remote);
 }
 =

 static int service_level_connection(struct ofono_modem *modem,
@@ -212,6 +219,7 @@ static void hfp_remove(struct ofono_modem *modem)
 {
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
 	struct hfp_slc_info *info =3D &hfp->info;
+	const char *remote =3D ofono_modem_get_string(modem, "Remote");
 =

 	DBG("modem: %p", modem);
 =

@@ -223,6 +231,8 @@ static void hfp_remove(struct ofono_modem *modem)
 	g_free(hfp);
 =

 	ofono_modem_set_data(modem, NULL);
+
+	g_hash_table_remove(slc_hash, remote);
 }
 =

 /* power up hardware */
@@ -275,14 +285,15 @@ static DBusMessage *profile_new_connection(DBusConnec=
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

@@ -301,11 +312,6 @@ static DBusMessage *profile_new_connection(DBusConnect=
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
@@ -314,7 +320,25 @@ static DBusMessage *profile_new_connection(DBusConnect=
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
+	modem =3D modem_register(device, remote, alias);
 	if (modem =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
@@ -333,6 +357,8 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	hfp =3D ofono_modem_get_data(modem);
 	hfp->msg =3D dbus_message_ref(msg);
 =

+	g_hash_table_insert(slc_hash, g_strdup(remote), g_strdup(local));
+
 	return NULL;
 =

 invalid:
@@ -607,6 +633,9 @@ static int hfp_init(void)
 	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 				g_free, (GDestroyNotify) g_dbus_proxy_unref);
 =

+	slc_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+								g_free);
+
 	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
 						property_changed, NULL);
@@ -626,6 +655,7 @@ static void hfp_exit(void)
 =

 	g_hash_table_destroy(modem_hash);
 	g_hash_table_destroy(devices_proxies);
+	g_hash_table_destroy(slc_hash);
 =

 	if (sco_watch > 0)
 		g_source_remove(sco_watch);
-- =

1.7.11.7


--===============0317664075395659488==--


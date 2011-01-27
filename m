Content-Type: multipart/mixed; boundary="===============7033089094557455303=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/4] bluetooth: use GSList instead of GHashTable to store
 adapter path/address
Date: Thu, 27 Jan 2011 16:05:38 +0100
Message-ID: <1296140740-11486-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1296140740-11486-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7033089094557455303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   86 +++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index e59bd31..4da662a 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -39,9 +39,14 @@
 =

 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
-static GHashTable *adapter_address_hash =3D NULL;
+static GSList *adapter_list =3D NULL;
 static gint bluetooth_refcount;
 =

+struct adapter_address {
+	char *adapter;
+	char *address;
+};
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -235,6 +240,52 @@ static void parse_string(DBusMessageIter *iter, gpoint=
er user_data)
 	dbus_message_iter_get_basic(iter, str);
 }
 =

+static gint adapter_compare(gconstpointer a, gconstpointer b)
+{
+	const struct adapter_address *entry =3D a;
+	const char *key =3D b;
+
+	return g_strcmp0(entry->adapter, key);
+}
+
+static GSList* adapter_address_add(GSList *list, const char *path,
+					const char *address)
+{
+	GSList *l;
+	struct adapter_address *entry;
+
+	l =3D g_slist_find_custom(adapter_list, path, adapter_compare);
+	if (l !=3D NULL) {
+		entry =3D l->data;
+
+		g_free(entry->address);
+
+		entry->address =3D g_strdup(address);
+
+		return list;
+	}
+
+	entry =3D g_try_new0(struct adapter_address, 1);
+	if (entry =3D=3D NULL) {
+		ofono_error("Unable to allocate adapter_address structure");
+		return list;
+	}
+
+	entry->adapter =3D g_strdup(path);
+	entry->address =3D g_strdup(address);
+
+	return g_slist_prepend(list, entry);
+}
+
+static GSList* adapter_address_remove(GSList *l, struct adapter_address *e=
ntry)
+{
+	g_free(entry->adapter);
+	g_free(entry->address);
+	g_free(entry);
+
+	return g_slist_remove(l, entry);
+}
+
 static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
@@ -245,6 +296,7 @@ static void device_properties_cb(DBusPendingCall *call,=
 gpointer user_data)
 	const char *device_addr =3D NULL;
 	const char *alias =3D NULL;
 	struct bluetooth_profile *profile;
+	GSList *entry;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -266,9 +318,15 @@ static void device_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 				"Address", parse_string, &device_addr,
 				"Alias", parse_string, &alias, NULL);
 =

-	if (adapter)
-		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
-							adapter);
+	if (adapter) {
+		entry =3D g_slist_find_custom(adapter_list, adapter,
+						adapter_compare);
+		if (entry !=3D NULL) {
+			struct adapter_address *a =3D entry->data;
+
+			adapter_addr =3D a->address;
+		}
+	}
 =

 	if ((have_uuid & HFP_AG) && device_addr && adapter_addr) {
 		profile =3D g_hash_table_lookup(uuid_hash, HFP_AG_UUID);
@@ -392,8 +450,7 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 					NULL);
 =

 	DBG("Adapter Address: %s, Path: %s", addr, path);
-	g_hash_table_insert(adapter_address_hash,
-				g_strdup(path), g_strdup(addr));
+	adapter_list =3D adapter_address_add(adapter_list, path, addr);
 =

 	for (l =3D device_list; l; l =3D l->next) {
 		const char *device =3D l->data;
@@ -429,10 +486,16 @@ static gboolean adapter_removed(DBusConnection *conne=
ction,
 				DBusMessage *message, void *user_data)
 {
 	const char *path;
+	GSList *l;
 =

 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID) =3D=3D TRUE)
-		g_hash_table_remove(adapter_address_hash, path);
+				DBUS_TYPE_INVALID) =3D=3D TRUE) {
+		l =3D g_slist_find_custom(adapter_list, path, adapter_compare);
+
+		if (l !=3D NULL)
+			adapter_list =3D adapter_address_remove(adapter_list,
+								l->data);
+	}
 =

 	return TRUE;
 }
@@ -538,9 +601,6 @@ static int bluetooth_ref(void)
 	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, NULL);
 =

-	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-						g_free, g_free);
-
 increment:
 	g_atomic_int_inc(&bluetooth_refcount);
 =

@@ -566,7 +626,9 @@ static void bluetooth_unref(void)
 	g_dbus_remove_watch(connection, property_watch);
 =

 	g_hash_table_destroy(uuid_hash);
-	g_hash_table_destroy(adapter_address_hash);
+	while (adapter_list)
+		adapter_list =3D adapter_address_remove(adapter_list,
+							adapter_list->data);
 }
 =

 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
-- =

1.7.1


--===============7033089094557455303==--


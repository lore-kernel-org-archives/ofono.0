Content-Type: multipart/mixed; boundary="===============4664653007659335434=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 13/14] hfp_hf: Handle connections before probe
Date: Mon, 03 Dec 2012 10:11:54 -0300
Message-ID: <1354540315-27731-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4664653007659335434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch allows oFono HFP plugin to handle HFP connections before
the Bluetooth device creation procedure finishes.
---
 plugins/bluetooth.c | 26 +++++++++++++++++
 plugins/bluetooth.h |  2 ++
 plugins/hfp_hf.c    | 84 +++++++++++++++++++++++++++++++++++--------------=
----
 3 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 6447e77..ce6dcae 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -31,6 +31,8 @@
 #include <unistd.h>
 #include <glib.h>
 #include <gdbus.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/rfcomm.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -1141,5 +1143,29 @@ void bluetooth_unregister_server(struct server *serv=
er)
 	bluetooth_unref();
 }
 =

+int bluetooth_get_address(int fd, char *adapter_address, char *device_addr=
ess)
+{
+	struct sockaddr_rc saddr;
+	socklen_t alen;
+
+	alen =3D sizeof(saddr);
+
+	if (adapter_address) {
+		if (getsockname(fd, (struct sockaddr *)&saddr, &alen) < 0)
+			return -errno;
+
+		ba2str(&saddr.rc_bdaddr, adapter_address);
+	}
+
+	if (device_address) {
+		if (getpeername(fd, (struct sockaddr *)&saddr, &alen) < 0)
+			return -errno;
+
+		ba2str(&saddr.rc_bdaddr, device_address);
+	}
+
+	return 0;
+}
+
 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 5b4d9d4..c1c274d 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -90,3 +90,5 @@ void bluetooth_parse_properties(DBusMessageIter *array,
 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
 					struct ofono_modem *modem);
 void bluetooth_sap_client_unregister(struct ofono_modem *modem);
+
+int bluetooth_get_address(int fd, char *adapter_address, char *device_addr=
ess);
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 8dd8dd9..5d71558 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -79,6 +79,40 @@ static void hfp_data_free(gpointer user_data)
 	g_free(hfp_data);
 }
 =

+static struct hfp_data *hfp_data_new(const gchar *adapter_addr,
+					const gchar *device_addr,
+					const gchar *device_path,
+					const gchar *alias)
+{
+	struct hfp_data *hfp_data;
+
+	hfp_data =3D g_try_new0(struct hfp_data, 1);
+	if (hfp_data =3D=3D NULL)
+		return NULL;
+
+	hfp_data->adapter_address =3D g_strdup(adapter_addr);
+	if (hfp_data->adapter_address =3D=3D NULL)
+		goto free;
+
+	hfp_data->device_address =3D g_strdup(device_addr);
+	if (hfp_data->device_address =3D=3D NULL)
+		goto free;
+
+	hfp_data->device_path =3D g_strdup(device_path);
+	if (hfp_data->device_path =3D=3D NULL)
+		goto free;
+
+	hfp_data->device_alias =3D g_strdup(alias);
+	if (hfp_data->device_alias =3D=3D NULL)
+		goto free;
+
+	return hfp_data;
+
+free:
+	hfp_data_free(hfp_data);
+	return NULL;
+}
+
 static void parse_guint16(DBusMessageIter *iter, gpointer user_data)
 {
 	guint16 *value =3D user_data;
@@ -222,34 +256,13 @@ static int hfp_hf_probe(const char *device, const cha=
r *dev_addr,
 	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
 					device, dev_addr, adapter_addr);
 =

-	hfp_data =3D g_try_new0(struct hfp_data, 1);
+	hfp_data =3D hfp_data_new(adapter_addr, dev_addr, device, alias);
 	if (hfp_data =3D=3D NULL)
-		goto free;
-
-	hfp_data->adapter_address =3D g_strdup(adapter_addr);
-	if (hfp_data->adapter_address =3D=3D NULL)
-		goto free;
-
-	hfp_data->device_address =3D g_strdup(dev_addr);
-	if (hfp_data->device_address =3D=3D NULL)
-		goto free;
-
-	hfp_data->device_path =3D g_strdup(device);
-	if (hfp_data->device_path =3D=3D NULL)
-		goto free;
-
-	hfp_data->device_alias =3D g_strdup(alias);
-	if (hfp_data->device_alias =3D=3D NULL)
-		goto free;
+		return -ENOMEM;
 =

 	g_hash_table_insert(hfp_hash, g_strdup(device), hfp_data);
 =

 	return 0;
-
-free:
-	hfp_data_free(hfp_data);
-
-	return -ENOMEM;
 }
 =

 static gboolean hfp_remove_modem(gpointer key, gpointer value,
@@ -315,12 +328,6 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 		goto error;
 =

 	dbus_message_iter_get_basic(&entry, &device);
-	hfp_data =3D g_hash_table_lookup(hfp_hash, device);
-	if (hfp_data =3D=3D NULL) {
-		DBG("%s: doesn't support HFP", device);
-		goto error;
-	}
-
 	dbus_message_iter_next(&entry);
 	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
 		goto error;
@@ -336,6 +343,25 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 					"Features", parse_guint16, &features,
 					NULL);
 =

+	hfp_data =3D g_hash_table_lookup(hfp_hash, device);
+	if (hfp_data =3D=3D NULL) {
+		char adapter_address[18], device_address[18];
+
+		/*
+		 * Incoming connection notification can arrive before
+		 * the Bluetooth device creation finishes.
+		 */
+		if (bluetooth_get_address(fd, adapter_address,
+							device_address) < 0)
+			return g_dbus_create_error(msg,
+					BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
+
+		hfp_data =3D hfp_data_new(adapter_address, device_address,
+						device, device_address);
+		g_hash_table_insert(hfp_hash, g_strdup(device), hfp_data);
+	}
+
 	DBG("hfp_data: %p SLC FD: %d Version: 0x%04x Features: 0x%04x",
 					hfp_data, fd, version, features);
 =

-- =

1.7.11.7


--===============4664653007659335434==--


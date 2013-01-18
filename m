Content-Type: multipart/mixed; boundary="===============4881095596459563829=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 03/10] hfp_hf: Add NewConnection arguments parsing
Date: Fri, 18 Jan 2013 20:21:49 -0300
Message-ID: <1358551316-27305-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4881095596459563829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This patch adds NewConnection message arguments parsing: features,
version and Media Endpoints included in the fd_properties dictionary.
---
 plugins/bluez5.c        |  35 ++++++++++++
 plugins/bluez5.h        |   8 +++
 plugins/hfp_hf_bluez5.c | 149 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 589658a..d753ac9 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -36,6 +36,41 @@
 =

 #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
 =

+struct bt_endpoint {
+	char *owner;
+	char *path;
+	guint8 codec;
+	unsigned char *capa;	/* Capabilities */
+	int capa_size;		/* Capabilities size */
+};
+
+struct bt_endpoint *bt_endpoint_new(const char *owner,
+					const char *path, guint8 codec,
+					unsigned char *capa, int capa_size)
+{
+	struct bt_endpoint *endpoint;
+
+	endpoint =3D g_new0(struct bt_endpoint, 1);
+	endpoint->owner =3D g_strdup(owner);
+	endpoint->path =3D g_strdup(path);
+	endpoint->codec =3D codec;
+	if (capa && capa_size)
+		endpoint->capa =3D g_memdup(capa, capa_size);
+
+	return endpoint;
+}
+
+void bt_endpoint_free(gpointer data)
+{
+	struct bt_endpoint *endpoint =3D data;
+
+	g_free(endpoint->owner);
+	g_free(endpoint->path);
+	if (endpoint->capa)
+		g_free(endpoint->capa);
+	g_free(endpoint);
+}
+
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 3088c7d..1ab350e 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -25,6 +25,14 @@
 =

 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 =

+struct bt_endpoint;
+
+struct bt_endpoint *bt_endpoint_new(const char *owner,
+					const char *path, guint8 codec,
+					unsigned char *capa, int capa_size);
+
+void bt_endpoint_free(gpointer data);
+
 int bt_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f1f8891..ef9af62 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <glib.h>
+#include <string.h>
 =

 #include <gdbus.h>
 =

@@ -42,6 +43,111 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+struct capabilities {
+	unsigned char *value;
+	int size;
+};
+
+static void parse_guint16(DBusMessageIter *iter, gpointer user_data)
+{
+	guint16 *value =3D user_data;
+
+	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_UINT16)
+		return;
+
+	dbus_message_iter_get_basic(iter, value);
+}
+
+static void parse_string(DBusMessageIter *iter, gpointer user_data)
+{
+	char **str =3D user_data;
+	int arg_type =3D dbus_message_iter_get_arg_type(iter);
+
+	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH && arg_type !=3D DBUS_TYPE_STRING)
+		return;
+
+	dbus_message_iter_get_basic(iter, str);
+}
+
+static void parse_byte(DBusMessageIter *iter, gpointer user_data)
+{
+	guint8 *value =3D user_data;
+
+	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_BYTE)
+		return;
+
+	dbus_message_iter_get_basic(iter, value);
+}
+
+static void parse_capabilities(DBusMessageIter *iter, gpointer user_data)
+{
+	DBusMessageIter array;
+	struct capabilities *capa =3D user_data;
+	guint8 *data =3D NULL;
+	int n =3D 0;
+
+	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &data, &n);
+	if (n =3D=3D 0)
+		return;
+
+	capa->value =3D g_memdup(data, n);
+	capa->size =3D n;
+}
+
+static void parse_media_endpoints(DBusMessageIter *array, gpointer user_da=
ta)
+{
+	const char *path, *owner;
+	GSList **endpoints =3D user_data;
+	struct capabilities capa;
+	struct bt_endpoint *endpoint;
+	guint8 codec;
+	DBusMessageIter dict, variant, entry;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		path =3D NULL;
+		codec =3D 0x00;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
+			return;
+
+		dbus_message_iter_get_basic(&entry, &owner);
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+			return;
+
+		dbus_message_iter_recurse(&entry, &variant);
+
+		memset(&capa, 0, sizeof(capa));
+		ofono_dbus_iter_parse_properties(&variant,
+				"Path", parse_string, &path,
+				"Codec", parse_byte, &codec,
+				"Capabilities", parse_capabilities, &capa,
+				NULL);
+
+		dbus_message_iter_next(&dict);
+
+		endpoint =3D bt_endpoint_new(owner, path, codec,
+						capa.value, capa.size);
+
+		g_free(capa.value);
+		*endpoints =3D g_slist_append(*endpoints, endpoint);
+
+		DBG("Media Endpoint %s %s codec: 0x%02X", owner, path, codec);
+	}
+}
+
 static int hfp_probe(struct ofono_modem *modem)
 {
 	DBG("modem: %p", modem);
@@ -93,11 +199,48 @@ static struct ofono_modem_driver hfp_driver =3D {
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	DBusMessageIter entry;
+	const char *device;
+	GSList *endpoints =3D NULL;
+	guint16 version, features;
+	int fd;
+
 	DBG("Profile handler NewConnection");
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
+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
+		goto error;
+
+	dbus_message_iter_get_basic(&entry, &fd);
+	if (fd < 0)
+		goto error;
+
+	dbus_message_iter_next(&entry);
+
+	ofono_dbus_iter_parse_properties(&entry,
+			"Version", parse_guint16, &version,
+			"Features", parse_guint16, &features,
+			"MediaEndpoints", parse_media_endpoints, &endpoints,
+			NULL);
+
+	DBG("%s version: 0x%04x features: 0x%04x", device, version, features);
+
+	if (endpoints =3D=3D NULL) {
+		ofono_error("Media Endpoint missing");
+		goto error;
+	}
+	return NULL;
+
+error:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static DBusMessage *profile_release(DBusConnection *conn,
-- =

1.7.11.7


--===============4881095596459563829==--


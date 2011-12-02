Content-Type: multipart/mixed; boundary="===============3678370470326826028=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 3/5] cdma-connman: Add bearer property implementation
Date: Fri, 02 Dec 2011 15:00:52 +0100
Message-ID: <1322834454-451-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322834454-451-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3678370470326826028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/common.h       |    1 +
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 87cefd6..ff835ed 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -40,6 +40,13 @@
 =

 static GSList *g_drivers;
 =

+enum packet_bearer {
+	PACKET_BEARER_NONE =3D		0,
+	PACKET_BEARER_CDMA_1X =3D		1,
+	PACKET_BEARER_CDMA_EVDO =3D	2,
+	PACKET_BEARER_CDMA_SVDO =3D	3,
+};
+
 struct cdma_connman_settings {
 	char *interface;
 	gboolean static_ip;
@@ -52,6 +59,7 @@ struct cdma_connman_settings {
 struct ofono_cdma_connman {
 	ofono_bool_t powered;
 	ofono_bool_t dormant;
+	int bearer;
 	struct cdma_connman_settings *settings;
 	DBusMessage *pending;
 	const struct ofono_cdma_connman_driver *driver;
@@ -61,6 +69,21 @@ struct ofono_cdma_connman {
 	char password[OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH + 1];
 };
 =

+const char *cdma_packet_bearer_to_string(int bearer)
+{
+	switch (bearer) {
+	case PACKET_BEARER_NONE:
+		return "none";
+	case PACKET_BEARER_CDMA_1X:
+		return "1x";
+	case PACKET_BEARER_CDMA_EVDO:
+		return "evdo";
+	case PACKET_BEARER_CDMA_SVDO:
+		return "svdo";
+	}
+	return "";
+}
+
 static void cdma_connman_settings_free(struct cdma_connman_settings *setti=
ngs)
 {
 	DBG("");
@@ -390,6 +413,13 @@ static DBusMessage *cdma_connman_get_properties(DBusCo=
nnection *conn,
 	value =3D cm->dormant;
 	ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (cm->bearer !=3D -1) {
+		const char *bearer =3D cdma_packet_bearer_to_string(cm->bearer);
+
+		ofono_dbus_dict_append(&dict, "Bearer",
+					DBUS_TYPE_STRING, &bearer);
+	}
+
 	if (cm->settings)
 		cdma_connman_settings_append_properties(cm, &dict);
 =

@@ -532,6 +562,25 @@ static GDBusSignalTable cdma_connman_signals[] =3D {
 	{ }
 };
 =

+void ofono_cdma_connman_bearer_notify(struct ofono_cdma_connman *cm,
+					int bearer)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *value;
+
+	if (cm->bearer =3D=3D bearer)
+		return;
+
+	cm->bearer =3D bearer;
+	path =3D __ofono_atom_get_path(cm->atom);
+	value =3D cdma_packet_bearer_to_string(bearer);
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"Bearer", DBUS_TYPE_STRING, &value);
+}
+
+
 int ofono_cdma_connman_driver_register(
 				const struct ofono_cdma_connman_driver *d)
 {
diff --git a/src/common.h b/src/common.h
index eb006a7..7cdf7ec 100644
--- a/src/common.h
+++ b/src/common.h
@@ -158,5 +158,6 @@ const char *bearer_class_to_string(enum bearer_class cl=
s);
 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
 const char *packet_bearer_to_string(int bearer);
+const char *cdma_packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
-- =

1.7.1


--===============3678370470326826028==--


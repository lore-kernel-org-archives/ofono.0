Content-Type: multipart/mixed; boundary="===============1791520663603215494=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/3] cdma-connman: add feature to load/save credentials
Date: Tue, 09 Aug 2011 16:48:05 +0200
Message-ID: <1312901287-30032-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312901287-30032-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1791520663603215494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    3 ++
 src/cdma-connman.c     |   57 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c            |   35 +++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index 6a1c9ff..0f8e388 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -77,6 +77,9 @@ void ofono_cdma_connman_set_data(struct ofono_cdma_connma=
n *cm,
 						void *data);
 void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
 =

+void ofono_cdma_connman_load_credentials(struct ofono_cdma_connman *cm,
+					const char *serial);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 0c9013b..3967080 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -37,6 +37,10 @@
 =

 #include "ofono.h"
 #include "common.h"
+#include "storage.h"
+
+#define CREDENTIALS_STORE "cdma"
+#define CREDENTIALS_GROUP "Credentials"
 =

 static GSList *g_drivers;
 =

@@ -59,6 +63,8 @@ struct ofono_cdma_connman {
 	struct ofono_atom *atom;
 	char username[OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH + 1];
+	GKeyFile *credentials;
+	char *serial;
 };
 =

 static void cdma_connman_settings_free(struct cdma_connman_settings *setti=
ngs)
@@ -387,6 +393,12 @@ static DBusMessage *cdma_connman_set_username(struct o=
fono_cdma_connman *cm,
 =

 	strcpy(cm->username, username);
 =

+	if (cm->credentials) {
+		g_key_file_set_string(cm->credentials, CREDENTIALS_GROUP,
+					"Username", username);
+		storage_sync(cm->serial, CREDENTIALS_STORE, cm->credentials);
+	}
+
 	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

 	path =3D __ofono_atom_get_path(cm->atom);
@@ -411,6 +423,12 @@ static DBusMessage *cdma_connman_set_password(struct o=
fono_cdma_connman *cm,
 =

 	strcpy(cm->password, password);
 =

+	if (cm->credentials) {
+		g_key_file_set_string(cm->credentials, CREDENTIALS_GROUP,
+					"Password", password);
+		storage_sync(cm->serial, CREDENTIALS_STORE, cm->credentials);
+	}
+
 	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

 	path =3D __ofono_atom_get_path(cm->atom);
@@ -552,6 +570,8 @@ static void cdma_connman_remove(struct ofono_atom *atom)
 	if (cm->driver && cm->driver->remove)
 		cm->driver->remove(cm);
 =

+	g_free(cm->serial);
+
 	g_free(cm);
 }
 =

@@ -632,3 +652,40 @@ void *ofono_cdma_connman_get_data(struct ofono_cdma_co=
nnman *cm)
 {
 	return cm->driver_data;
 }
+
+void ofono_cdma_connman_load_credentials(struct ofono_cdma_connman *cm,
+					const char *serial)
+{
+	char *username =3D NULL;
+	char *password =3D NULL;
+
+	DBG("Serial %s", serial);
+
+	cm->credentials =3D storage_open(serial, CREDENTIALS_STORE);
+	if (cm->credentials =3D=3D NULL)
+		return;
+
+	cm->serial =3D g_strdup(serial);
+
+	username =3D g_key_file_get_string(cm->credentials,
+						CREDENTIALS_GROUP,
+						"Username", NULL);
+	if (username =3D=3D NULL)
+		goto error;
+
+	password =3D g_key_file_get_string(cm->credentials,
+						CREDENTIALS_GROUP,
+						"Password", NULL);
+	if (password =3D=3D NULL)
+		goto error;
+
+	DBG("Usr %s Pwd %s", username, password);
+	strcpy(cm->username, username);
+	strcpy(cm->password, password);
+
+	return;
+
+error:
+	g_free(username);
+	g_free(password);
+}
diff --git a/src/modem.c b/src/modem.c
index 14c7a20..80a08c6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -95,6 +95,7 @@ struct ofono_devinfo {
 	char *revision;
 	char *serial;
 	unsigned int dun_watch;
+	unsigned int cdma_watch;
 	const struct ofono_devinfo_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1315,16 +1316,44 @@ void ofono_modem_remove_interface(struct ofono_mode=
m *modem,
 	modem->interface_update =3D g_idle_add(trigger_interface_update, modem);
 }
 =

+static void cdma_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_devinfo *info =3D data;
+	struct ofono_cdma_connman *cm =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
+		return;
+
+	ofono_cdma_connman_load_credentials(cm, info->serial);
+}
+
 static void query_serial_cb(const struct ofono_error *error,
 				const char *serial, void *user)
 {
 	struct ofono_devinfo *info =3D user;
+	struct ofono_atom *cdma_atom;
+	struct ofono_cdma_connman *cm;
+	struct ofono_modem *modem;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(info->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		return;
 =

+	cdma_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(info->atom),
+						OFONO_ATOM_TYPE_CDMA_CONNMAN);
+
+	if (cdma_atom !=3D NULL) {
+		cm =3D __ofono_atom_get_data(cdma_atom);
+		ofono_cdma_connman_load_credentials(cm, serial);
+	} else {
+		modem =3D __ofono_atom_get_modem(info->atom);
+		info->cdma_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_CDMA_CONNMAN,
+						cdma_watch, info, NULL);
+	}
+
 	info->serial =3D g_strdup(serial);
 =

 	ofono_dbus_signal_property_changed(conn, path,
@@ -1578,6 +1607,7 @@ struct ofono_devinfo *ofono_devinfo_create(struct ofo=
no_modem *modem,
 static void devinfo_unregister(struct ofono_atom *atom)
 {
 	struct ofono_devinfo *info =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 =

 	g_free(info->manufacturer);
 	info->manufacturer =3D NULL;
@@ -1590,6 +1620,11 @@ static void devinfo_unregister(struct ofono_atom *at=
om)
 =

 	g_free(info->serial);
 	info->serial =3D NULL;
+
+	if (info->cdma_watch) {
+		__ofono_modem_remove_atom_watch(modem, info->cdma_watch);
+		info->cdma_watch =3D 0;
+	}
 }
 =

 void ofono_devinfo_register(struct ofono_devinfo *info)
-- =

1.7.1


--===============1791520663603215494==--


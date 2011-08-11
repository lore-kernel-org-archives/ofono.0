Content-Type: multipart/mixed; boundary="===============7151668194873935088=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] cdma-connman: Add feature to load/save credentials
Date: Thu, 11 Aug 2011 18:02:39 +0200
Message-ID: <1313078559-13780-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1313078559-13780-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7151668194873935088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 0c9013b..0039eb0 100644
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

@@ -593,11 +613,48 @@ struct ofono_cdma_connman *ofono_cdma_connman_create(
 	return cm;
 }
 =

+static void load_credentials(struct ofono_cdma_connman *cm, const char *se=
rial)
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
+
 void ofono_cdma_connman_register(struct ofono_cdma_connman *cm)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cm->atom);
 	const char *path =3D __ofono_atom_get_path(cm->atom);
+	struct ofono_atom *devinfo =3D NULL;
 =

 	DBG("");
 =

@@ -613,6 +670,16 @@ void ofono_cdma_connman_register(struct ofono_cdma_con=
nman *cm)
 	ofono_modem_add_interface(modem,
 				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
 =

+	devinfo =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO);
+
+	if (devinfo !=3D NULL) {
+		const char *serial;
+		struct ofono_devinfo *info =3D __ofono_atom_get_data(devinfo);
+
+		serial =3D ofono_devinfo_get_serial(info);
+		load_credentials(cm, serial);
+	}
+
 	/* TODO: add watch to support CDMA Network Registration atom */
 =

 	__ofono_atom_register(cm->atom, cdma_connman_unregister);
-- =

1.7.1


--===============7151668194873935088==--


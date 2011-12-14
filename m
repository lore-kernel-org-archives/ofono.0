Content-Type: multipart/mixed; boundary="===============6234136374335810750=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 05/10] cdma-netreg: Add provider name and SID support
Date: Wed, 14 Dec 2011 18:56:07 +0100
Message-ID: <1323885372-3574-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323885372-3574-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6234136374335810750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-netreg.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 222c3b7..1a88d33 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <errno.h>
+#include <string.h>
 =

 #include <gdbus.h>
 =

@@ -38,6 +39,8 @@ struct ofono_cdma_netreg {
 	const struct ofono_cdma_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	char *provider_name;
+	char *sid;
 };
 =

 static const char *cdma_netreg_status_to_string(enum cdma_netreg_status st=
atus)
@@ -90,6 +93,15 @@ static DBusMessage *network_get_properties(DBusConnectio=
n *conn,
 					&strength);
 	}
 =

+	if (cdma_netreg->sid)
+		ofono_dbus_dict_append(&dict, "SystemIdentifier",
+						DBUS_TYPE_STRING,
+						&cdma_netreg->sid);
+
+	if (cdma_netreg->provider_name)
+		ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING,
+						&cdma_netreg->provider_name);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -108,6 +120,8 @@ static void serving_system_callback(const struct ofono_=
error *error,
 					const char *sid, void *data)
 {
 	struct ofono_cdma_netreg *cdma_netreg =3D data;
+	const char *path =3D __ofono_atom_get_path(cdma_netreg->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

 	if (cdma_netreg->status !=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
 			&& cdma_netreg->status !=3D
@@ -120,6 +134,30 @@ static void serving_system_callback(const struct ofono=
_error *error,
 	}
 =

 	DBG("Serving system Identifier: %s", sid);
+
+	if (cdma_netreg->sid !=3D NULL && !strcmp(cdma_netreg->sid, sid))
+		return;
+
+	g_free(cdma_netreg->provider_name);
+	g_free(cdma_netreg->sid);
+	cdma_netreg->provider_name =3D NULL;
+	cdma_netreg->sid =3D g_strdup(sid);
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"SystemIdentifier", DBUS_TYPE_STRING,
+				&cdma_netreg->sid);
+
+	if (__ofono_cdma_provision_get_name(sid,
+				&cdma_netreg->provider_name) =3D=3D FALSE) {
+		ofono_warn("Provider name not found");
+		return;
+	}
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"Name", DBUS_TYPE_STRING,
+				&cdma_netreg->provider_name);
 }
 =

 static void set_registration_status(struct ofono_cdma_netreg *cdma_netreg,
@@ -251,6 +289,8 @@ static void cdma_netreg_remove(struct ofono_atom *atom)
 	if (cdma_netreg->driver && cdma_netreg->driver->remove)
 		cdma_netreg->driver->remove(cdma_netreg);
 =

+	g_free(cdma_netreg->sid);
+	g_free(cdma_netreg->provider_name);
 	g_free(cdma_netreg);
 }
 =

-- =

1.7.1


--===============6234136374335810750==--


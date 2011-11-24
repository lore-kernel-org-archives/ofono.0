Content-Type: multipart/mixed; boundary="===============1255891346290294400=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 7/7] cdma-netreg: Add provider name support
Date: Thu, 24 Nov 2011 18:46:24 +0100
Message-ID: <1322156784-10402-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322156784-10402-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1255891346290294400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    3 ++-
 src/cdma-netreg.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6002eb0..978ac9f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -275,7 +275,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/cdmamodem/voicecall.c \
 			drivers/cdmamodem/devinfo.c \
 			drivers/cdmamodem/connman.c \
-			drivers/cdmamodem/network-registration.c
+			drivers/cdmamodem/network-registration.c \
+			plugins/mbpi.c plugins/mbpi.h
 endif
 =

 builtin_modules +=3D g1
diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 222c3b7..19947ab 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -28,6 +28,7 @@
 #include <gdbus.h>
 =

 #include "ofono.h"
+#include "plugins/mbpi.h"
 =

 static GSList *g_drivers;
 =

@@ -38,6 +39,7 @@ struct ofono_cdma_netreg {
 	const struct ofono_cdma_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	char *provider_name;
 };
 =

 static const char *cdma_netreg_status_to_string(enum cdma_netreg_status st=
atus)
@@ -90,6 +92,10 @@ static DBusMessage *network_get_properties(DBusConnectio=
n *conn,
 					&strength);
 	}
 =

+	if (cdma_netreg->provider_name)
+		ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING,
+						&cdma_netreg->provider_name);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -108,6 +114,9 @@ static void serving_system_callback(const struct ofono_=
error *error,
 					const char *sid, void *data)
 {
 	struct ofono_cdma_netreg *cdma_netreg =3D data;
+	const char *path =3D __ofono_atom_get_path(cdma_netreg->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	GError *err =3D NULL;
 =

 	if (cdma_netreg->status !=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
 			&& cdma_netreg->status !=3D
@@ -120,6 +129,20 @@ static void serving_system_callback(const struct ofono=
_error *error,
 	}
 =

 	DBG("Serving system Identifier: %s", sid);
+
+	g_free(cdma_netreg->provider_name);
+	cdma_netreg->provider_name =3D NULL;
+	cdma_netreg->provider_name =3D mbpi_lookup_cdma_provider_name(sid, &err);
+
+	if (cdma_netreg->provider_name)
+		ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"Name", DBUS_TYPE_STRING,
+				&cdma_netreg->provider_name);
+	else if (err !=3D NULL) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+	}
 }
 =

 static void set_registration_status(struct ofono_cdma_netreg *cdma_netreg,
@@ -136,6 +159,12 @@ static void set_registration_status(struct ofono_cdma_=
netreg *cdma_netreg,
 				"Status", DBUS_TYPE_STRING,
 				&str_status);
 =

+	if (cdma_netreg->status =3D=3D
+			CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED) {
+		g_free(cdma_netreg->provider_name);
+		cdma_netreg->provider_name =3D NULL;
+	}
+
 	if (cdma_netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
 			|| cdma_netreg->status =3D=3D
 				CDMA_NETWORK_REGISTRATION_STATUS_ROAMING)
@@ -251,6 +280,7 @@ static void cdma_netreg_remove(struct ofono_atom *atom)
 	if (cdma_netreg->driver && cdma_netreg->driver->remove)
 		cdma_netreg->driver->remove(cdma_netreg);
 =

+	g_free(cdma_netreg->provider_name);
 	g_free(cdma_netreg);
 }
 =

-- =

1.7.1


--===============1255891346290294400==--


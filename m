Content-Type: multipart/mixed; boundary="===============6522307268592103553=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/6] netreg: Deprecate the deregister method
Date: Wed, 19 Jan 2011 23:53:50 +0200
Message-ID: <1295474035-7142-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6522307268592103553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   37 ++-----------------------------------
 1 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/src/network.c b/src/network.c
index ae0f334..1f66f34 100644
--- a/src/network.c
+++ b/src/network.c
@@ -43,8 +43,6 @@
 enum network_registration_mode {
 	NETWORK_REGISTRATION_MODE_AUTO =3D	0,
 	NETWORK_REGISTRATION_MODE_MANUAL =3D	1,
-	NETWORK_REGISTRATION_MODE_OFF =3D		2,
-	NETWORK_REGISTRATION_MODE_MANUAL_AUTO =3D	4,
 };
 =

 #define SETTINGS_STORE "netreg"
@@ -102,8 +100,6 @@ static const char *registration_mode_to_string(int mode)
 		return "auto";
 	case NETWORK_REGISTRATION_MODE_MANUAL:
 		return "manual";
-	case NETWORK_REGISTRATION_MODE_OFF:
-		return "off";
 	}
 =

 	return "unknown";
@@ -845,26 +841,6 @@ static DBusMessage *network_register(DBusConnection *c=
onn,
 	return NULL;
 }
 =

-static DBusMessage *network_deregister(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct ofono_netreg *netreg =3D data;
-
-	if (netreg->pending)
-		return __ofono_error_busy(msg);
-
-	if (netreg->driver->deregister =3D=3D NULL)
-		return __ofono_error_not_implemented(msg);
-
-	netreg->pending =3D dbus_message_ref(msg);
-
-	netreg->driver->deregister(netreg, register_callback, netreg);
-
-	set_registration_mode(netreg, NETWORK_REGISTRATION_MODE_OFF);
-
-	return NULL;
-}
-
 static void append_operator_struct(struct ofono_netreg *netreg,
 					struct network_operator_data *opd,
 					DBusMessageIter *iter)
@@ -1016,8 +992,6 @@ static GDBusMethodTable network_registration_methods[]=
 =3D {
 	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
 	{ "Register",       "",  "",		network_register,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Deregister",     "",  "",		network_deregister,
-						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetOperators",   "",  "a(oa{sv})",	network_get_operators },
 	{ "Scan",           "",  "a(oa{sv})",	network_scan,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -1782,7 +1756,6 @@ struct ofono_netreg *ofono_netreg_create(struct ofono=
_modem *modem,
 static void netreg_load_settings(struct ofono_netreg *netreg)
 {
 	const char *imsi;
-	int mode;
 =

 	imsi =3D ofono_sim_get_imsi(netreg->sim);
 	if (imsi =3D=3D NULL)
@@ -1795,14 +1768,8 @@ static void netreg_load_settings(struct ofono_netreg=
 *netreg)
 =

 	netreg->imsi =3D g_strdup(imsi);
 =

-	mode =3D g_key_file_get_integer(netreg->settings, SETTINGS_GROUP,
-					"Mode", NULL);
-
-	if (mode >=3D 0 && mode <=3D 2)
-		netreg->mode =3D mode;
-
-	g_key_file_set_integer(netreg->settings, SETTINGS_GROUP,
-				"Mode", netreg->mode);
+	netreg->mode =3D g_key_file_get_integer(netreg->settings, SETTINGS_GROUP,
+						"Mode", NULL);
 }
 =

 void ofono_netreg_register(struct ofono_netreg *netreg)
-- =

1.7.1


--===============6522307268592103553==--


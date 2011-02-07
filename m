Content-Type: multipart/mixed; boundary="===============0641154426457492704=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/7] gprs: remove RoamingAllowed property
Date: Mon, 07 Feb 2011 16:03:06 +0200
Message-ID: <1297087392-31030-1-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0641154426457492704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No roaming policies need to be enforced per GPRS context rather than
for the whole GPRS service. Otherwise, you would not be able to receive
an MMS or even register to the IMS SIP while roaming.
---
 src/gprs.c |   51 +++------------------------------------------------
 1 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 5ea864c..b6003f7 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -76,7 +76,6 @@ struct ofono_gprs {
 	GSList *contexts;
 	ofono_bool_t attached;
 	ofono_bool_t driver_attached;
-	ofono_bool_t roaming_allowed;
 	ofono_bool_t powered;
 	ofono_bool_t suspended;
 	int status;
@@ -1426,10 +1425,8 @@ static void gprs_netreg_update(struct ofono_gprs *gp=
rs)
 {
 	ofono_bool_t attach;
 =

-	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED;
-
-	attach =3D attach || (gprs->roaming_allowed &&
-		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED
+		|| NETWORK_REGISTRATION_STATUS_ROAMING;
 =

 	attach =3D attach && gprs->powered;
 =

@@ -1492,10 +1489,6 @@ static DBusMessage *gprs_get_properties(DBusConnecti=
on *conn,
 					DBUS_TYPE_STRING, &bearer);
 	}
 =

-	value =3D gprs->roaming_allowed;
-	ofono_dbus_dict_append(&dict, "RoamingAllowed",
-				DBUS_TYPE_BOOLEAN, &value);
-
 	value =3D gprs->powered;
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
 =

@@ -1537,27 +1530,7 @@ static DBusMessage *gprs_set_property(DBusConnection=
 *conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

-	if (!strcmp(property, "RoamingAllowed")) {
-		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
-			return __ofono_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&var, &value);
-
-		if (gprs->roaming_allowed =3D=3D (ofono_bool_t) value)
-			return dbus_message_new_method_return(msg);
-
-		gprs->roaming_allowed =3D value;
-
-		if (gprs->settings) {
-			g_key_file_set_integer(gprs->settings, SETTINGS_GROUP,
-						"RoamingAllowed",
-						gprs->roaming_allowed);
-			storage_sync(gprs->imsi, SETTINGS_STORE,
-					gprs->settings);
-		}
-
-		gprs_netreg_update(gprs);
-	} else if (!strcmp(property, "Powered")) {
+	if (!strcmp(property, "Powered")) {
 		if (gprs->driver->set_attached =3D=3D NULL)
 			return __ofono_error_not_implemented(msg);
 =

@@ -2000,10 +1973,6 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 	if (gprs->powered =3D=3D FALSE)
 		goto detach;
 =

-	if (gprs->roaming_allowed =3D=3D FALSE &&
-			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING)
-		goto detach;
-
 	gprs->driver_attached =3D TRUE;
 	gprs_attached_update(gprs);
 =

@@ -2499,7 +2468,6 @@ static void gprs_load_settings(struct ofono_gprs *gpr=
s, const char *imsi)
 	/*
 	 * If any error occurs, simply switch to defaults.
 	 * Default to Powered =3D True
-	 * and RoamingAllowed =3D False
 	 */
 	if (error) {
 		gprs->powered =3D TRUE;
@@ -2507,19 +2475,6 @@ static void gprs_load_settings(struct ofono_gprs *gp=
rs, const char *imsi)
 					"Powered", gprs->powered);
 	}
 =

-	error =3D NULL;
-	gprs->roaming_allowed =3D g_key_file_get_boolean(gprs->settings,
-							SETTINGS_GROUP,
-							"RoamingAllowed",
-							&error);
-
-	if (error) {
-		gprs->roaming_allowed =3D FALSE;
-		g_key_file_set_boolean(gprs->settings, SETTINGS_GROUP,
-					"RoamingAllowed",
-					gprs->roaming_allowed);
-	}
-
 	groups =3D g_key_file_get_groups(gprs->settings, NULL);
 =

 	for (i =3D 0; groups[i]; i++) {
-- =

1.7.1


--===============0641154426457492704==--


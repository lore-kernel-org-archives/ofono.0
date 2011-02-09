Content-Type: multipart/mixed; boundary="===============6844743970745213357=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 4/7] gprs: do not watch registration status or re-attach
Date: Wed, 09 Feb 2011 16:28:54 +0200
Message-ID: <1297261737-20372-4-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1297261737-20372-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6844743970745213357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is not needed since we let the modem automatically attach.
---
 src/gprs.c |  175 +++-----------------------------------------------------=
---
 1 files changed, 9 insertions(+), 166 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index f8d0fb5..800624b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -46,9 +46,6 @@
 #include "simutil.h"
 #include "util.h"
 =

-#define GPRS_FLAG_ATTACHING 0x1
-#define GPRS_FLAG_RECHECK 0x2
-
 #define SETTINGS_STORE "gprs"
 #define SETTINGS_GROUP "Settings"
 #define MAX_CONTEXT_NAME_LENGTH 127
@@ -75,7 +72,6 @@ enum packet_bearer {
 struct ofono_gprs {
 	GSList *contexts;
 	ofono_bool_t attached;
-	ofono_bool_t driver_attached;
 	ofono_bool_t powered;
 	ofono_bool_t suspended;
 	int status;
@@ -85,10 +81,6 @@ struct ofono_gprs {
 	struct idmap *pid_map;
 	unsigned int last_context_id;
 	struct idmap *cid_map;
-	int netreg_status;
-	struct ofono_netreg *netreg;
-	unsigned int netreg_watch;
-	unsigned int status_watch;
 	GKeyFile *settings;
 	char *imsi;
 	DBusMessage *pending;
@@ -137,7 +129,6 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

-static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

 const char *packet_bearer_to_string(int bearer)
@@ -1272,7 +1263,8 @@ static void update_suspended_property(struct ofono_gp=
rs *gprs,
 =

 	gprs->suspended =3D suspended;
 =

-	if (gprs->attached)
+	if (gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+			gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING)
 		ofono_dbus_signal_property_changed(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
 					"Suspended", DBUS_TYPE_BOOLEAN, &value);
@@ -1319,8 +1311,7 @@ static void gprs_attached_update(struct ofono_gprs *g=
prs)
 	ofono_bool_t attached;
 	dbus_bool_t value;
 =

-	attached =3D gprs->driver_attached &&
-		(gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+	attached =3D (gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED =
||
 			gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
 =

 	if (attached =3D=3D gprs->attached)
@@ -1372,87 +1363,6 @@ static void registration_status_cb(const struct ofon=
o_error *error,
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		ofono_gprs_status_notify(gprs, status);
-
-	if (gprs->flags & GPRS_FLAG_RECHECK) {
-		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
-		gprs_netreg_update(gprs);
-	}
-}
-
-static void gprs_attach_callback(const struct ofono_error *error, void *da=
ta)
-{
-	struct ofono_gprs *gprs =3D data;
-
-	DBG("%s error =3D %d", __ofono_atom_get_path(gprs->atom), error->type);
-
-	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
-
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		gprs->driver_attached =3D !gprs->driver_attached;
-
-	if (gprs->driver->attached_status) {
-		gprs->driver->attached_status(gprs, registration_status_cb,
-						gprs);
-		return;
-	}
-
-	gprs_attached_update(gprs);
-
-	if (gprs->flags & GPRS_FLAG_RECHECK) {
-		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
-		gprs_netreg_update(gprs);
-	}
-}
-
-static void gprs_netreg_removed(struct ofono_gprs *gprs)
-{
-	gprs->netreg =3D NULL;
-
-	gprs->flags &=3D ~(GPRS_FLAG_RECHECK | GPRS_FLAG_ATTACHING);
-	gprs->status_watch =3D 0;
-	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
-	gprs->driver_attached =3D FALSE;
-
-	gprs_attached_update(gprs);
-}
-
-static void gprs_netreg_update(struct ofono_gprs *gprs)
-{
-	ofono_bool_t attach;
-
-	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED
-		|| NETWORK_REGISTRATION_STATUS_ROAMING;
-
-	attach =3D attach && gprs->powered;
-
-	if (gprs->driver_attached =3D=3D attach)
-		return;
-
-	if (gprs->flags & GPRS_FLAG_ATTACHING) {
-		gprs->flags |=3D GPRS_FLAG_RECHECK;
-		return;
-	}
-
-	gprs->flags |=3D GPRS_FLAG_ATTACHING;
-
-	gprs->driver->set_attached(gprs, attach, gprs_attach_callback, gprs);
-	gprs->driver_attached =3D attach;
-}
-
-static void netreg_status_changed(int status, int lac, int ci, int tech,
-					const char *mcc, const char *mnc,
-					void *data)
-{
-	struct ofono_gprs *gprs =3D data;
-
-	DBG("%d", status);
-
-	if (gprs->netreg_status =3D=3D status)
-		return;
-
-	gprs->netreg_status =3D status;
-
-	gprs_netreg_update(gprs);
 }
 =

 static DBusMessage *gprs_get_properties(DBusConnection *conn,
@@ -1526,9 +1436,6 @@ static DBusMessage *gprs_set_property(DBusConnection =
*conn,
 	dbus_message_iter_recurse(&iter, &var);
 =

 	if (!strcmp(property, "Powered")) {
-		if (gprs->driver->set_attached =3D=3D NULL)
-			return __ofono_error_not_implemented(msg);
-
 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
 			return __ofono_error_invalid_args(msg);
 =

@@ -1546,7 +1453,10 @@ static DBusMessage *gprs_set_property(DBusConnection=
 *conn,
 					gprs->settings);
 		}
 =

-		gprs_netreg_update(gprs);
+		if (gprs->driver->attached_status)
+			gprs->driver->attached_status(gprs,
+							registration_status_cb,
+							gprs);
 	} else {
 		return __ofono_error_invalid_args(msg);
 	}
@@ -1942,14 +1852,8 @@ void ofono_gprs_detached_notify(struct ofono_gprs *g=
prs)
 {
 	DBG("%s", __ofono_atom_get_path(gprs->atom));
 =

-	gprs->driver_attached =3D FALSE;
-	gprs_attached_update(gprs);
-
-	/*
-	 * TODO: The network forced a detach, we should wait for some time
-	 * and try to re-attach.  This might also be related to a suspend
-	 * event while voicecall is active.
-	 */
+	ofono_gprs_status_notify(gprs,
+				NETWORK_REGISTRATION_STATUS_NOT_REGISTERED);
 }
 =

 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
@@ -1957,25 +1861,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 	DBG("%s status %d", __ofono_atom_get_path(gprs->atom), status);
 =

 	gprs->status =3D status;
-
-	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		gprs_attached_update(gprs);
-		return;
-	}
-
-	/* We registered without being powered */
-	if (gprs->powered =3D=3D FALSE)
-		goto detach;
-
-	gprs->driver_attached =3D TRUE;
 	gprs_attached_update(gprs);
-
-	return;
-
-detach:
-	gprs->flags |=3D GPRS_FLAG_ATTACHING;
-	gprs->driver->set_attached(gprs, FALSE, gprs_attach_callback, gprs);
 }
 =

 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
@@ -2221,18 +2107,6 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->cid_map =3D NULL;
 	}
 =

-	if (gprs->netreg_watch) {
-		if (gprs->status_watch) {
-			__ofono_netreg_remove_status_watch(gprs->netreg,
-							gprs->status_watch);
-			gprs->status_watch =3D 0;
-		}
-
-		__ofono_modem_remove_atom_watch(modem, gprs->netreg_watch);
-		gprs->netreg_watch =3D 0;
-		gprs->netreg =3D NULL;
-	}
-
 	ofono_modem_remove_interface(modem,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
@@ -2298,31 +2172,11 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_m=
odem *modem,
 	}
 =

 	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
-	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
 =

 	return gprs;
 }
 =

-static void netreg_watch(struct ofono_atom *atom,
-				enum ofono_atom_watch_condition cond,
-				void *data)
-{
-	struct ofono_gprs *gprs =3D data;
-
-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
-		gprs_netreg_removed(gprs);
-		return;
-	}
-
-	gprs->netreg =3D __ofono_atom_get_data(atom);
-	gprs->netreg_status =3D ofono_netreg_get_status(gprs->netreg);
-	gprs->status_watch =3D __ofono_netreg_add_status_watch(gprs->netreg,
-					netreg_status_changed, gprs, NULL);
-
-	gprs_netreg_update(gprs);
-}
-
 static gboolean load_context(struct ofono_gprs *gprs, const char *group)
 {
 	char *name =3D NULL;
@@ -2611,7 +2465,6 @@ static void ofono_gprs_finish_register(struct ofono_g=
prs *gprs)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
-	struct ofono_atom *netreg_atom;
 =

 	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
 		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
@@ -2630,16 +2483,6 @@ static void ofono_gprs_finish_register(struct ofono_=
gprs *gprs)
 	ofono_modem_add_interface(modem,
 				OFONO_CONNECTION_MANAGER_INTERFACE);
 =

-	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
-					OFONO_ATOM_TYPE_NETREG,
-					netreg_watch, gprs, NULL);
-
-	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
-
-	if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
-		netreg_watch(netreg_atom,
-				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
-
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

-- =

1.7.1


--===============6844743970745213357==--


Content-Type: multipart/mixed; boundary="===============4687011959146040776=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [RfC] Retry registering packet radio to home PLMN when available.
Date: Mon, 26 Oct 2009 18:21:04 +0100
Message-ID: <1256577664-4459-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4687011959146040776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of setting DataConnectionManager.Powered to false after
failed attempts to register to home PLMN with packet radio when
RoamingAllowed is false, wait for the home PLMN to become available
retrying everytime the circuit switched radio manages to register
to home PLMN.  The downside is if the circuit switched radio is off,
we wait indefinitely.

Also don't emit a useless PropertyChanged signal when we attached
and are going to detach immediately because of RoamingAllowed.

Hopefully this makes the code easier to follow.
---
 src/gprs.c |  147 +++++++++++++++++++++++++++++++++++++++++++-------------=
----
 1 files changed, 106 insertions(+), 41 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 2769c27..d3f3318 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -38,6 +38,7 @@
 #define DATA_CONTEXT_INTERFACE "org.ofono.PrimaryDataContext"
 =

 #define GPRS_FLAG_ATTACHING 0x1
+#define GPRS_FLAG_DETACHED_AFTER_ROAMING 0x2
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -51,6 +52,7 @@ enum gprs_context_type {
 struct ofono_gprs {
 	GSList *contexts;
 	ofono_bool_t attached;
+	ofono_bool_t driver_attached;
 	ofono_bool_t roaming_allowed;
 	ofono_bool_t powered;
 	int status;
@@ -61,6 +63,10 @@ struct ofono_gprs {
 	int next_context_id;
 	int cid_min;
 	int cid_max;
+	int netreg_status;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_watch;
+	unsigned int status_watch;
 	DBusMessage *pending;
 	struct ofono_gprs_context *context_driver;
 	const struct ofono_gprs_driver *driver;
@@ -506,23 +512,32 @@ static char **gprs_contexts_path_list(GSList *context=
_list)
 	return objlist;
 }
 =

-static void gprs_attach_callback(const struct ofono_error *error, void *da=
ta)
+static void gprs_set_attached(struct ofono_gprs *gprs)
 {
-	struct ofono_gprs *gprs =3D data;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path;
 	dbus_bool_t value;
+	ofono_bool_t attached =3D gprs->driver_attached &&
+		!(gprs->flags & GPRS_FLAG_DETACHED_AFTER_ROAMING);
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-			(gprs->flags & GPRS_FLAG_ATTACHING)) {
-		gprs->attached =3D !gprs->attached;
+	if (attached !=3D gprs->attached) {
+		gprs->attached =3D attached;
 =

 		path =3D __ofono_atom_get_path(gprs->atom);
-		value =3D gprs->attached;
+		value =3D attached;
 		ofono_dbus_signal_property_changed(conn, path,
 					DATA_CONNECTION_MANAGER_INTERFACE,
 					"Attached", DBUS_TYPE_BOOLEAN, &value);
 	}
+}
+
+static void gprs_attach_callback(const struct ofono_error *error, void *da=
ta)
+{
+	struct ofono_gprs *gprs =3D data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			(gprs->flags & GPRS_FLAG_ATTACHING))
+		gprs->driver_attached =3D !gprs->driver_attached;
 =

 	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
 =

@@ -531,18 +546,21 @@ static void gprs_attach_callback(const struct ofono_e=
rror *error, void *data)
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	int attach;
 	int operator_ok;
-	const char *path;
-	dbus_bool_t value =3D 0;
 =

 	operator_ok =3D gprs->roaming_allowed ||
-		(gprs->status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
+		(gprs->status !=3D NETWORK_REGISTRATION_STATUS_ROAMING &&
+		 !(gprs->flags & GPRS_FLAG_DETACHED_AFTER_ROAMING));
+
+	if (gprs->powered && !operator_ok)
+		gprs->flags |=3D GPRS_FLAG_DETACHED_AFTER_ROAMING;
+
+	gprs_set_attached(gprs);
 =

 	attach =3D gprs->powered && operator_ok;
 =

-	if (gprs->attached !=3D attach &&
+	if (gprs->driver_attached !=3D attach &&
 			!(gprs->flags & GPRS_FLAG_ATTACHING) &&
 			!(attach && gprs->status !=3D
 				NETWORK_REGISTRATION_STATUS_SEARCHING)) {
@@ -550,17 +568,33 @@ static void gprs_netreg_update(struct ofono_gprs *gpr=
s)
 =

 		gprs->driver->set_attached(gprs, attach, gprs_attach_callback,
 						gprs);
+	}
+}
 =

-		/* Prevent further attempts to attach */
-		if (!attach && gprs->powered) {
-			gprs->powered =3D 0;
+static void netreg_status_changed(int status, int lac, int ci, int tech,
+					const struct ofono_network_operator *op,
+					void *data)
+{
+	struct ofono_gprs *gprs =3D data;
 =

-			path =3D __ofono_atom_get_path(gprs->atom);
-			ofono_dbus_signal_property_changed(conn, path,
-					DATA_CONNECTION_MANAGER_INTERFACE,
-					"Powered", DBUS_TYPE_BOOLEAN, &value);
-		}
-	}
+	DBG("%d, %d, %d, %d, %p", status, lac, ci, tech, op);
+
+	if (gprs->netreg_status =3D=3D status)
+		return;
+	gprs->netreg_status =3D status;
+
+	if (!(gprs->flags & GPRS_FLAG_DETACHED_AFTER_ROAMING))
+		return;
+
+	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+		return;
+
+	/* If the circuit switched radio just registered to home PLMN then
+	 * we also make an attempt to attach.
+	 */
+	gprs->flags &=3D ~GPRS_FLAG_DETACHED_AFTER_ROAMING;
+
+	gprs_netreg_update(gprs);
 }
 =

 static DBusMessage *gprs_get_properties(DBusConnection *conn,
@@ -667,6 +701,8 @@ static DBusMessage *gprs_set_property(DBusConnection *c=
onn,
 			return dbus_message_new_method_return(msg);
 =

 		gprs->roaming_allowed =3D value;
+		gprs->flags &=3D ~GPRS_FLAG_DETACHED_AFTER_ROAMING;
+
 		gprs_netreg_update(gprs);
 	} else if (!strcmp(property, "Powered")) {
 		if (!gprs->driver->set_attached)
@@ -681,6 +717,8 @@ static DBusMessage *gprs_set_property(DBusConnection *c=
onn,
 			return dbus_message_new_method_return(msg);
 =

 		gprs->powered =3D value;
+		gprs->flags &=3D ~GPRS_FLAG_DETACHED_AFTER_ROAMING;
+
 		gprs_netreg_update(gprs);
 	} else
 		return __ofono_error_invalid_args(msg);
@@ -854,17 +892,9 @@ static GDBusSignalTable manager_signals[] =3D {
 =

 void ofono_gprs_attach_notify(struct ofono_gprs *gprs, int attached)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path;
-	dbus_bool_t value =3D 0;
-
-	if (gprs->attached && !(gprs->flags & GPRS_FLAG_ATTACHING)) {
-		gprs->attached =3D 0;
-
-		path =3D __ofono_atom_get_path(gprs->atom);
-		ofono_dbus_signal_property_changed(conn, path,
-					DATA_CONNECTION_MANAGER_INTERFACE,
-					"Attached", DBUS_TYPE_BOOLEAN, &value);
+	if (gprs->driver_attached !=3D attached &&
+			!(gprs->flags & GPRS_FLAG_ATTACHING)) {
+		gprs->driver_attached =3D attached;
 =

 		gprs_netreg_update(gprs);
 	}
@@ -875,7 +905,7 @@ static void set_registration_status(struct ofono_gprs *=
gprs, int status)
 	const char *str_status =3D registration_status_to_string(status);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-	dbus_bool_t attached;
+	ofono_bool_t attached;
 =

 	gprs->status =3D status;
 =

@@ -886,15 +916,8 @@ static void set_registration_status(struct ofono_gprs =
*gprs, int status)
 =

 	attached =3D (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
 			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
-	if (gprs->attached !=3D (int) attached &&
-			!(gprs->flags & GPRS_FLAG_ATTACHING)) {
-		gprs->attached =3D (int) attached;
-
-		ofono_dbus_signal_property_changed(conn, path,
-				DATA_CONNECTION_MANAGER_INTERFACE,
-				"Attached", DBUS_TYPE_BOOLEAN,
-				&attached);
-	}
+	if (!(gprs->flags & GPRS_FLAG_ATTACHING))
+		gprs->driver_attached =3D attached;
 =

 	gprs_netreg_update(gprs);
 }
@@ -1135,6 +1158,18 @@ static void gprs_unregister(struct ofono_atom *atom)
 =

 	g_slist_free(gprs->contexts);
 =

+	if (gprs->netreg_watch) {
+		if (gprs->status_watch) {
+			__ofono_netreg_remove_status_watch(gprs->netreg,
+							gprs->status_watch);
+			gprs->status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(modem, gprs->netreg_watch);
+		gprs->netreg_watch =3D 0;
+		gprs->netreg =3D NULL;
+	}
+
 	ofono_modem_remove_interface(modem, DATA_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
 					DATA_CONNECTION_MANAGER_INTERFACE);
@@ -1194,11 +1229,30 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_m=
odem *modem,
 	return gprs;
 }
 =

+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_gprs *gprs =3D data;
+
+	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		gprs->status_watch =3D 0;
+		gprs->netreg =3D NULL;
+		return;
+	}
+
+	gprs->netreg =3D __ofono_atom_get_data(atom);
+	gprs->netreg_status =3D ofono_netreg_get_status(gprs->netreg);
+	gprs->status_watch =3D __ofono_netreg_add_status_watch(gprs->netreg,
+					netreg_status_changed, gprs, NULL);
+}
+
 void ofono_gprs_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
+	struct ofono_atom *netreg_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					DATA_CONNECTION_MANAGER_INTERFACE,
@@ -1212,6 +1266,17 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 =

 	ofono_modem_add_interface(modem, DATA_CONNECTION_MANAGER_INTERFACE);
 =

+	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, gprs, NULL);
+
+	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
+
+	if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
+		netreg_watch(netreg_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
+
+
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

-- =

1.6.1


--===============4687011959146040776==--


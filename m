Content-Type: multipart/mixed; boundary="===============3219974573147471951=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 1/4] Add: Online property to modem
Date: Wed, 26 May 2010 00:14:38 +0300
Message-ID: <1274822081-930-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3219974573147471951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The online/offline state is changed with the new set_online() modem driver
method.

In order to track atoms, there are modem states as follows:
- OFONO_MODEM_STATE_POWER_OFF
- OFONO_MODEM_STATE_PRE_SIM
- OFONO_MODEM_STATE_OFFLINE
- OFONO_MODEM_STATE_ONLINE

Atoms are removed by modem core according to the state. Atoms are added with
driver methods pre_sim(), post_sim() and post_online().
---
 include/modem.h |   12 ++++
 src/modem.c     |  194 +++++++++++++++++++++++++++++++++++++++++++--------=
----
 2 files changed, 164 insertions(+), 42 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index d502640..69c7ad2 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -50,6 +50,8 @@ void ofono_modem_remove(struct ofono_modem *modem);
 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
 ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
 =

+ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
+
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
 =

 int ofono_modem_set_string(struct ofono_modem *modem,
@@ -64,6 +66,9 @@ int ofono_modem_set_boolean(struct ofono_modem *modem,
 				const char *key, bool value);
 bool ofono_modem_get_boolean(struct ofono_modem *modem, const char *key);
 =

+typedef void (*ofono_modem_online_cb)(const struct ofono_error *error,
+				void *data);
+
 struct ofono_modem_driver {
 	const char *name;
 =

@@ -80,11 +85,18 @@ struct ofono_modem_driver {
 	/* Power down device */
 	int (*disable)(struct ofono_modem *modem);
 =

+	/* Enable or disable cellular radio */
+	void (*set_online)(struct ofono_modem *modem, ofono_bool_t online,
+		ofono_modem_online_cb callback, void *data);
+
 	/* Populate the atoms available without SIM / Locked SIM */
 	void (*pre_sim)(struct ofono_modem *modem);
 =

 	/* Populate the atoms that are available with SIM / Unlocked SIM*/
 	void (*post_sim)(struct ofono_modem *modem);
+
+	/* Populate the atoms available online */
+	void (*post_online)(struct ofono_modem *modem);
 };
 =

 int ofono_modem_driver_register(const struct ofono_modem_driver *);
diff --git a/src/modem.c b/src/modem.c
index 04fba15..b52bcb0 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -49,10 +49,17 @@ enum ofono_property_type {
 	OFONO_PROPERTY_TYPE_BOOLEAN,
 };
 =

+enum ofono_modem_state {
+	OFONO_MODEM_STATE_POWER_OFF,
+	OFONO_MODEM_STATE_PRE_SIM,
+	OFONO_MODEM_STATE_OFFLINE,
+	OFONO_MODEM_STATE_ONLINE,
+};
+
 struct ofono_modem {
 	char			*path;
+	enum ofono_modem_state   modem_state;
 	GSList			*atoms;
-	GSList			*pre_sim_atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList			*interface_list;
 	unsigned int		call_ids;
@@ -61,6 +68,8 @@ struct ofono_modem {
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
 	guint			timeout;
+	ofono_bool_t		online;
+	ofono_bool_t            online_pending;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
@@ -83,6 +92,7 @@ struct ofono_devinfo {
 =

 struct ofono_atom {
 	enum ofono_atom_type type;
+	enum ofono_modem_state modem_state;
 	void (*destruct)(struct ofono_atom *atom);
 	void (*unregister)(struct ofono_atom *atom);
 	void *data;
@@ -160,6 +170,7 @@ struct ofono_atom *__ofono_modem_add_atom(struct ofono_=
modem *modem,
 	atom =3D g_new0(struct ofono_atom, 1);
 =

 	atom->type =3D type;
+	atom->modem_state =3D modem->modem_state;
 	atom->destruct =3D destruct;
 	atom->data =3D data;
 	atom->modem =3D modem;
@@ -275,7 +286,6 @@ struct ofono_atom *__ofono_modem_find_atom(struct ofono=
_modem *modem,
 		return NULL;
 =

 	FIND_ATOM_IN_LIST(modem->atoms)
-	FIND_ATOM_IN_LIST(modem->pre_sim_atoms);
 =

 	return NULL;
 }
@@ -301,7 +311,6 @@ void __ofono_modem_foreach_atom(struct ofono_modem *mod=
em,
 		return;
 =

 	FOREACH_ATOM_IN_LIST(modem->atoms)
-	FOREACH_ATOM_IN_LIST(modem->pre_sim_atoms)
 }
 =

 void __ofono_atom_free(struct ofono_atom *atom)
@@ -309,7 +318,6 @@ void __ofono_atom_free(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D atom->modem;
 =

 	modem->atoms =3D g_slist_remove(modem->atoms, atom);
-	modem->pre_sim_atoms =3D g_slist_remove(modem->pre_sim_atoms, atom);
 =

 	__ofono_atom_unregister(atom);
 =

@@ -319,24 +327,139 @@ void __ofono_atom_free(struct ofono_atom *atom)
 	g_free(atom);
 }
 =

-static void remove_all_atoms(GSList **atoms)
+static void flush_atoms(struct ofono_modem *modem,
+			enum ofono_modem_state new_state)
 {
-	GSList *l;
+	GSList *l, *next;
 	struct ofono_atom *atom;
 =

-	for (l =3D *atoms; l; l =3D l->next) {
+	for (l =3D modem->atoms; l; l =3D next) {
 		atom =3D l->data;
+		next =3D l->next;
 =

-		__ofono_atom_unregister(atom);
+		if (atom->modem_state > new_state)
+			__ofono_atom_free(atom);
+	}
+}
 =

-		if (atom->destruct)
-			atom->destruct(atom);
+static void modem_change_state(struct ofono_modem *modem,
+				enum ofono_modem_state new_state)
+{
+	struct ofono_modem_driver const *driver =3D modem->driver;
+	enum ofono_modem_state old_state =3D modem->modem_state;
+	ofono_bool_t new_online =3D new_state =3D=3D OFONO_MODEM_STATE_ONLINE;
+
+	if (old_state =3D=3D new_state)
+		return;
 =

-		g_free(atom);
+	if (new_online !=3D modem->online) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		modem->online =3D new_online;
+		ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE, "Online",
+					DBUS_TYPE_BOOLEAN, &modem->online);
 	}
 =

-	g_slist_free(*atoms);
-	*atoms =3D NULL;
+	modem->modem_state =3D new_state;
+
+	if (old_state > new_state)
+		flush_atoms(modem, new_state);
+
+	switch (new_state) {
+	case OFONO_MODEM_STATE_POWER_OFF:
+		modem->call_ids =3D 0;
+		break;
+
+	case OFONO_MODEM_STATE_PRE_SIM:
+		if (old_state < OFONO_MODEM_STATE_PRE_SIM) {
+			if (driver->pre_sim)
+				driver->pre_sim(modem);
+		} else if (old_state =3D=3D OFONO_MODEM_STATE_ONLINE) {
+			if (driver->set_online)
+				driver->set_online(modem, 0, NULL, NULL);
+		}
+		break;
+
+	case OFONO_MODEM_STATE_OFFLINE:
+		if (old_state < OFONO_MODEM_STATE_OFFLINE) {
+			if (driver->post_sim)
+				driver->post_sim(modem);
+			__ofono_history_probe_drivers(modem);
+			__ofono_nettime_probe_drivers(modem);
+		}
+		break;
+
+	case OFONO_MODEM_STATE_ONLINE:
+		if (driver->post_online)
+			driver->post_online(modem);
+		break;
+	}
+}
+
+static void set_online_callback(const struct ofono_error *error,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+	DBusMessage *reply =3D NULL;
+	ofono_bool_t online =3D modem->online_pending;
+
+	if (error && error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		reply =3D __ofono_error_failed(modem->pending);
+		online =3D modem->online;
+	} else if (online && modem->modem_state < OFONO_MODEM_STATE_OFFLINE) {
+		reply =3D __ofono_error_failed(modem->pending);
+		online =3D FALSE;
+	} else
+		reply =3D dbus_message_new_method_return(modem->pending);
+
+	__ofono_dbus_pending_reply(&modem->pending, reply);
+
+	modem->online_pending =3D online;
+
+	if (modem->online =3D=3D online)
+		return;
+
+	if (online)
+		modem_change_state(modem, OFONO_MODEM_STATE_ONLINE);
+	else
+		modem_change_state(modem, OFONO_MODEM_STATE_OFFLINE);
+}
+
+static DBusMessage *set_property_online(struct ofono_modem *modem,
+					DBusMessage *msg,
+					DBusMessageIter *var)
+{
+	ofono_bool_t online;
+	const struct ofono_modem_driver *driver =3D modem->driver;
+
+	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(var, &online);
+
+	if (modem->online =3D=3D online)
+		return dbus_message_new_method_return(msg);
+
+	if (!driver || !driver->set_online)
+		return __ofono_error_failed(msg);
+
+	if (modem->pending !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	modem->pending =3D dbus_message_ref(msg);
+	modem->online_pending =3D online;
+
+	driver->set_online(modem, online, set_online_callback, modem);
+
+	return NULL;
+}
+
+ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	return modem->online;
 }
 =

 static DBusMessage *modem_get_properties(DBusConnection *conn,
@@ -361,6 +484,9 @@ static DBusMessage *modem_get_properties(DBusConnection=
 *conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

+	ofono_dbus_dict_append(&dict, "Online", DBUS_TYPE_BOOLEAN,
+				&modem->online);
+
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN,
 				&modem->powered);
 =

@@ -420,11 +546,8 @@ static int set_powered(struct ofono_modem *modem, ofon=
o_bool_t powered)
 		return -EALREADY;
 =

 	/* Remove the atoms even if the driver is no longer available */
-	if (powered =3D=3D FALSE) {
-		remove_all_atoms(&modem->atoms);
-		remove_all_atoms(&modem->pre_sim_atoms);
-		modem->call_ids =3D 0;
-	}
+	if (powered =3D=3D FALSE)
+		modem_change_state(modem, OFONO_MODEM_STATE_POWER_OFF);
 =

 	modem->powered_pending =3D powered;
 =

@@ -502,6 +625,9 @@ static DBusMessage *modem_set_property(DBusConnection *=
conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

+	if (g_str_equal(name, "Online"))
+		return set_property_online(modem, msg, &var);
+
 	if (g_str_equal(name, "Powered") =3D=3D TRUE) {
 		ofono_bool_t powered;
 		int err;
@@ -535,10 +661,8 @@ static DBusMessage *modem_set_property(DBusConnection =
*conn,
 						"Powered", DBUS_TYPE_BOOLEAN,
 						&powered);
 =

-		if (powered) {
-			if (modem->driver->pre_sim)
-				modem->driver->pre_sim(modem);
-		}
+		if (powered)
+			modem_change_state(modem, OFONO_MODEM_STATE_PRE_SIM);
 =

 		return NULL;
 	}
@@ -596,14 +720,10 @@ void ofono_modem_set_powered(struct ofono_modem *mode=
m, ofono_bool_t powered)
 						"Powered", DBUS_TYPE_BOOLEAN,
 						&dbus_powered);
 =

-		if (powered) {
-			if (modem->driver->pre_sim)
-				modem->driver->pre_sim(modem);
-		} else {
-			remove_all_atoms(&modem->atoms);
-			remove_all_atoms(&modem->pre_sim_atoms);
-			modem->call_ids =3D 0;
-		}
+		if (powered)
+			modem_change_state(modem, OFONO_MODEM_STATE_PRE_SIM);
+		else
+			modem_change_state(modem, OFONO_MODEM_STATE_POWER_OFF);
 	}
 =

 	if (powering_down && powered =3D=3D FALSE) {
@@ -1132,22 +1252,12 @@ static void modem_sim_ready(void *user, enum ofono_=
sim_state new_state)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_NOT_PRESENT:
-		if (modem->pre_sim_atoms !=3D NULL)
-			remove_all_atoms(&modem->atoms);
+		modem_change_state(modem, OFONO_MODEM_STATE_PRE_SIM);
 		break;
 	case OFONO_SIM_STATE_INSERTED:
 		break;
 	case OFONO_SIM_STATE_READY:
-		if (modem->pre_sim_atoms =3D=3D NULL) {
-			modem->pre_sim_atoms =3D modem->atoms;
-			modem->atoms =3D NULL;
-		}
-
-		if (modem->driver->post_sim)
-			modem->driver->post_sim(modem);
-
-		__ofono_history_probe_drivers(modem);
-		__ofono_nettime_probe_drivers(modem);
+		modem_change_state(modem, OFONO_MODEM_STATE_OFFLINE);
 	}
 }
 =

-- =

1.6.3.3


--===============3219974573147471951==--


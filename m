Content-Type: multipart/mixed; boundary="===============0596979802999103516=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/3] modem: add Emergency property
Date: Mon, 20 Dec 2010 15:21:52 +0200
Message-ID: <4870e881c1203763bedc9afa992f7f7e36b8cc6e.1292849833.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1292849833.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0596979802999103516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |    7 ++
 src/modem.c |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/ofono.h |    5 ++
 3 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index c24615f..3be8d22 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -345,6 +345,13 @@ DBusMessage *__ofono_error_access_denied(DBusMessage *=
msg)
 					"Operation not permitted");
 }
 =

+DBusMessage *__ofono_error_emergency_active(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
+					".EmergencyActive",
+					"Emergency state active");
+}
+
 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
diff --git a/src/modem.c b/src/modem.c
index 2f9387c..1ad72bd 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -61,6 +61,8 @@ enum modem_state {
 struct ofono_modem {
 	char			*path;
 	enum modem_state	modem_state;
+	enum modem_state	modem_state_pre_emergency;
+	ofono_bool_t		modem_state_pending;
 	GSList			*atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList			*interface_list;
@@ -73,6 +75,7 @@ struct ofono_modem {
 	guint			timeout;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
+	unsigned int		emergency;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
@@ -401,6 +404,11 @@ static void modem_change_state(struct ofono_modem *mod=
em,
 =

 	modem->modem_state =3D new_state;
 =

+	if (modem->emergency > 0)
+		modem->modem_state_pre_emergency =3D new_state;
+
+	modem->modem_state_pending =3D FALSE;
+
 	if (old_state > new_state)
 		flush_atoms(modem, new_state);
 =

@@ -440,11 +448,25 @@ static void sim_state_watch(enum ofono_sim_state new_=
state, void *user)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_NOT_PRESENT:
+		if (modem->emergency !=3D 0) {
+			modem->modem_state_pre_emergency =3D MODEM_STATE_PRE_SIM;
+			break;
+		}
+
 		modem_change_state(modem, MODEM_STATE_PRE_SIM);
 		break;
 	case OFONO_SIM_STATE_INSERTED:
 		break;
 	case OFONO_SIM_STATE_READY:
+		if (modem->emergency !=3D 0) {
+			modem->modem_state_pre_emergency =3D MODEM_STATE_OFFLINE;
+
+			if (modem->driver->set_online =3D=3D NULL)
+				modem->modem_state_pre_emergency =3D MODEM_STATE_ONLINE;
+
+			break;
+		}
+
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 =

 		/*
@@ -482,6 +504,73 @@ void __ofono_modem_remove_online_watch(struct ofono_mo=
dem *modem,
 	__ofono_watchlist_remove_item(modem->online_watches, id);
 }
 =

+static void modem_change_online(struct ofono_modem *modem,
+				enum modem_state new_state)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	enum modem_state old_state =3D modem->modem_state;
+	ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE_ONLINE;
+
+	DBG("old state: %d, new state: %d", old_state, new_state);
+
+	modem->modem_state =3D new_state;
+	modem->modem_state_pending =3D FALSE;
+	modem->online =3D new_online;
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE, "Online",
+					DBUS_TYPE_BOOLEAN, &modem->online);
+
+	notify_online_watches(modem);
+}
+
+static void emergency_online_cb(const struct ofono_error *error, void *dat=
a)
+{
+	struct ofono_modem *modem =3D data;
+
+	DBG("modem: %p", modem);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			modem->modem_state !=3D MODEM_STATE_ONLINE) {
+		modem_change_online(modem, MODEM_STATE_ONLINE);
+	} else {
+		modem->modem_state_pending =3D FALSE;
+		notify_online_watches(modem);
+	}
+}
+
+static void emergency_offline_cb(const struct ofono_error *error, void *da=
ta)
+{
+	struct ofono_modem *modem =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	gboolean state =3D FALSE;
+
+	DBG("modem: %p", modem);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			modem->modem_state =3D=3D MODEM_STATE_ONLINE) {
+		modem_change_online(modem, modem->modem_state_pre_emergency);
+	} else {
+		modem->modem_state_pending =3D FALSE;
+		notify_online_watches(modem);
+	}
+
+	modem->emergency--;
+	if (modem->emergency !=3D 0) {
+		modem->modem_state_pending =3D TRUE;
+		modem->driver->set_online(modem, TRUE,
+						emergency_online_cb, modem);
+		return;
+	}
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_MODEM_INTERFACE,
+					"Emergency",
+					DBUS_TYPE_BOOLEAN,
+					&state);
+}
+
 static void online_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -495,9 +584,18 @@ static void online_cb(const struct ofono_error *error,=
 void *data)
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
 =

+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			modem->emergency !=3D 0) {
+		modem->modem_state_pending =3D FALSE;
+		notify_online_watches(modem);
+		return;
+	}
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
 			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
 		modem_change_state(modem, MODEM_STATE_ONLINE);
+	else
+		modem->modem_state_pending =3D FALSE;
 }
 =

 static void offline_cb(const struct ofono_error *error, void *data)
@@ -512,9 +610,99 @@ static void offline_cb(const struct ofono_error *error=
, void *data)
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
 =

+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			modem->emergency !=3D 0) {
+		modem->modem_state_pending =3D FALSE;
+		notify_online_watches(modem);
+		return;
+	}
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-				modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+				modem->modem_state =3D=3D MODEM_STATE_ONLINE) {
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
+
+		if (modem->emergency !=3D 0) {
+			modem->modem_state_pending =3D TRUE;
+			modem->driver->set_online(modem, TRUE,
+						emergency_online_cb, modem);
+		}
+	} else {
+		modem->modem_state_pending =3D FALSE;
+	}
+}
+
+ofono_bool_t ofono_modem_get_emergency(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	return modem->emergency !=3D 0;
+}
+
+void ofono_modem_inc_emergency(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	gboolean state =3D TRUE;
+
+	DBG("modem: %p", modem);
+
+	modem->emergency++;
+	if (modem->emergency > 1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"Emergency",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+
+	if (modem->modem_state_pending =3D=3D TRUE)
+		return;
+
+	if (modem->modem_state =3D=3D MODEM_STATE_ONLINE) {
+		modem->modem_state_pre_emergency =3D MODEM_STATE_ONLINE;
+		return;
+	}
+
+	modem->modem_state_pre_emergency =3D modem->modem_state;
+	modem->modem_state_pending =3D TRUE;
+	modem->driver->set_online(modem, TRUE, emergency_online_cb, modem);
+}
+
+void ofono_modem_dec_emergency(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	gboolean state =3D FALSE;
+
+	DBG("modem: %p", modem);
+
+	if (modem->emergency =3D=3D 0) {
+		ofono_error("Emergency reference counter already 0 on path %s",
+				modem->path);
+		return;
+	}
+
+	if (modem->emergency > 1) {
+		modem->emergency--;
+		return;
+	}
+
+	if (modem->modem_state_pre_emergency !=3D MODEM_STATE_ONLINE) {
+		modem->modem_state_pending =3D TRUE;
+		modem->driver->set_online(modem, FALSE,
+						emergency_offline_cb, modem);
+		return;
+	}
+
+	modem->emergency--;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"Emergency",
+						DBUS_TYPE_BOOLEAN,
+						&state);
 }
 =

 static DBusMessage *set_property_online(struct ofono_modem *modem,
@@ -529,7 +717,10 @@ static DBusMessage *set_property_online(struct ofono_m=
odem *modem,
 =

 	dbus_message_iter_get_basic(var, &online);
 =

-	if (modem->pending !=3D NULL)
+	if (modem->emergency > 0)
+		return __ofono_error_emergency_active(msg);
+
+	if (modem->modem_state_pending =3D=3D TRUE)
 		return __ofono_error_busy(msg);
 =

 	if (driver->set_online =3D=3D NULL)
@@ -542,6 +733,7 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 		return dbus_message_new_method_return(msg);
 =

 	modem->pending =3D dbus_message_ref(msg);
+	modem->modem_state_pending =3D TRUE;
 =

 	driver->set_online(modem, online,
 				online ? online_cb : offline_cb, modem);
@@ -551,7 +743,7 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 =

 ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem)
 {
-	if (modem =3D=3D NULL)
+	if (modem =3D=3D NULL || modem->modem_state_pending =3D=3D TRUE)
 		return FALSE;
 =

 	return modem->online;
@@ -565,6 +757,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	int i;
 	GSList *l;
 	struct ofono_atom *devinfo_atom;
+	ofono_bool_t val;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -572,6 +765,10 @@ void __ofono_modem_append_properties(struct ofono_mode=
m *modem,
 	ofono_dbus_dict_append(dict, "Powered", DBUS_TYPE_BOOLEAN,
 				&modem->powered);
 =

+	val =3D ofono_modem_get_emergency(modem);
+	ofono_dbus_dict_append(dict, "Emergency",
+				DBUS_TYPE_BOOLEAN, &val);
+
 	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO);
 =

 	/* We cheat a little here and don't check the registered status */
@@ -650,6 +847,9 @@ static int set_powered(struct ofono_modem *modem, ofono=
_bool_t powered)
 	if (modem->powered_pending =3D=3D powered)
 		return -EALREADY;
 =

+	if (modem->emergency > 0)
+		return -EPERM;
+
 	/* Remove the atoms even if the driver is no longer available */
 	if (powered =3D=3D FALSE)
 		modem_change_state(modem, MODEM_STATE_POWER_OFF);
@@ -1575,6 +1775,7 @@ static void modem_unregister(struct ofono_modem *mode=
m)
 	if (modem->pending) {
 		dbus_message_unref(modem->pending);
 		modem->pending =3D NULL;
+		modem->modem_state_pending =3D FALSE;
 	}
 =

 	if (modem->interface_update) {
diff --git a/src/ofono.h b/src/ofono.h
index 792134b..336d25b 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -58,6 +58,7 @@ DBusMessage *__ofono_error_not_attached(DBusMessage *msg);
 DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
 DBusMessage *__ofono_error_canceled(DBusMessage *msg);
 DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
+DBusMessage *__ofono_error_emergency_active(DBusMessage *msg);
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
 =

@@ -186,6 +187,10 @@ unsigned int __ofono_modem_add_online_watch(struct ofo=
no_modem *modem,
 void __ofono_modem_remove_online_watch(struct ofono_modem *modem,
 					unsigned int id);
 =

+ofono_bool_t ofono_modem_get_emergency(struct ofono_modem *modem);
+void ofono_modem_inc_emergency(struct ofono_modem *modem);
+void ofono_modem_dec_emergency(struct ofono_modem *modem);
+
 #include <ofono/call-barring.h>
 =

 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
-- =

1.7.0.4


--===============0596979802999103516==--


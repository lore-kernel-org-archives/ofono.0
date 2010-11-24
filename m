Content-Type: multipart/mixed; boundary="===============5349675726856572318=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/4] modem: add EmergencyMode property
Date: Wed, 24 Nov 2010 18:20:32 +0200
Message-ID: <72f9600236cce58ec920ec3ad84b8cc34597c0ca.1290610393.git.Andras.Domokos@nokia.com>
In-Reply-To: <4CEB7F4C.7020002@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5349675726856572318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |    7 +++
 src/modem.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |    5 ++
 3 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index ad29241..0b4fc06 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -348,6 +348,13 @@ DBusMessage *__ofono_error_access_denied(DBusMessage *=
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
index cfc767e..f005877 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -61,6 +61,7 @@ enum modem_state {
 struct ofono_modem {
 	char			*path;
 	enum modem_state	modem_state;
+	enum modem_state	modem_state_pre_emergency;
 	GSList			*atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList			*interface_list;
@@ -73,6 +74,7 @@ struct ofono_modem {
 	guint			timeout;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
+	unsigned int		emergency;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
@@ -517,6 +519,130 @@ static void offline_cb(const struct ofono_error *erro=
r, void *data)
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 }
 =

+ofono_bool_t ofono_modem_get_emergency(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	return modem->emergency !=3D 0;
+}
+
+static void modem_change_online(struct ofono_modem *modem,
+				enum modem_state new_state)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	enum modem_state old_state =3D modem->modem_state;
+	ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE_ONLINE;
+
+	DBG("old state: %d, new state: %d", old_state, new_state);
+
+	if (new_online =3D=3D modem->online)
+		return;
+
+	modem->modem_state =3D new_state;
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
+			modem->modem_state !=3D MODEM_STATE_ONLINE)
+		modem_change_online(modem, MODEM_STATE_ONLINE);
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
+			modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+		modem_change_online(modem, modem->modem_state_pre_emergency);
+
+	modem->emergency--;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_MODEM_INTERFACE,
+					"Emergency",
+					DBUS_TYPE_BOOLEAN,
+					&state);
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
+	modem->modem_state_pre_emergency =3D modem->modem_state;
+
+	if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+		return;
+
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
+	if (modem->modem_state_pre_emergency !=3D MODEM_STATE_ONLINE &&
+			modem->modem_state =3D=3D MODEM_STATE_ONLINE) {
+		modem->driver->set_online(modem, FALSE,
+		emergency_offline_cb, modem);
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
+}
+
 static DBusMessage *set_property_online(struct ofono_modem *modem,
 					DBusMessage *msg,
 					DBusMessageIter *var)
@@ -538,6 +664,9 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 	if (modem->modem_state < MODEM_STATE_OFFLINE)
 		return __ofono_error_not_available(msg);
 =

+	if (modem->emergency > 0)
+		return __ofono_error_emergency_active(msg);
+
 	if (modem->online =3D=3D online)
 		return dbus_message_new_method_return(msg);
 =

@@ -565,6 +694,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	int i;
 	GSList *l;
 	struct ofono_atom *devinfo_atom;
+	ofono_bool_t val;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -572,6 +702,10 @@ void __ofono_modem_append_properties(struct ofono_mode=
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
@@ -650,6 +784,9 @@ static int set_powered(struct ofono_modem *modem, ofono=
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
diff --git a/src/ofono.h b/src/ofono.h
index d1a4bdc..11d939d 100644
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

@@ -185,6 +186,10 @@ unsigned int __ofono_modem_add_online_watch(struct ofo=
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


--===============5349675726856572318==--


Content-Type: multipart/mixed; boundary="===============2608451041142660412=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/4] modem: add EmergencyMode property
Date: Sat, 13 Nov 2010 18:33:43 +0200
Message-ID: <f14e2cfc918ae43de507988fa07d597432840ca3.1289664478.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289664478.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2608451041142660412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andras Domokos <andras.domokos@nokia.com>

---
 src/modem.c |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |    4 ++
 2 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index f73cc1d..5315e72 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -72,6 +72,8 @@ struct ofono_modem {
 	ofono_bool_t		powered_pending;
 	guint			timeout;
 	ofono_bool_t		online;
+	ofono_bool_t		emergency_online;
+	unsigned int		emergency_mode;
 	struct ofono_watchlist	*online_watches;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
@@ -514,6 +516,125 @@ static void offline_cb(const struct ofono_error *erro=
r, void *data)
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 }
 =

+ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem)
+{
+	if (modem =3D=3D NULL)
+		return FALSE;
+
+	return modem->emergency_mode !=3D 0;
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
+	modem->emergency_online =3D modem->online;
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
+			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
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
+		modem_change_online(modem, MODEM_STATE_OFFLINE);
+
+	modem->emergency_mode--;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+}
+
+void ofono_modem_inc_emergency_mode(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	gboolean state =3D TRUE;
+
+	DBG("modem: %p", modem);
+
+	modem->emergency_mode++;
+	if (modem->emergency_mode > 1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+
+	if (modem->online)
+		return;
+
+	modem->driver->set_online(modem, TRUE, emergency_online_cb, modem);
+}
+
+void ofono_modem_dec_emergency_mode(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	gboolean state =3D FALSE;
+
+	DBG("modem: %p", modem);
+
+	if (modem->emergency_mode =3D=3D 0)
+		return;
+
+	if (modem->emergency_mode > 1) {
+		modem->emergency_mode--;
+		return;
+	}
+
+	if (!modem->emergency_online) {
+		modem->driver->set_online(modem, FALSE,
+						emergency_offline_cb, modem);
+		return;
+	}
+
+	modem->emergency_mode--;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+}
+
 static DBusMessage *set_property_online(struct ofono_modem *modem,
 					DBusMessage *msg,
 					DBusMessageIter *var)
@@ -535,6 +656,9 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 	if (modem->modem_state < MODEM_STATE_OFFLINE)
 		return __ofono_error_not_available(msg);
 =

+	if (modem->emergency_mode)
+		return __ofono_error_failed(msg);
+
 	if (modem->online =3D=3D online)
 		return dbus_message_new_method_return(msg);
 =

@@ -562,6 +686,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	int i;
 	GSList *l;
 	struct ofono_atom *devinfo_atom;
+	ofono_bool_t state;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -569,6 +694,10 @@ void __ofono_modem_append_properties(struct ofono_mode=
m *modem,
 	ofono_dbus_dict_append(dict, "Powered", DBUS_TYPE_BOOLEAN,
 				&modem->powered);
 =

+	state =3D ofono_modem_get_emergency_mode(modem);
+	ofono_dbus_dict_append(dict, "EmergencyMode",
+				DBUS_TYPE_BOOLEAN, &state);
+
 	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO);
 =

 	/* We cheat a little here and don't check the registered status */
@@ -647,6 +776,9 @@ static int set_powered(struct ofono_modem *modem, ofono=
_bool_t powered)
 	if (modem->powered_pending =3D=3D powered)
 		return -EALREADY;
 =

+	if (modem->emergency_mode)
+		return -EINVAL;
+
 	/* Remove the atoms even if the driver is no longer available */
 	if (powered =3D=3D FALSE)
 		modem_change_state(modem, MODEM_STATE_POWER_OFF);
diff --git a/src/ofono.h b/src/ofono.h
index 01cd6c0..ac56a85 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -185,6 +185,10 @@ unsigned int __ofono_modem_add_online_watch(struct ofo=
no_modem *modem,
 void __ofono_modem_remove_online_watch(struct ofono_modem *modem,
 		unsigned int id);
 =

+ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
+void ofono_modem_inc_emergency_mode(struct ofono_modem *modem);
+void ofono_modem_dec_emergency_mode(struct ofono_modem *modem);
+
 #include <ofono/call-barring.h>
 =

 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
-- =

1.7.0.4


--===============2608451041142660412==--


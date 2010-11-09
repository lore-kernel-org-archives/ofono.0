Content-Type: multipart/mixed; boundary="===============0684663929979878677=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/3] modem: add EmergencyMode property
Date: Tue, 09 Nov 2010 10:59:44 +0200
Message-ID: <f223f1f32b9778b4968e5041a130bf40d73ef382.1289226246.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289226246.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0684663929979878677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andras Domokos <Andras.Domokos@nokia.com>
---
 src/modem.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ofono.h |    4 ++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index f73cc1d..d7ad90e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -72,6 +72,7 @@ struct ofono_modem {
 	ofono_bool_t		powered_pending;
 	guint			timeout;
 	ofono_bool_t		online;
+	unsigned int		emergency_mode;
 	struct ofono_watchlist	*online_watches;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
@@ -479,6 +480,50 @@ void __ofono_modem_remove_online_watch(struct ofono_mo=
dem *modem, unsigned id)
 	__ofono_watchlist_remove_item(modem->online_watches, id);
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
+void ofono_modem_inc_emergency_mode(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	ofono_bool_t emergency_mode =3D modem->emergency_mode;
+	gboolean state =3D TRUE;
+
+	modem->emergency_mode++;
+	if (emergency_mode)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+	modem_change_state(modem, MODEM_STATE_ONLINE);
+}
+
+void ofono_modem_dec_emergency_mode(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	gboolean state =3D FALSE;
+
+	modem->emergency_mode--;
+	if (modem->emergency_mode)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+}
+
 static void online_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -535,6 +580,9 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 	if (modem->modem_state < MODEM_STATE_OFFLINE)
 		return __ofono_error_not_available(msg);
 =

+	if (modem->emergency_mode && online =3D=3D FALSE)
+		return __ofono_error_failed(msg);
+
 	if (modem->online =3D=3D online)
 		return dbus_message_new_method_return(msg);
 =

@@ -562,6 +610,7 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	int i;
 	GSList *l;
 	struct ofono_atom *devinfo_atom;
+	ofono_bool_t state;
 =

 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -569,6 +618,10 @@ void __ofono_modem_append_properties(struct ofono_mode=
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
diff --git a/src/ofono.h b/src/ofono.h
index 35335b6..b5c32b4 100644
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


--===============0684663929979878677==--


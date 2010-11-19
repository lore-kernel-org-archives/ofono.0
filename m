Content-Type: multipart/mixed; boundary="===============1377956907188163381=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/3] Add Lockdown property to Modem interface
Date: Fri, 19 Nov 2010 19:37:09 -0200
Message-ID: <1290202629-23235-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1290202629-23235-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1377956907188163381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting Lockdown to TRUE means power down the modem and hold a lock that
only permits the lock's owner power up the modem back. When released
it restores the last state of the modem before holding the lock.
---
 doc/modem-api.txt |   10 +++++
 src/modem.c       |  114 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 124 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index c48375e..3dd6dde 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -37,6 +37,16 @@ Properties	boolean Powered [readwrite]
 			Boolean representing the rf state of the modem.
 			Online is false in flight mode.
 =

+		boolean Lockdown [readwrite]
+
+			Boolean representing the lock state of the modem.
+			Setting it to true, makes the calling application hold
+			the modem lock and power it down. Setting to false
+			makes the it restore the modem state before the
+			lockdown and release the modem lock. Only the
+			application that holds the lock can power up the modem.
+			If the the application exits Lockdown is set to false.
+
 		boolean Emergency [readonly, optional, experimental]
 =

 			Boolean representing the emergency mode of the
diff --git a/src/modem.c b/src/modem.c
index 704de29..83b9cee 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -72,6 +72,9 @@ struct ofono_modem {
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
 	ofono_bool_t		reset;
+	ofono_bool_t		lockdown;
+	char			*lock_owner;
+	guint			lock_watch;
 	guint			timeout;
 	ofono_bool_t		online;
 	GHashTable		*properties;
@@ -429,6 +432,9 @@ static void online_cb(const struct ofono_error *error, =
void *data)
 			return;
 		}
 =

+		if (!modem->pending)
+			return;
+
 		reply =3D dbus_message_new_method_return(modem->pending);
 	} else {
 		reply =3D __ofono_error_failed(modem->pending);
@@ -537,6 +543,9 @@ void __ofono_modem_append_properties(struct ofono_modem=
 *modem,
 	ofono_dbus_dict_append(dict, "Powered", DBUS_TYPE_BOOLEAN,
 				&modem->powered);
 =

+	ofono_dbus_dict_append(dict, "Lockdown", DBUS_TYPE_BOOLEAN,
+				&modem->lockdown);
+
 	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO);
 =

 	/* We cheat a little here and don't check the registered status */
@@ -671,6 +680,22 @@ static gboolean set_powered_timeout(gpointer user)
 	return FALSE;
 }
 =

+static void lockdown_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	g_free(modem->lock_owner);
+
+	modem->lockdown =3D FALSE;
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE,
+					"Lockdown", DBUS_TYPE_BOOLEAN,
+					&modem->lockdown);
+}
+
 static DBusMessage *modem_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -713,6 +738,9 @@ static DBusMessage *modem_set_property(DBusConnection *=
conn,
 		if (modem->powered =3D=3D powered)
 			return dbus_message_new_method_return(msg);
 =

+		if (modem->lockdown)
+			return __ofono_error_access_denied(msg);
+
 		err =3D set_powered(modem, powered);
 		if (err < 0) {
 			if (err !=3D -EINPROGRESS)
@@ -744,6 +772,92 @@ static DBusMessage *modem_set_property(DBusConnection =
*conn,
 		return NULL;
 	}
 =

+	if (g_str_equal(name, "Lockdown")) {
+		ofono_bool_t lockdown, powered;
+		const char *caller;
+		int err;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &lockdown);
+
+		if (modem->pending !=3D NULL)
+			return __ofono_error_busy(msg);
+
+		if (modem->lockdown =3D=3D lockdown)
+			return dbus_message_new_method_return(msg);
+
+		if (modem->powered !=3D modem->powered_pending || modem->reset)
+			return __ofono_error_not_available(msg);
+
+		caller =3D dbus_message_get_sender(msg);
+
+		if (lockdown) {
+			modem->lock_owner =3D g_strdup(caller);
+
+			modem->lock_watch =3D g_dbus_add_service_watch(conn,
+					modem->lock_owner, NULL,
+					lockdown_disconnect, modem, NULL);
+
+			if (modem->lock_watch =3D=3D 0) {
+				g_free(modem->lock_owner);
+				return __ofono_error_failed(msg);
+			}
+
+			modem->old_state =3D modem->modem_state;
+			powered =3D FALSE;
+		} else {
+			if (g_strcmp0(caller, modem->lock_owner))
+				return __ofono_error_access_denied(msg);
+
+			g_free(modem->lock_owner);
+			g_dbus_remove_watch(conn, modem->lock_watch);
+
+			if (modem->old_state > MODEM_STATE_POWER_OFF)
+				powered =3D TRUE;
+			else
+				powered =3D FALSE;
+		}
+
+		modem->lockdown =3D lockdown;
+
+		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+		ofono_dbus_signal_property_changed(conn, modem->path,
+						OFONO_MODEM_INTERFACE,
+						"Lockdown", DBUS_TYPE_BOOLEAN,
+						&lockdown);
+
+		err =3D set_powered(modem, powered);
+		if (err < 0) {
+			if (err !=3D -EINPROGRESS)
+				return __ofono_error_failed(msg);
+
+			modem->pending =3D dbus_message_ref(msg);
+			modem->timeout =3D g_timeout_add_seconds(20,
+						set_powered_timeout, modem);
+			return NULL;
+		}
+
+		ofono_dbus_signal_property_changed(conn, modem->path,
+						OFONO_MODEM_INTERFACE,
+						"Powered", DBUS_TYPE_BOOLEAN,
+						&powered);
+
+		if (powered) {
+			modem_change_state(modem, MODEM_STATE_PRE_SIM);
+
+			/* Force SIM Ready for devies with no sim atom */
+			if (__ofono_modem_find_atom(modem,
+						OFONO_ATOM_TYPE_SIM) =3D=3D NULL)
+				sim_state_watch(OFONO_SIM_STATE_READY, modem);
+		} else
+			modem_change_state(modem, MODEM_STATE_POWER_OFF);
+
+		return NULL;
+	}
+
 	return __ofono_error_invalid_args(msg);
 }
 =

-- =

1.7.3.1


--===============1377956907188163381==--


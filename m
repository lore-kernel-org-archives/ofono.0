Content-Type: multipart/mixed; boundary="===============5906437283029927955=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] modem: add Lockdown property to Modem interface
Date: Fri, 03 Dec 2010 19:59:49 -0200
Message-ID: <1291413590-22873-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5906437283029927955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting Lockdown to TRUE means power down the modem and hold a lock that
only permits the lock's owner power up the modem back. When released
it restores the last state of the modem before holding the lock.
---
 doc/modem-api.txt |    9 ++++
 src/modem.c       |  129 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 138 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index b92e53c..45043b0 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -37,6 +37,15 @@ Properties	boolean Powered [readwrite]
 			Boolean representing the rf state of the modem.
 			Online is false in flight mode.
 =

+		boolean Lockdown [readwrite]
+
+			Boolean representing the lock state of the modem.
+			Setting it to true, makes the calling application hold
+			the modem lock and power it down. Setting to false
+			makes the it release the modem lock. Only the
+			application that holds the lock can power up the modem.
+			If the the application exits Lockdown is set to false.
+
 		boolean Emergency [readonly, optional, experimental]
 =

 			Boolean representing the emergency mode of the
diff --git a/src/modem.c b/src/modem.c
index b334b58..a9a6e87 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -71,6 +71,9 @@ struct ofono_modem {
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
 	ofono_bool_t		get_online;
+	ofono_bool_t		lockdown;
+	char			*lock_owner;
+	guint			lock_watch;
 	guint			timeout;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
@@ -583,6 +586,9 @@ void __ofono_modem_append_properties(struct ofono_modem=
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
@@ -686,6 +692,16 @@ static int set_powered(struct ofono_modem *modem, ofon=
o_bool_t powered)
 	return err;
 }
 =

+static void lockdown_remove(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3Dofono_dbus_get_connection();
+
+	g_free(modem->lock_owner);
+	g_dbus_remove_watch(conn, modem->lock_watch);
+	modem->lock_watch =3D 0;
+	modem->lockdown =3D FALSE;
+}
+
 static gboolean set_powered_timeout(gpointer user)
 {
 	struct ofono_modem *modem =3D user;
@@ -712,11 +728,107 @@ static gboolean set_powered_timeout(gpointer user)
 =

 		reply =3D __ofono_error_timed_out(modem->pending);
 		__ofono_dbus_pending_reply(&modem->pending, reply);
+
+		if (modem->lockdown)
+			lockdown_remove(modem);
 	}
 =

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
+static DBusMessage *set_property_lockdown(struct ofono_modem *modem,
+					DBusMessage *msg,
+					DBusMessageIter *var)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	ofono_bool_t lockdown;
+	const char *caller;
+	int err;
+
+	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(var, &lockdown);
+
+	if (modem->pending !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	if (modem->lockdown =3D=3D lockdown)
+		return dbus_message_new_method_return(msg);
+
+	caller =3D dbus_message_get_sender(msg);
+
+	if (lockdown) {
+		dbus_bool_t powered;
+
+		modem->lock_owner =3D g_strdup(caller);
+
+		modem->lock_watch =3D g_dbus_add_service_watch(conn,
+				modem->lock_owner, NULL,
+				lockdown_disconnect, modem, NULL);
+
+		if (modem->lock_watch =3D=3D 0) {
+			g_free(modem->lock_owner);
+			return __ofono_error_failed(msg);
+		}
+
+		modem->lockdown =3D lockdown;
+
+		if (!modem->powered)
+			goto done;
+
+		err =3D set_powered(modem, FALSE);
+		if (err < 0) {
+			if (err !=3D -EINPROGRESS) {
+				lockdown_remove(modem);
+				return __ofono_error_failed(msg);
+			}
+
+			modem->pending =3D dbus_message_ref(msg);
+			modem->timeout =3D g_timeout_add_seconds(20,
+						set_powered_timeout, modem);
+			return NULL;
+		}
+
+		powered =3D FALSE;
+		ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE,
+					"Powered", DBUS_TYPE_BOOLEAN,
+					&powered);
+	} else {
+		if (g_strcmp0(caller, modem->lock_owner))
+			return __ofono_error_access_denied(msg);
+
+		lockdown_remove(modem);
+	}
+
+done:
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE,
+					"Lockdown", DBUS_TYPE_BOOLEAN,
+					&lockdown);
+
+	return NULL;
+}
+
 static DBusMessage *modem_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -759,6 +871,9 @@ static DBusMessage *modem_set_property(DBusConnection *=
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
@@ -790,6 +905,9 @@ static DBusMessage *modem_set_property(DBusConnection *=
conn,
 		return NULL;
 	}
 =

+	if (g_str_equal(name, "Lockdown"))
+		return set_property_lockdown(modem, msg, &var);
+
 	return __ofono_error_invalid_args(msg);
 }
 =

@@ -834,6 +952,12 @@ void ofono_modem_set_powered(struct ofono_modem *modem=
, ofono_bool_t powered)
 =

 	modem->powered =3D powered;
 =

+	if (modem->lockdown)
+		ofono_dbus_signal_property_changed(conn, modem->path,
+					OFONO_MODEM_INTERFACE,
+					"Lockdown", DBUS_TYPE_BOOLEAN,
+					&modem->lockdown);
+
 	if (modem->driver =3D=3D NULL) {
 		ofono_error("Calling ofono_modem_set_powered on a"
 				"modem with no driver is not valid, "
@@ -1593,6 +1717,11 @@ static void modem_unregister(struct ofono_modem *mod=
em)
 		modem->interface_update =3D 0;
 	}
 =

+	if (modem->lock_watch) {
+		g_dbus_remove_watch(conn, modem->lock_watch);
+		modem->lock_watch =3D 0;
+	}
+
 	g_dbus_unregister_interface(conn, modem->path, OFONO_MODEM_INTERFACE);
 =

 	if (modem->driver && modem->driver->remove)
-- =

1.7.3.2


--===============5906437283029927955==--


Content-Type: multipart/mixed; boundary="===============0594635651515026405=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 6/9] modem: modem state decoupled from rf state
Date: Thu, 31 Mar 2011 09:18:29 -0700
Message-ID: <1301588312-6932-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0594635651515026405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   80 ++++++++++++++++++++++++++++++++++++++++---------------=
---
 1 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 72937a3..126c0e6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -416,26 +416,34 @@ static void notify_powered_watches(struct ofono_modem=
 *modem)
 	}
 }
 =

+static void set_online(struct ofono_modem *modem, ofono_bool_t new_online)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (new_online =3D=3D modem->online)
+		return;
+
+	modem->online =3D new_online;
+
+	ofono_dbus_signal_property_changed(conn, modem->path,
+						OFONO_MODEM_INTERFACE,
+						"Online", DBUS_TYPE_BOOLEAN,
+						&modem->online);
+
+	notify_online_watches(modem);
+}
+
 static void modem_change_state(struct ofono_modem *modem,
 				enum modem_state new_state)
 {
 	struct ofono_modem_driver const *driver =3D modem->driver;
 	enum modem_state old_state =3D modem->modem_state;
-	ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE_ONLINE;
 =

 	DBG("old state: %d, new state: %d", old_state, new_state);
 =

 	if (old_state =3D=3D new_state)
 		return;
 =

-	if (new_online !=3D modem->online) {
-		DBusConnection *conn =3D ofono_dbus_get_connection();
-		modem->online =3D new_online;
-		ofono_dbus_signal_property_changed(conn, modem->path,
-					OFONO_MODEM_INTERFACE, "Online",
-					DBUS_TYPE_BOOLEAN, &modem->online);
-	}
-
 	modem->modem_state =3D new_state;
 =

 	if (old_state > new_state)
@@ -457,8 +465,7 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 				driver->post_sim(modem);
 			__ofono_history_probe_drivers(modem);
 			__ofono_nettime_probe_drivers(modem);
-		} else
-			notify_online_watches(modem);
+		}
 =

 		break;
 =

@@ -466,7 +473,6 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 		if (driver->post_online)
 			driver->post_online(modem);
 =

-		notify_online_watches(modem);
 		break;
 	}
 }
@@ -541,14 +547,22 @@ static void common_online_cb(const struct ofono_error=
 *error, void *data)
 	 */
 	switch (modem->modem_state) {
 	case MODEM_STATE_OFFLINE:
+		set_online(modem, TRUE);
+
+		/* Will this increase emergency call setup time??? */
 		modem_change_state(modem, MODEM_STATE_ONLINE);
 		break;
 	case MODEM_STATE_POWER_OFF:
 		/* The powered operation is pending */
 		break;
 	case MODEM_STATE_PRE_SIM:
-		/* Go back offline if the sim was removed or reset */
-		modem->driver->set_online(modem, 0, NULL, NULL);
+		/*
+		 * Its valid to be in online even without a SIM/SIM being
+		 * PIN locked. e.g.: Emergency mode
+		 */
+		DBG("Online in PRE SIM state");
+
+		set_online(modem, TRUE);
 		break;
 	case MODEM_STATE_ONLINE:
 		ofono_error("Online called when the modem is already online!");
@@ -564,8 +578,7 @@ static void online_cb(const struct ofono_error *error, =
void *data)
 	if (!modem->pending)
 		goto out;
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		reply =3D dbus_message_new_method_return(modem->pending);
 	else
 		reply =3D __ofono_error_failed(modem->pending);
@@ -588,9 +601,19 @@ static void offline_cb(const struct ofono_error *error=
, void *data)
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-				modem->modem_state =3D=3D MODEM_STATE_ONLINE)
-		modem_change_state(modem, MODEM_STATE_OFFLINE);
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		switch (modem->modem_state) {
+		case MODEM_STATE_PRE_SIM:
+			set_online(modem, FALSE);
+			break;
+		case MODEM_STATE_ONLINE:
+			set_online(modem, FALSE);
+			modem_change_state(modem, MODEM_STATE_OFFLINE);
+			break;
+		default:
+			break;
+		}
+	}
 }
 =

 static void sim_state_watch(enum ofono_sim_state new_state, void *user)
@@ -609,7 +632,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *user)
 		 * If we don't have the set_online method, also proceed
 		 * straight to the online state
 		 */
-		if (modem->driver->set_online =3D=3D NULL)
+		if (modem->driver->set_online =3D=3D NULL || modem->online =3D=3D TRUE)
 			modem_change_state(modem, MODEM_STATE_ONLINE);
 		else if (modem->get_online)
 			modem->driver->set_online(modem, 1, common_online_cb,
@@ -642,9 +665,6 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 	if (driver->set_online =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

-	if (modem->modem_state < MODEM_STATE_OFFLINE)
-		return __ofono_error_not_available(msg);
-
 	modem->pending =3D dbus_message_ref(msg);
 =

 	driver->set_online(modem, online,
@@ -814,6 +834,8 @@ static gboolean set_powered_timeout(gpointer user)
 		DBusConnection *conn =3D ofono_dbus_get_connection();
 		dbus_bool_t powered =3D FALSE;
 =

+		set_online(modem, FALSE);
+
 		modem->powered =3D FALSE;
 		notify_powered_watches(modem);
 =

@@ -915,6 +937,8 @@ static DBusMessage *set_property_lockdown(struct ofono_=
modem *modem,
 		return NULL;
 	}
 =

+	set_online(modem, FALSE);
+
 	powered =3D FALSE;
 	ofono_dbus_signal_property_changed(conn, modem->path,
 					OFONO_MODEM_INTERFACE,
@@ -1002,8 +1026,11 @@ static DBusMessage *modem_set_property(DBusConnectio=
n *conn,
 			if (__ofono_modem_find_atom(modem,
 						OFONO_ATOM_TYPE_SIM) =3D=3D NULL)
 				sim_state_watch(OFONO_SIM_STATE_READY, modem);
-		} else
+		} else {
+			set_online(modem, FALSE);
+
 			modem_change_state(modem, MODEM_STATE_POWER_OFF);
+		}
 =

 		return NULL;
 	}
@@ -1081,8 +1108,11 @@ void ofono_modem_set_powered(struct ofono_modem *mod=
em, ofono_bool_t powered)
 		if (__ofono_modem_find_atom(modem,
 					OFONO_ATOM_TYPE_SIM) =3D=3D NULL)
 			sim_state_watch(OFONO_SIM_STATE_READY, modem);
-	} else
+	} else {
+		set_online(modem, FALSE);
+
 		modem_change_state(modem, MODEM_STATE_POWER_OFF);
+	}
 =

 out:
 	if (powering_down && powered =3D=3D FALSE) {
-- =

1.7.0.4


--===============0594635651515026405==--


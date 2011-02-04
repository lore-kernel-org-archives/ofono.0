Content-Type: multipart/mixed; boundary="===============7639382551312763246=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [RFC] sim: check if lock is locked after code changing attempt
Date: Fri, 04 Feb 2011 17:47:55 +0200
Message-ID: <1296834475-32299-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7639382551312763246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Hi,

>> So I'm mostly happy with this approach except that ofono_modem_reset is
> >> too big of a hammer to use here.  We need something that drops us back
> >> to pre-sim state without having to re-power on the device (which is wh=
at
> >> reset does).
> >>
> >> Can you try using sim_inserted / sim_removed or maybe even be smarter
> >> and do 90% of what sim removal does but without affecting information
> >> which is already read.  So things like EFiccid, EFpl/EFlp, EFecc, etc.
> >>
> >> Regards,
> >> -Denis

Here is the proposal now. I'm sending this as RFC now since I really think
that it should be tested with more than one modem to be sure that nothing g=
ot
broken. I touched the whole state machine and invented a new modem state to =

prevent all the apis getting flushed when code went blocked and to prevent =

sim initialization after unblocking. =


Personally I don't like this patch much. My favourite approach with this =

would be that previous version of this patch would be accepted in and state =

modification issue would be handled as separate matter. =


Br,

Jussi

 include/modem.h |    2 +
 src/modem.c     |   35 ++++++++++++++++++++++++++++++--
 src/sim.c       |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index a92eb88..d32f306 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -46,6 +46,8 @@ int ofono_modem_register(struct ofono_modem *modem);
 ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem);
 void ofono_modem_remove(struct ofono_modem *modem);
 =

+void ofono_modem_blocked(struct ofono_modem *modem);
+
 void ofono_modem_reset(struct ofono_modem *modem);
 =

 void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
diff --git a/src/modem.c b/src/modem.c
index 8e243d8..ccd86b9 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -56,6 +56,7 @@ enum modem_state {
 	MODEM_STATE_PRE_SIM,
 	MODEM_STATE_OFFLINE,
 	MODEM_STATE_ONLINE,
+	MODEM_STATE_BLOCKED,
 };
 =

 struct ofono_modem {
@@ -343,7 +344,17 @@ static void flush_atoms(struct ofono_modem *modem, enu=
m modem_state new_state)
 	while (cur) {
 		struct ofono_atom *atom =3D cur->data;
 =

-		if (atom->modem_state <=3D new_state) {
+		DBG("atom type is %d", atom->type);
+
+		if (new_state =3D=3D MODEM_STATE_BLOCKED) {
+			if ((atom->type =3D=3D OFONO_ATOM_TYPE_PHONEBOOK) ||
+				(atom->type =3D=3D OFONO_ATOM_TYPE_SIM_AUTH) ||
+					(atom->type =3D=3D OFONO_ATOM_TYPE_SIM)) {
+				prev =3D cur;
+				cur =3D cur->next;
+				continue;
+			}
+		} else if (atom->modem_state <=3D new_state) {
 			prev =3D cur;
 			cur =3D cur->next;
 			continue;
@@ -403,9 +414,13 @@ static void modem_change_state(struct ofono_modem *mod=
em,
 					DBUS_TYPE_BOOLEAN, &modem->online);
 	}
 =

-	modem->modem_state =3D new_state;
+	if (old_state =3D=3D MODEM_STATE_BLOCKED &&
+		modem->get_online =3D=3D TRUE)
+		modem->modem_state =3D MODEM_STATE_ONLINE;
+	else
+		modem->modem_state =3D new_state;
 =

-	if (old_state > new_state)
+	if (old_state > new_state || new_state =3D=3D MODEM_STATE_BLOCKED)
 		flush_atoms(modem, new_state);
 =

 	switch (new_state) {
@@ -414,6 +429,7 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 		break;
 =

 	case MODEM_STATE_PRE_SIM:
+	case MODEM_STATE_BLOCKED:
 		if (old_state < MODEM_STATE_PRE_SIM && driver->pre_sim)
 			driver->pre_sim(modem);
 		break;
@@ -490,6 +506,7 @@ static void common_online_cb(const struct ofono_error *=
error, void *data)
 		/* The powered operation is pending */
 		break;
 	case MODEM_STATE_PRE_SIM:
+	case MODEM_STATE_BLOCKED:
 		/* Go back offline if the sim was removed */
 		modem->driver->set_online(modem, 0, NULL, NULL);
 		break;
@@ -1800,6 +1817,18 @@ void ofono_modem_remove(struct ofono_modem *modem)
 	g_free(modem->name);
 	g_free(modem->path);
 	g_free(modem);
+	DBG("OUT");
+}
+
+void ofono_modem_blocked(struct ofono_modem *modem)
+{
+	if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+		modem->get_online =3D TRUE;
+	modem_change_state(modem, MODEM_STATE_BLOCKED);
+	ofono_modem_set_powered(modem, TRUE);
+	modem->sim_ready_watch =3D ofono_sim_add_state_watch(modem->sim,
+							sim_state_watch,
+							modem, NULL);
 }
 =

 void ofono_modem_reset(struct ofono_modem *modem)
diff --git a/src/sim.c b/src/sim.c
index 52261c8..b2b2591 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -616,6 +616,50 @@ static void sim_locked_cb(struct ofono_sim *sim, gbool=
ean locked)
 	sim_pin_retries_check(sim);
 }
 =

+static void fail_reason_check_cb(const struct ofono_error *error,
+				enum ofono_sim_password_type pin_type,
+				void *data)
+{
+	DBG("IN");
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
+	const char *pin_name;
+
+	if (sim->pin_type !=3D pin_type) {
+		DBG("Code is locked");
+		sim->pin_type =3D pin_type;
+		pin_name =3D sim_passwd_name(pin_type);
+
+		if (pin_type !=3D OFONO_SIM_PASSWORD_NONE &&
+				password_is_pin(pin_type) =3D=3D FALSE)
+			pin_type =3D puk2pin(pin_type);
+
+		if (pin_type !=3D OFONO_SIM_PASSWORD_INVALID)
+			sim->locked_pins[pin_type] =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"PinRequired", DBUS_TYPE_STRING,
+						&pin_name);
+
+		if ((sim->state !=3D OFONO_SIM_STATE_READY) ||
+		   ((sim->locked_pins[pin_type] =3D=3D TRUE) && (
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHSIM_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHFSIM_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHNET_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHNETSUB_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHSP_PIN ||
+		     pin_type =3D=3D OFONO_SIM_PASSWORD_PHCORP_PIN))){
+			DBG("set modem to PRE_SIM state");
+			ofono_modem_blocked(modem);
+		}
+	}
+	DBG("OUT");
+}
+
 static void sim_unlock_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
@@ -624,6 +668,9 @@ static void sim_unlock_cb(const struct ofono_error *err=
or, void *data)
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
 =

 		__ofono_dbus_pending_reply(&sim->pending, reply);
+
+		sim->driver->query_passwd_state(sim, fail_reason_check_cb, sim);
+
 		sim_pin_retries_check(sim);
 =

 		return;
@@ -640,6 +687,9 @@ static void sim_lock_cb(const struct ofono_error *error=
, void *data)
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
 =

 		__ofono_dbus_pending_reply(&sim->pending, reply);
+
+		sim->driver->query_passwd_state(sim, fail_reason_check_cb, sim);
+
 		sim_pin_retries_check(sim);
 =

 		return;
@@ -711,6 +761,8 @@ static void sim_change_pin_cb(const struct ofono_error =
*error, void *data)
 		__ofono_dbus_pending_reply(&sim->pending,
 				__ofono_error_failed(sim->pending));
 =

+		sim->driver->query_passwd_state(sim, fail_reason_check_cb, sim);
+
 		sim_pin_retries_check(sim);
 =

 		return;
@@ -1673,8 +1725,11 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 	sim_pin_retries_check(sim);
 =

 checkdone:
-	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
+	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE &&
+		sim->state !=3D OFONO_SIM_STATE_READY)
 		sim_initialize_after_pin(sim);
+	else if (sim->state =3D=3D OFONO_SIM_STATE_READY)
+		sim_set_ready(sim);
 }
 =

 static void sim_pin_check(struct ofono_sim *sim)
-- =

1.7.1


--===============7639382551312763246==--


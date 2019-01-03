Content-Type: multipart/mixed; boundary="===============8910967687462831464=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 03 Jan 2019 16:31:22 +0530
Message-ID: <1546513282-13190-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8910967687462831464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding SIM PIN caching feature to oFono. oFono now caches the SIM PIN1 type
against the ICCID throughout its lifetime in a link list and enters
implicitly upon modem reset/crash.

Violates 3GPP spec 21.111, section 5.3 - User Data stored in ME. Helps
in user experience by not barring out cellular services unless pin is enter=
ed
manually.

Handles cases of incorrect pin and sim pin changed externally.
Clears all cached PINs incase modem disabled manually and selectively when
sim is removed.

Adding to all modems by default.
---
 src/sim.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 128 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 886f291..dd28484 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -143,6 +143,11 @@ struct ofono_sim {
 	bool wait_initialized : 1;
 };
 =

+struct cached_pin {
+	char *id;
+	char *pin;
+};
+
 struct msisdn_set_request {
 	struct ofono_sim *sim;
 	int pending;
@@ -178,6 +183,8 @@ static void sim_own_numbers_update(struct ofono_sim *si=
m);
 =

 static GSList *g_drivers =3D NULL;
 =

+static GSList *cached_pins =3D NULL;
+
 static const char *sim_passwd_name(enum ofono_sim_password_type type)
 {
 	return passwd_name[type];
@@ -475,6 +482,78 @@ done:
 	return reply;
 }
 =

+static struct cached_pin *pin_cache_lookup(const char *iccid)
+{
+	struct cached_pin *c;
+	GSList *l;
+
+	if (cached_pins =3D=3D NULL)
+		return NULL;
+
+	for (l =3D cached_pins; l; l =3D l->next) {
+		c =3D l->data;
+
+		if (g_strcmp0(iccid, c->id) =3D=3D 0)
+			return c;
+	}
+
+	return NULL;
+}
+
+static gboolean pin_cache_update(const char *iccid, const char *pin)
+{
+	struct cached_pin *pin_cached =3D pin_cache_lookup(iccid);
+	struct cached_pin *cpins;
+
+	if (pin_cached !=3D NULL) {
+		g_free(pin_cached->pin);
+		pin_cached->pin =3D g_strdup(pin);
+		return TRUE;
+	}
+
+	cpins =3D g_new0(struct cached_pin, 1);
+
+	if (cpins =3D=3D NULL)
+		return FALSE;
+
+	cpins->id =3D g_strdup(iccid);
+	cpins->pin =3D g_strdup(pin);
+	cached_pins =3D g_slist_prepend(cached_pins, cpins);
+
+	return TRUE;
+}
+
+static void pin_cache_remove(const char *iccid)
+{
+	struct cached_pin *pin_cached =3D pin_cache_lookup(iccid);
+
+	if (pin_cached =3D=3D NULL)
+		return;
+
+	cached_pins =3D g_slist_remove(cached_pins, pin_cached);
+}
+
+static void pin_cache_enter_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	/* If PIN entry fails, then remove cached PIN*/
+	if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		pin_cache_remove(sim->iccid);
+		goto recheck;
+	}
+
+	if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
+			sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK) {
+		sim->wait_initialized =3D true;
+		DBG("Waiting for ofono_sim_initialized_notify");
+		return;
+	}
+
+recheck:
+	__ofono_sim_recheck_pin(sim);
+}
+
 static void sim_pin_retries_query_cb(const struct ofono_error *error,
 					int retries[OFONO_SIM_PASSWORD_INVALID],
 					void *data)
@@ -683,6 +762,13 @@ static void sim_locked_cb(struct ofono_sim *sim, gbool=
ean locked)
 						OFONO_SIM_MANAGER_INTERFACE,
 						"LockedPins", DBUS_TYPE_STRING,
 						&locked_pins);
+
+	/*Cache pin only for SIM PIN type*/
+	if (g_strcmp0(typestr, "pin") =3D=3D 0) {
+		if (!pin_cache_update(sim->iccid, pin))
+			ofono_error("Failed to cache PIN.");
+	}
+
 	g_strfreev(locked_pins);
 =

 	sim_pin_retries_check(sim);
@@ -778,6 +864,14 @@ static DBusMessage *sim_unlock_pin(DBusConnection *con=
n, DBusMessage *msg,
 static void sim_change_pin_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
+	const char *typestr;
+	const char *old;
+	const char *new;
+
+	dbus_message_get_args(sim->pending, NULL, DBUS_TYPE_STRING, &typestr,
+					     DBUS_TYPE_STRING, &old,
+					     DBUS_TYPE_STRING, &new,
+				             DBUS_TYPE_INVALID);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		__ofono_dbus_pending_reply(&sim->pending,
@@ -788,6 +882,12 @@ static void sim_change_pin_cb(const struct ofono_error=
 *error, void *data)
 		return;
 	}
 =

+	/*Cache pin only for SIM PIN type*/
+	if (g_strcmp0(typestr, "pin") =3D=3D 0) {
+		if (!pin_cache_update(sim->iccid, new))
+			ofono_error("Failed to cache PIN.");
+	}
+
 	__ofono_dbus_pending_reply(&sim->pending,
 				dbus_message_new_method_return(sim->pending));
 =

@@ -839,8 +939,14 @@ static DBusMessage *sim_change_pin(DBusConnection *con=
n, DBusMessage *msg,
 static void sim_enter_pin_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim =3D data;
+	const char *typestr;
+	const char *pin;
 	DBusMessage *reply;
 =

+	dbus_message_get_args(sim->pending, NULL, DBUS_TYPE_STRING, &typestr,
+					     DBUS_TYPE_STRING, &pin,
+					     DBUS_TYPE_INVALID);
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		reply =3D __ofono_error_failed(sim->pending);
 	else
@@ -852,6 +958,12 @@ static void sim_enter_pin_cb(const struct ofono_error =
*error, void *data)
 	if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		goto recheck;
 =

+	/*Cache pin only for SIM PIN type*/
+	if (g_strcmp0(typestr, "pin") =3D=3D 0) {
+		if (!pin_cache_update(sim->iccid, pin))
+			ofono_error("Failed to cache PIN.");
+	}
+
 	if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
 			sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK) {
 		sim->wait_initialized =3D true;
@@ -2751,6 +2863,8 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim,=
 ofono_bool_t inserted)
 		sim->pin_retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D -1;
 		sim->pin_retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D -1;
 =

+		pin_cache_remove(sim->iccid);
+
 		sim_free_state(sim);
 	}
 }
@@ -3024,6 +3138,7 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 	struct ofono_sim *sim =3D data;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sim->atom);
+	struct cached_pin *cpins =3D pin_cache_lookup(sim->iccid);
 	const char *pin_name;
 	char **locked_pins;
 	gboolean lock_changed;
@@ -3068,6 +3183,10 @@ static void sim_pin_query_cb(const struct ofono_erro=
r *error,
 						&pin_name);
 	}
 =

+	if (g_strcmp0(pin_name, "pin") =3D=3D 0 && cpins !=3D NULL)
+		sim->driver->send_passwd(sim, cpins->pin,
+					       pin_cache_enter_cb, sim);
+
 	switch (pin_type) {
 	case OFONO_SIM_PASSWORD_NONE:
 	case OFONO_SIM_PASSWORD_SIM_PIN2:
@@ -3301,6 +3420,15 @@ void ofono_sim_register(struct ofono_sim *sim)
 	__ofono_atom_register(sim->atom, sim_unregister);
 }
 =

+void ofono_sim_clear_cached_pins(void)
+{
+	if (cached_pins =3D=3D NULL)
+		return;
+
+	g_slist_free_full(cached_pins, g_free);
+	cached_pins =3D NULL;
+}
+
 void ofono_sim_remove(struct ofono_sim *sim)
 {
 	__ofono_atom_free(sim->atom);
-- =

2.7.4


--===============8910967687462831464==--


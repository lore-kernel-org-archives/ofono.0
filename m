Content-Type: multipart/mixed; boundary="===============7668222230259392587=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 4/6] sim: query remaining pin retries
Date: Mon, 10 Jan 2011 19:02:29 -0200
Message-ID: <1294693351-25475-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294693351-25475-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7668222230259392587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check the remaining pin retries after each operation that might have
changed it, i.e. locking, unlocking, reseting or changing pin.
---
 src/sim.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 335f611..02547a1 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -62,6 +62,8 @@ struct ofono_sim {
 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
 =

+	int pin_retries[OFONO_SIM_PASSWORD_INVALID];
+
 	enum ofono_sim_phase phase;
 	unsigned char mnc_length;
 	enum ofono_sim_cphs_phase cphs_phase;
@@ -248,6 +250,33 @@ static char **get_locked_pins(struct ofono_sim *sim)
 	return ret;
 }
 =

+static void **get_pin_retries(struct ofono_sim *sim)
+{
+	int i, nelem;
+	void **ret;
+
+	for (i =3D 1, nelem =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++) {
+		if (sim->pin_retries[i] =3D=3D -1)
+			continue;
+
+		nelem+=3D1;
+	}
+
+	ret =3D g_new0(void *, nelem * 2 + 1);
+
+	nelem =3D 0;
+
+	for (i =3D 1; i < OFONO_SIM_PASSWORD_INVALID; i++) {
+		if (sim->pin_retries[i] =3D=3D -1)
+			continue;
+
+		ret[nelem++] =3D (void *) sim_passwd_name(i);
+		ret[nelem++] =3D &sim->pin_retries[i];
+	}
+
+	return ret;
+}
+
 static char **get_service_numbers(GSList *service_numbers)
 {
 	int nelem;
@@ -287,6 +316,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	char **service_numbers;
 	char **locked_pins;
 	const char *pin_name;
+	void **pin_retries;
 	dbus_bool_t present =3D sim->state !=3D OFONO_SIM_STATE_NOT_PRESENT;
 	dbus_bool_t fdn;
 	dbus_bool_t bdn;
@@ -369,12 +399,53 @@ static DBusMessage *sim_get_properties(DBusConnection=
 *conn,
 				DBUS_TYPE_STRING,
 				(void *) &pin_name);
 =

+	pin_retries =3D get_pin_retries(sim);
+	ofono_dbus_dict_append_dict(&dict, "Retries", DBUS_TYPE_BYTE,
+								&pin_retries);
+	g_free(pin_retries);
+
 done:
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
 }
 =

+static void sim_pin_retries_query_cb(const struct ofono_error *error,
+					int retries[OFONO_SIM_PASSWORD_INVALID],
+					void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	void **pin_retries;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querying remaining pin retries failed");
+
+		return;
+	}
+
+	if (!memcmp(retries, sim->pin_retries, sizeof(retries)))
+		return;
+
+	memcpy(sim->pin_retries, retries, sizeof(sim->pin_retries));
+
+	pin_retries =3D get_pin_retries(sim);
+	ofono_dbus_signal_dict_property_changed(conn, path,
+					OFONO_SIM_MANAGER_INTERFACE, "Retries",
+					DBUS_TYPE_BYTE,	&pin_retries);
+	g_free(pin_retries);
+}
+
+static void sim_pin_retries_check(struct ofono_sim *sim)
+{
+	if (sim->driver->query_pin_retries =3D=3D NULL)
+		return;
+
+	sim->driver->query_pin_retries(sim, sim_pin_retries_query_cb, sim);
+}
+
+
 static void msisdn_set_done(struct msisdn_set_request *req)
 {
 	DBusMessage *reply;
@@ -549,6 +620,8 @@ static void sim_locked_cb(struct ofono_sim *sim, gboole=
an locked)
 						"LockedPins", DBUS_TYPE_STRING,
 						&locked_pins);
 	g_strfreev(locked_pins);
+
+	sim_pin_retries_check(sim);
 }
 =

 static void sim_unlock_cb(const struct ofono_error *error, void *data)
@@ -557,7 +630,10 @@ static void sim_unlock_cb(const struct ofono_error *er=
ror, void *data)
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
+
 		__ofono_dbus_pending_reply(&sim->pending, reply);
+		sim_pin_retries_check(sim);
+
 		return;
 	}
 =

@@ -570,7 +646,10 @@ static void sim_lock_cb(const struct ofono_error *erro=
r, void *data)
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBusMessage *reply =3D __ofono_error_failed(sim->pending);
+
 		__ofono_dbus_pending_reply(&sim->pending, reply);
+		sim_pin_retries_check(sim);
+
 		return;
 	}
 =

@@ -639,11 +718,16 @@ static void sim_change_pin_cb(const struct ofono_erro=
r *error, void *data)
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		__ofono_dbus_pending_reply(&sim->pending,
 				__ofono_error_failed(sim->pending));
+
+		sim_pin_retries_check(sim);
+
 		return;
 	}
 =

 	__ofono_dbus_pending_reply(&sim->pending,
 				dbus_message_new_method_return(sim->pending));
+
+	sim_pin_retries_check(sim);
 }
 =

 static DBusMessage *sim_change_pin(DBusConnection *conn, DBusMessage *msg,
@@ -1594,6 +1678,8 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 						&pin_name);
 	}
 =

+	sim_pin_retries_check(sim);
+
 checkdone:
 	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
 		sim_initialize_after_pin(sim);
@@ -2184,6 +2270,7 @@ struct ofono_sim *ofono_sim_create(struct ofono_modem=
 *modem,
 {
 	struct ofono_sim *sim;
 	GSList *l;
+	int i;
 =

 	if (driver =3D=3D NULL)
 		return NULL;
@@ -2197,6 +2284,9 @@ struct ofono_sim *ofono_sim_create(struct ofono_modem=
 *modem,
 	sim->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_SIM,
 						sim_remove, sim);
 =

+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		sim->pin_retries[i] =3D -1;
+
 	for (l =3D g_drivers; l; l =3D l->next) {
 		const struct ofono_sim_driver *drv =3D l->data;
 =

-- =

1.7.3.5


--===============7668222230259392587==--


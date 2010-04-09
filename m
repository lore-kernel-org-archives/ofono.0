Content-Type: multipart/mixed; boundary="===============8403573275497003058=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8] Add SIM "Present" property.
Date: Fri, 09 Apr 2010 08:49:49 +0200
Message-ID: <1270795789-7244-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8403573275497003058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |  117 ++++++++++++++++++++++++++++++++++++++++-----------------=
----
 1 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 41ddd13..6bd846f 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -271,6 +271,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	char **service_numbers;
 	char **locked_pins;
 	const char *pin_name;
+	dbus_bool_t present =3D sim->state !=3D OFONO_SIM_STATE_NOT_PRESENT;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
@@ -282,6 +283,11 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

+	ofono_dbus_dict_append(&dict, "Present", DBUS_TYPE_BOOLEAN, &present);
+
+	if (!present)
+		goto done;
+
 	if (sim->imsi)
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
@@ -335,6 +341,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 				DBUS_TYPE_STRING,
 				(void *) &pin_name);
 =

+done:
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -1010,6 +1017,8 @@ static void sim_imsi_cb(const struct ofono_error *err=
or, const char *imsi,
 		void *data)
 {
 	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Unable to read IMSI, emergency calls only");
@@ -1018,6 +1027,11 @@ static void sim_imsi_cb(const struct ofono_error *er=
ror, const char *imsi,
 =

 	sim->imsi =3D g_strdup(imsi);
 =

+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_SIM_MANAGER_INTERFACE,
+					"SubscriberIdentity",
+					DBUS_TYPE_STRING, &sim->imsi);
+
 	/* Read CPHS-support bits, this is still part of the SIM
 	 * initialisation but no order is specified for it.  */
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
@@ -1778,6 +1792,62 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
e(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+static void sim_inserted_update(struct ofono_sim *sim)
+{
+	dbus_bool_t present =3D sim->state !=3D OFONO_SIM_STATE_NOT_PRESENT;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+
+	ofono_dbus_signal_property_changed(conn, path,
+			OFONO_SIM_MANAGER_INTERFACE, "Present",
+			DBUS_TYPE_BOOLEAN, &present);
+}
+
+static void sim_free_state(struct ofono_sim *sim)
+{
+	if (sim->simop_source) {
+		g_source_remove(sim->simop_source);
+		sim->simop_source =3D 0;
+	}
+
+	if (sim->simop_q) {
+		/* Note: users of ofono_sim_read/write must not assume that
+		 * the callback happens for operations still in progress.  */
+		g_queue_foreach(sim->simop_q, (GFunc)sim_file_op_free, NULL);
+		g_queue_free(sim->simop_q);
+		sim->simop_q =3D NULL;
+	}
+
+	if (sim->imsi) {
+		g_free(sim->imsi);
+		sim->imsi =3D NULL;
+	}
+
+	if (sim->own_numbers) {
+		g_slist_foreach(sim->own_numbers, (GFunc)g_free, NULL);
+		g_slist_free(sim->own_numbers);
+		sim->own_numbers =3D NULL;
+	}
+
+	if (sim->service_numbers) {
+		g_slist_foreach(sim->service_numbers,
+				(GFunc)service_number_free, NULL);
+		g_slist_free(sim->service_numbers);
+		sim->service_numbers =3D NULL;
+	}
+
+	if (sim->efli) {
+		g_free(sim->efli);
+		sim->efli =3D NULL;
+		sim->efli_length =3D 0;
+	}
+
+	if (sim->language_prefs) {
+		g_strfreev(sim->language_prefs);
+		sim->language_prefs =3D NULL;
+	}
+}
+
 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d)
 {
 	ofono_sim_state_event_notify_cb_t notify;
@@ -1793,6 +1863,8 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim,=
 ofono_bool_t inserted)
 	if (!__ofono_atom_get_registered(sim->atom))
 		return;
 =

+	sim_inserted_update(sim);
+
 	for (l =3D sim->state_watches->items; l; l =3D l->next) {
 		struct ofono_watchlist_item *item =3D l->data;
 		notify =3D item->notify;
@@ -1800,8 +1872,11 @@ void ofono_sim_inserted_notify(struct ofono_sim *sim=
, ofono_bool_t inserted)
 		notify(item->notify_data, sim->state);
 	}
 =

-	if (!inserted)
+	if (!inserted) {
+		sim_free_state(sim);
+
 		return;
+	}
 =

 	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
 	 * The assumption here is that if sim manager is being initialized,
@@ -1927,45 +2002,7 @@ static void sim_remove(struct ofono_atom *atom)
 	if (sim->driver && sim->driver->remove)
 		sim->driver->remove(sim);
 =

-	if (sim->imsi) {
-		g_free(sim->imsi);
-		sim->imsi =3D NULL;
-	}
-
-	if (sim->own_numbers) {
-		g_slist_foreach(sim->own_numbers, (GFunc)g_free, NULL);
-		g_slist_free(sim->own_numbers);
-		sim->own_numbers =3D NULL;
-	}
-
-	if (sim->service_numbers) {
-		g_slist_foreach(sim->service_numbers,
-				(GFunc)service_number_free, NULL);
-		g_slist_free(sim->service_numbers);
-		sim->service_numbers =3D NULL;
-	}
-
-	if (sim->efli) {
-		g_free(sim->efli);
-		sim->efli =3D NULL;
-		sim->efli_length =3D 0;
-	}
-
-	if (sim->language_prefs) {
-		g_strfreev(sim->language_prefs);
-		sim->language_prefs =3D NULL;
-	}
-
-	if (sim->simop_source) {
-		g_source_remove(sim->simop_source);
-		sim->simop_source =3D 0;
-	}
-
-	if (sim->simop_q) {
-		g_queue_foreach(sim->simop_q, (GFunc)sim_file_op_free, NULL);
-		g_queue_free(sim->simop_q);
-		sim->simop_q =3D NULL;
-	}
+	sim_free_state(sim);
 =

 	g_free(sim);
 }
-- =

1.6.1


--===============8403573275497003058==--


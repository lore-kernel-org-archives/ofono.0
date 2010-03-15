Content-Type: multipart/mixed; boundary="===============3535437455613322614=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/8][RFC] Invalidate SIM manager properties when SIM extracted,
 add Present property.
Date: Mon, 15 Mar 2010 22:22:16 +0100
Message-ID: <1268688136-4209-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3535437455613322614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index cddb3e4..fe535bb 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -285,6 +285,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	char **service_numbers;
 	char **locked_pins;
 	const char *pin_name;
+	dbus_bool_t present =3D sim->inserted;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
@@ -296,6 +297,8 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

+	ofono_dbus_dict_append(&dict, "Present", DBUS_TYPE_BOOLEAN, &present);
+
 	if (sim->imsi)
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
@@ -304,16 +307,20 @@ static DBusMessage *sim_get_properties(DBusConnection=
 *conn,
 		ofono_dbus_dict_append(&dict, "MobileNetworkCodeLength",
 					DBUS_TYPE_BYTE, &sim->mnc_length);
 =

-	own_numbers =3D get_own_numbers(sim->own_numbers);
+	if (sim->inserted) {
+		own_numbers =3D get_own_numbers(sim->own_numbers);
 =

-	ofono_dbus_dict_append_array(&dict, "SubscriberNumbers",
-					DBUS_TYPE_STRING, &own_numbers);
-	g_strfreev(own_numbers);
+		ofono_dbus_dict_append_array(&dict, "SubscriberNumbers",
+						DBUS_TYPE_STRING, &own_numbers);
+		g_strfreev(own_numbers);
+	}
 =

-	locked_pins =3D get_locked_pins(sim);
-	ofono_dbus_dict_append_array(&dict, "LockedPins",
-					DBUS_TYPE_STRING, &locked_pins);
-	g_strfreev(locked_pins);
+	if (sim->inserted) {
+		locked_pins =3D get_locked_pins(sim);
+		ofono_dbus_dict_append_array(&dict, "LockedPins",
+						DBUS_TYPE_STRING, &locked_pins);
+		g_strfreev(locked_pins);
+	}
 =

 	if (sim->service_numbers && sim->sdn_ready) {
 		service_numbers =3D get_service_numbers(sim->service_numbers);
@@ -329,10 +336,12 @@ static DBusMessage *sim_get_properties(DBusConnection=
 *conn,
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
 =

-	pin_name =3D sim_passwd_name(sim->pin_type);
-	ofono_dbus_dict_append(&dict, "PinRequired",
-				DBUS_TYPE_STRING,
-				(void *) &pin_name);
+	if (sim->inserted) {
+		pin_name =3D sim_passwd_name(sim->pin_type);
+		ofono_dbus_dict_append(&dict, "PinRequired",
+					DBUS_TYPE_STRING,
+					(void *) &pin_name);
+	}
 =

 	dbus_message_iter_close_container(&iter, &dict);
 =

@@ -992,6 +1001,8 @@ static void sim_imsi_cb(const struct ofono_error *erro=
r, const char *imsi,
 		void *data)
 {
 	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Unable to read IMSI, emergency calls only");
@@ -1000,6 +1011,11 @@ static void sim_imsi_cb(const struct ofono_error *er=
ror, const char *imsi,
 =

 	sim->imsi =3D g_strdup(imsi);
 =

+	ofono_dbus_signal_property_changed(conn, path,
+					SIM_MANAGER_INTERFACE,
+					"SubscriberIdentity",
+					DBUS_TYPE_STRING, &sim->imsi);
+
 	/* Read CPHS-support bits, this is still part of the SIM
 	 * initialisation but no order is specified for it.  */
 	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
@@ -1755,9 +1771,21 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
e(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+static void sim_inserted_update(struct ofono_sim *sim)
+{
+	dbus_bool_t present =3D sim->inserted;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+
+	ofono_dbus_signal_property_changed(conn, path,
+			SIM_MANAGER_INTERFACE, "Present",
+			DBUS_TYPE_BOOLEAN, &present);
+}
+
 void ofono_sim_inserted(struct ofono_sim *sim)
 {
 	sim->inserted =3D TRUE;
+	sim_inserted_update(sim);
 =

 	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
 	 * The assumption here is that if sim manager is being initialized,
@@ -1781,6 +1809,18 @@ void ofono_sim_inserted(struct ofono_sim *sim)
 	sim_determine_phase(sim);
 }
 =

+static void sim_file_op_fail(struct sim_file_op *op)
+{
+	if (op->is_read =3D=3D TRUE)
+		((ofono_sim_file_read_cb_t) op->cb)
+			(0, 0, 0, 0, 0, op->userdata);
+	else
+		((ofono_sim_file_write_cb_t) op->cb)
+			(0, op->userdata);
+
+	sim_file_op_free(op);
+}
+
 void ofono_sim_removed(struct ofono_sim *sim)
 {
 	GSList *l;
@@ -1790,18 +1830,61 @@ void ofono_sim_removed(struct ofono_sim *sim)
 		return;
 =

 	sim->inserted =3D FALSE;
+	sim_inserted_update(sim);
 =

 	if (sim->ready =3D=3D FALSE)
 		return;
 =

 	sim->ready =3D FALSE;
 =

+	if (sim->simop_source) {
+		g_source_remove(sim->simop_source);
+		sim->simop_source =3D 0;
+	}
+
+	if (sim->simop_q) {
+		/* NOTE: there's an assumption here that the op's callback
+		 * does not queue new ops on failure... */
+		g_queue_foreach(sim->simop_q, (GFunc) sim_file_op_fail, NULL);
+		g_queue_free(sim->simop_q);
+		sim->simop_q =3D NULL;
+	}
+
 	for (l =3D sim->removed_watches->items; l; l =3D l->next) {
 		struct ofono_watchlist_item *item =3D l->data;
 		notify =3D item->notify;
 =

 		notify(item->notify_data);
 	}
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
 }
 =

 static void sim_command_fetch_cb(const struct ofono_error *error,
-- =

1.6.1


--===============3535437455613322614==--


Content-Type: multipart/mixed; boundary="===============7827517308235593664=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5][RfC] Invalidate SIM manager properties when SIM extracted,
 add Present property.
Date: Wed, 31 Mar 2010 06:58:19 +0200
Message-ID: <1270011499-6918-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7827517308235593664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c      |  114 +++++++++++++++++++++++++++++++++++++---------------=
----
 test/test-ussd |    2 +-
 2 files changed, 76 insertions(+), 40 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 3d89cb2..83815c4 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -274,6 +274,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	char **service_numbers;
 	char **locked_pins;
 	const char *pin_name;
+	dbus_bool_t present =3D sim->inserted;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
@@ -285,6 +286,11 @@ static DBusMessage *sim_get_properties(DBusConnection =
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
@@ -323,6 +329,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 				DBUS_TYPE_STRING,
 				(void *) &pin_name);
 =

+done:
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -980,6 +987,8 @@ static void sim_imsi_cb(const struct ofono_error *error=
, const char *imsi,
 		void *data)
 {
 	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Unable to read IMSI, emergency calls only");
@@ -988,6 +997,11 @@ static void sim_imsi_cb(const struct ofono_error *erro=
r, const char *imsi,
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
@@ -1748,9 +1762,21 @@ const unsigned char *ofono_sim_get_cphs_service_tabl=
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
+			OFONO_SIM_MANAGER_INTERFACE, "Present",
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
@@ -1774,6 +1800,51 @@ void ofono_sim_inserted(struct ofono_sim *sim)
 	sim_determine_phase(sim);
 }
 =

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
 void ofono_sim_removed(struct ofono_sim *sim)
 {
 	GSList *l;
@@ -1783,6 +1854,7 @@ void ofono_sim_removed(struct ofono_sim *sim)
 		return;
 =

 	sim->inserted =3D FALSE;
+	sim_inserted_update(sim);
 =

 	if (sim->ready =3D=3D FALSE)
 		return;
@@ -1795,6 +1867,8 @@ void ofono_sim_removed(struct ofono_sim *sim)
 =

 		notify(item->notify_data);
 	}
+
+	sim_free_state(sim);
 }
 =

 void ofono_sim_proactive_command_notify(struct ofono_sim *sim,
@@ -1973,45 +2047,7 @@ static void sim_remove(struct ofono_atom *atom)
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

--===============7827517308235593664==--


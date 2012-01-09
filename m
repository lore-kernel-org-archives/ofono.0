Content-Type: multipart/mixed; boundary="===============1333482974216121385=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 3/4] gprs: Use sim SPN watch API
Date: Mon, 09 Jan 2012 12:30:43 +0200
Message-ID: <1326105044-26408-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326105044-26408-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1333482974216121385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  105 ++++++++++++++++++++++++++++++++++++--------------------=
----
 1 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 4e46743..c4ea974 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -94,7 +94,9 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
-	struct ofono_sim_context *sim_context;
+	struct ofono_sim *sim;
+	unsigned int sim_watch;
+	unsigned int spn_watch;
 };
 =

 struct ipv4_settings {
@@ -2502,6 +2504,39 @@ static void free_contexts(struct ofono_gprs *gprs)
 	g_slist_free(gprs->contexts);
 }
 =

+static inline void sim_unregister(struct ofono_gprs *gprs,
+			unsigned int *spn_watch, unsigned int *sim_watch,
+			struct ofono_sim **sim)
+{
+	if (gprs->sim =3D=3D NULL)
+		return;
+
+	if (*spn_watch)
+		ofono_sim_remove_spn_watch(*sim, spn_watch);
+
+	if (*sim_watch) {
+		__ofono_modem_remove_atom_watch(
+				__ofono_atom_get_modem(gprs->atom), *sim_watch);
+		*sim_watch =3D 0;
+	}
+
+	if (*sim)
+		*sim =3D NULL;
+}
+
+static void sim_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_gprs *gprs =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sim_unregister(gprs, &gprs->spn_watch, NULL, &gprs->sim);
+		return;
+	}
+
+	gprs->sim =3D __ofono_atom_get_data(atom);
+}
+
 static void gprs_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2513,6 +2548,9 @@ static void gprs_unregister(struct ofono_atom *atom)
 =

 	free_contexts(gprs);
 =

+	if (gprs->sim && gprs->spn_watch)
+		sim_unregister(gprs, &gprs->spn_watch, NULL, NULL);
+
 	if (gprs->cid_map) {
 		idmap_free(gprs->cid_map);
 		gprs->cid_map =3D NULL;
@@ -2554,6 +2592,10 @@ static void gprs_remove(struct ofono_atom *atom)
 		gprs->pid_map =3D NULL;
 	}
 =

+	if (gprs->sim)
+		sim_unregister(gprs, &gprs->spn_watch, &gprs->sim_watch,
+				&gprs->sim);
+
 	for (l =3D gprs->context_drivers; l; l =3D l->next) {
 		struct ofono_gprs_context *gc =3D l->data;
 =

@@ -2565,9 +2607,6 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs->driver && gprs->driver->remove)
 		gprs->driver->remove(gprs);
 =

-	if (gprs->sim_context)
-		ofono_sim_context_free(gprs->sim_context);
-
 	g_free(gprs);
 }
 =

@@ -2605,6 +2644,9 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mod=
em *modem,
 	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
 =

+	gprs->sim_watch =3D __ofono_modem_add_atom_watch(modem,
+				OFONO_ATOM_TYPE_SIM, sim_watch, gprs, NULL);
+
 	return gprs;
 }
 =

@@ -2955,57 +2997,36 @@ static void ofono_gprs_finish_register(struct ofono=
_gprs *gprs)
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

-static void sim_spn_read_cb(int ok, int length, int record,
-				const unsigned char *data,
-				int record_length, void *userdata)
+static void spn_read_cb(const char *spn, const char *dc, void *data)
 {
-	struct ofono_gprs *gprs	=3D userdata;
-	char *spn =3D NULL;
-	struct ofono_atom *sim_atom;
-	struct ofono_sim *sim =3D NULL;
+	struct ofono_gprs *gprs	=3D data;
+
+	if (gprs->spn_watch =3D=3D 0)
+		return;
 =

-	if (ok)
-		spn =3D sim_string_to_utf8(data + 1, length - 1);
+	ofono_sim_remove_spn_watch(gprs->sim, &gprs->spn_watch);
 =

-	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(gprs->atom),
-						OFONO_ATOM_TYPE_SIM);
-	if (sim_atom) {
-		sim =3D __ofono_atom_get_data(sim_atom);
-		provision_contexts(gprs, ofono_sim_get_mcc(sim),
-					ofono_sim_get_mnc(sim), spn);
-	}
+	if (gprs->sim !=3D NULL && spn !=3D NULL)
+		provision_contexts(gprs, ofono_sim_get_mcc(gprs->sim),
+					ofono_sim_get_mnc(gprs->sim), spn);
 =

-	g_free(spn);
 	ofono_gprs_finish_register(gprs);
 }
 =

 void ofono_gprs_register(struct ofono_gprs *gprs)
 {
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
-	struct ofono_atom *sim_atom;
-	struct ofono_sim *sim =3D NULL;
-
-	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
-
-	if (sim_atom) {
-		const char *imsi;
-		sim =3D __ofono_atom_get_data(sim_atom);
-
-		imsi =3D ofono_sim_get_imsi(sim);
-		gprs_load_settings(gprs, imsi);
-	}
+	if (gprs->sim =3D=3D NULL)
+		ofono_gprs_finish_register(gprs);
 =

-	if (gprs->contexts =3D=3D NULL && sim !=3D NULL) {
-		/* Get Service Provider Name from SIM for provisioning */
-		gprs->sim_context =3D ofono_sim_context_create(sim);
+	gprs_load_settings(gprs, ofono_sim_get_imsi(gprs->sim));
 =

-		if (ofono_sim_read(gprs->sim_context, SIM_EFSPN_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-					sim_spn_read_cb, gprs) >=3D 0)
-			return;
+	if (gprs->contexts) {
+		ofono_gprs_finish_register(gprs);
+		return;
 	}
 =

-	ofono_gprs_finish_register(gprs);
+	ofono_sim_add_spn_watch(gprs->sim, &gprs->spn_watch, spn_read_cb,
+								gprs, NULL);
 }
 =

 void ofono_gprs_remove(struct ofono_gprs *gprs)
-- =

1.7.5.4


--===============1333482974216121385==--


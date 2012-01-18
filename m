Content-Type: multipart/mixed; boundary="===============2592326470789113753=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 1/4] gprs: Use sim SPN watch API
Date: Wed, 18 Jan 2012 13:56:26 +0200
Message-ID: <1326887789-16478-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326887789-16478-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2592326470789113753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   71 ++++++++++++++++++++++++++------------------------------=
---
 1 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 4e46743..bf7c66f 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -94,7 +94,7 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
-	struct ofono_sim_context *sim_context;
+	unsigned int spn_watch;
 };
 =

 struct ipv4_settings {
@@ -2502,6 +2502,17 @@ static void free_contexts(struct ofono_gprs *gprs)
 	g_slist_free(gprs->contexts);
 }
 =

+static inline struct ofono_sim *ofono_gprs_get_sim(struct ofono_gprs *gprs)
+{
+	struct ofono_atom *atom =3D __ofono_modem_find_atom(
+					__ofono_atom_get_modem(gprs->atom),
+					OFONO_ATOM_TYPE_SIM);
+	if (atom)
+		return __ofono_atom_get_data(atom);
+
+	return NULL;
+}
+
 static void gprs_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2530,6 +2541,10 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->netreg =3D NULL;
 	}
 =

+	if (gprs->spn_watch)
+		ofono_sim_remove_spn_watch(ofono_gprs_get_sim(gprs),
+							&gprs->spn_watch);
+
 	ofono_modem_remove_interface(modem,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
@@ -2565,9 +2580,6 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs->driver && gprs->driver->remove)
 		gprs->driver->remove(gprs);
 =

-	if (gprs->sim_context)
-		ofono_sim_context_free(gprs->sim_context);
-
 	g_free(gprs);
 }
 =

@@ -2955,57 +2967,36 @@ static void ofono_gprs_finish_register(struct ofono=
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
+	struct ofono_sim *sim =3D ofono_gprs_get_sim(gprs);
 =

-	if (ok)
-		spn =3D sim_string_to_utf8(data + 1, length - 1);
-
-	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(gprs->atom),
-						OFONO_ATOM_TYPE_SIM);
-	if (sim_atom) {
-		sim =3D __ofono_atom_get_data(sim_atom);
-		provision_contexts(gprs, ofono_sim_get_mcc(sim),
+	provision_contexts(gprs, ofono_sim_get_mcc(sim),
 					ofono_sim_get_mnc(sim), spn);
-	}
 =

-	g_free(spn);
+	ofono_sim_remove_spn_watch(sim, &gprs->spn_watch);
+
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
+	struct ofono_sim *sim =3D ofono_gprs_get_sim(gprs);
 =

-		imsi =3D ofono_sim_get_imsi(sim);
-		gprs_load_settings(gprs, imsi);
+	if (sim =3D=3D NULL) {
+		ofono_gprs_finish_register(gprs);
+		return;
 	}
 =

-	if (gprs->contexts =3D=3D NULL && sim !=3D NULL) {
-		/* Get Service Provider Name from SIM for provisioning */
-		gprs->sim_context =3D ofono_sim_context_create(sim);
+	gprs_load_settings(gprs, ofono_sim_get_imsi(sim));
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
+	ofono_sim_add_spn_watch(sim, &gprs->spn_watch, spn_read_cb, gprs, NULL);
 }
 =

 void ofono_gprs_remove(struct ofono_gprs *gprs)
-- =

1.7.5.4


--===============2592326470789113753==--


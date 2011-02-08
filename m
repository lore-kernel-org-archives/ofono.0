Content-Type: multipart/mixed; boundary="===============5625618561578267015=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 2/3] gprs,gprs-provision: add SPN to provisioning API
Date: Tue, 08 Feb 2011 12:03:47 +0200
Message-ID: <1297159428-2409-3-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1297159428-2409-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5625618561578267015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs-provision.c |    4 +-
 src/gprs.c           |   87 +++++++++++++++++++++++++++++++++++++---------=
---
 src/ofono.h          |    2 +-
 3 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/src/gprs-provision.c b/src/gprs-provision.c
index 3cd84e8..011d5a8 100644
--- a/src/gprs-provision.c
+++ b/src/gprs-provision.c
@@ -48,7 +48,7 @@ void  __ofono_gprs_provision_free_settings(
 }
 =

 ofono_bool_t __ofono_gprs_provision_get_settings(const char *mcc,
-				const char *mnc,
+				const char *mnc, const char *spn,
 				struct ofono_gprs_provision_data **settings,
 				int *count)
 {
@@ -65,7 +65,7 @@ ofono_bool_t __ofono_gprs_provision_get_settings(const ch=
ar *mcc,
 =

 		DBG("Calling provisioning plugin '%s'", driver->name);
 =

-		if (driver->get_settings(mcc, mnc, settings, count) < 0)
+		if (driver->get_settings(mcc, mnc, spn, settings, count) < 0)
 			continue;
 =

 		return TRUE;
diff --git a/src/gprs.c b/src/gprs.c
index 5ea864c..bb1b173 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -97,6 +97,7 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct ofono_sim_context *sim_context;
 };
 =

 struct ofono_gprs_context {
@@ -2291,6 +2292,9 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs->driver && gprs->driver->remove)
 		gprs->driver->remove(gprs);
 =

+	if (gprs->sim_context)
+		ofono_sim_context_free(gprs->sim_context);
+
 	g_free(gprs);
 }
 =

@@ -2627,14 +2631,14 @@ static void provision_context(const struct ofono_gp=
rs_provision_data *ap,
 	gprs->contexts =3D g_slist_append(gprs->contexts, context);
 }
 =

-static void provision_contexts(struct ofono_gprs *gprs, struct ofono_sim *=
sim)
+static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
+				const char *mnc, const char *spn)
 {
 	struct ofono_gprs_provision_data *settings;
 	int count;
 	int i;
 =

-	if (__ofono_gprs_provision_get_settings(ofono_sim_get_mcc(sim),
-						ofono_sim_get_mnc(sim),
+	if (__ofono_gprs_provision_get_settings(mcc, mnc, spn,
 						&settings, &count) =3D=3D FALSE) {
 		ofono_warn("Provisioning failed");
 		return;
@@ -2646,13 +2650,15 @@ static void provision_contexts(struct ofono_gprs *g=
prs, struct ofono_sim *sim)
 	__ofono_gprs_provision_free_settings(settings, count);
 }
 =

-void ofono_gprs_register(struct ofono_gprs *gprs)
+static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
 	struct ofono_atom *netreg_atom;
-	struct ofono_atom *sim_atom;
+
+	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
+		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
@@ -2661,29 +2667,13 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 		ofono_error("Could not create %s interface",
 				OFONO_CONNECTION_MANAGER_INTERFACE);
 =

+		gprs_unregister(gprs->atom);
 		return;
 	}
 =

 	ofono_modem_add_interface(modem,
 				OFONO_CONNECTION_MANAGER_INTERFACE);
 =

-	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
-
-	if (sim_atom) {
-		const char *imsi;
-		struct ofono_sim *sim =3D __ofono_atom_get_data(sim_atom);
-
-		imsi =3D ofono_sim_get_imsi(sim);
-		gprs_load_settings(gprs, imsi);
-
-		if (gprs->contexts =3D=3D NULL)
-			provision_contexts(gprs, sim);
-
-	}
-
-	if (gprs->contexts =3D=3D NULL)
-		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
-
 	gprs->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_NETREG,
 					netreg_watch, gprs, NULL);
@@ -2697,6 +2687,59 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_gprs *gprs	=3D userdata;
+	char *spn =3D NULL;
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	if (ok)
+		spn =3D sim_string_to_utf8(data + 1, length - 1);
+
+	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(gprs->atom),
+						OFONO_ATOM_TYPE_SIM);
+	if (sim_atom) {
+		sim =3D __ofono_atom_get_data(sim_atom);
+		provision_contexts(gprs, ofono_sim_get_mcc(sim),
+					ofono_sim_get_mnc(sim), spn);
+	}
+
+	g_free(spn);
+	ofono_gprs_finish_register(gprs);
+}
+
+void ofono_gprs_register(struct ofono_gprs *gprs)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_atom *sim_atom;
+	struct ofono_sim *sim =3D NULL;
+
+	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (sim_atom) {
+		const char *imsi;
+		sim =3D __ofono_atom_get_data(sim_atom);
+
+		imsi =3D ofono_sim_get_imsi(sim);
+		gprs_load_settings(gprs, imsi);
+	}
+
+	if (gprs->contexts =3D=3D NULL && sim !=3D NULL) {
+		/* Get Service Provider Name from SIM for provisioning */
+		gprs->sim_context =3D ofono_sim_context_create(sim);
+
+		if (ofono_sim_read(gprs->sim_context, SIM_EFSPN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_spn_read_cb, gprs) >=3D 0)
+			return;
+	}
+
+	ofono_gprs_finish_register(gprs);
+}
+
 void ofono_gprs_remove(struct ofono_gprs *gprs)
 {
 	__ofono_atom_free(gprs->atom);
diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..0cdebf7 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -424,7 +424,7 @@ void __ofono_nettime_info_received(struct ofono_modem *=
modem,
 =

 #include <ofono/gprs-provision.h>
 ofono_bool_t __ofono_gprs_provision_get_settings(const char *mcc,
-				const char *mnc,
+				const char *mnc, const char *spn,
 				struct ofono_gprs_provision_data **settings,
 				int *count);
 void __ofono_gprs_provision_free_settings(
-- =

1.7.1


--===============5625618561578267015==--


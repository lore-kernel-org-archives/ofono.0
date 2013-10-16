Content-Type: multipart/mixed; boundary="===============9022406503832916132=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Wed, 16 Oct 2013 12:55:23 +0200
Message-ID: <1381920923-16439-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9022406503832916132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some cases the field MNC length in EFad is not present. MNC can
have either 2 or 3 digits depending on the MCC: we will try with
those 2 lengths when searching in the database for this corner case
(this situation can happen for SIMs (non-USIM), as MNC lenght field
is not mandatory for them - see 3gpp TS 51.011)
---
 include/sim.h |  1 +
 src/gprs.c    | 26 +++++++++++++++++++++----
 src/sim.c     | 61 ++++++++++++++++++++++++++++++++++++++++---------------=
----
 3 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index ed850f9..f63324a 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -191,6 +191,7 @@ void *ofono_sim_get_data(struct ofono_sim *sim);
 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
 const char *ofono_sim_get_mcc(struct ofono_sim *sim);
 const char *ofono_sim_get_mnc(struct ofono_sim *sim);
+unsigned ofono_sim_get_mnc_length(struct ofono_sim *sim);
 const char *ofono_sim_get_spn(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

diff --git a/src/gprs.c b/src/gprs.c
index e379f7b..0218696 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2967,7 +2967,7 @@ static void provision_context(const struct ofono_gprs=
_provision_data *ap,
 	gprs->contexts =3D g_slist_append(gprs->contexts, context);
 }
 =

-static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
+static int provision_contexts(struct ofono_gprs *gprs, const char *mcc,
 				const char *mnc, const char *spn)
 {
 	struct ofono_gprs_provision_data *settings;
@@ -2977,13 +2977,15 @@ static void provision_contexts(struct ofono_gprs *g=
prs, const char *mcc,
 	if (__ofono_gprs_provision_get_settings(mcc, mnc, spn,
 						&settings, &count) =3D=3D FALSE) {
 		ofono_warn("Provisioning failed");
-		return;
+		return -EINVAL;
 	}
 =

 	for (i =3D 0; i < count; i++)
 		provision_context(&settings[i], gprs);
 =

 	__ofono_gprs_provision_free_settings(settings, count);
+
+	return 0;
 }
 =

 static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
@@ -3021,9 +3023,25 @@ static void spn_read_cb(const char *spn, const char =
*dc, void *data)
 	struct ofono_gprs *gprs	=3D data;
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	const char *mnc =3D ofono_sim_get_mnc(sim);
+	const char *mcc =3D ofono_sim_get_mcc(sim);
+
+	if (ofono_sim_get_mnc_length(sim) =3D=3D 0 && mnc !=3D NULL) {
+		/* MNC length not found in EFad: we try with length 3 and 2 */
+		char aux_mnc[OFONO_MAX_MNC_LENGTH + 1];
 =

-	provision_contexts(gprs, ofono_sim_get_mcc(sim),
-					ofono_sim_get_mnc(sim), spn);
+		strncpy(aux_mnc, mnc, OFONO_MAX_MNC_LENGTH);
+		aux_mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
+
+		if (provision_contexts(gprs, mcc, aux_mnc, spn) !=3D 0) {
+			ofono_info("MNC length is not 3: trying length 2");
+			aux_mnc[OFONO_MAX_MNC_LENGTH - 1] =3D '\0';
+			provision_contexts(gprs, mcc, aux_mnc, spn);
+		}
+
+	} else {
+		provision_contexts(gprs, mcc, mnc, spn);
+	}
 =

 	ofono_sim_remove_spn_watch(sim, &gprs->spn_watch);
 =

diff --git a/src/sim.c b/src/sim.c
index edae5eb..3d31386 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1427,6 +1427,8 @@ static void sim_imsi_obtained(struct ofono_sim *sim, =
const char *imsi)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sim->atom);
+	unsigned char aux_mnc_length;
+	const char *str;
 =

 	sim->imsi =3D g_strdup(imsi);
 =

@@ -1435,27 +1437,36 @@ static void sim_imsi_obtained(struct ofono_sim *sim=
, const char *imsi)
 						"SubscriberIdentity",
 						DBUS_TYPE_STRING, &sim->imsi);
 =

-	if (sim->mnc_length) {
-		const char *str;
+	/*
+	 * sim->mnc_length =3D 0 means that EFad did not contain the MNC length
+	 * field. So we will copy 3 digits from the IMSI in the MNC. MNC can
+	 * have either 2 or 3 digits depending on the MCC: we will try with
+	 * those 2 lengths when searching in the database for this corner case
+	 * (this situation can happen for SIMs (non-USIM), as MNC lenght field
+	 * is not mandatory for them - see TS 51.011)
+	 */
+	if (sim->mnc_length)
+		aux_mnc_length =3D sim->mnc_length;
+	else
+		aux_mnc_length =3D OFONO_MAX_MNC_LENGTH;
 =

-		strncpy(sim->mcc, sim->imsi, OFONO_MAX_MCC_LENGTH);
-		sim->mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
-		strncpy(sim->mnc, sim->imsi + OFONO_MAX_MCC_LENGTH,
-			sim->mnc_length);
-		sim->mnc[sim->mnc_length] =3D '\0';
+	strncpy(sim->mcc, sim->imsi, OFONO_MAX_MCC_LENGTH);
+	sim->mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+	strncpy(sim->mnc, sim->imsi + OFONO_MAX_MCC_LENGTH,
+		aux_mnc_length);
+	sim->mnc[aux_mnc_length] =3D '\0';
 =

-		str =3D sim->mcc;
-		ofono_dbus_signal_property_changed(conn, path,
-						OFONO_SIM_MANAGER_INTERFACE,
-						"MobileCountryCode",
-						DBUS_TYPE_STRING, &str);
+	str =3D sim->mcc;
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_SIM_MANAGER_INTERFACE,
+					"MobileCountryCode",
+					DBUS_TYPE_STRING, &str);
 =

-		str =3D sim->mnc;
-		ofono_dbus_signal_property_changed(conn, path,
-						OFONO_SIM_MANAGER_INTERFACE,
-						"MobileNetworkCode",
-						DBUS_TYPE_STRING, &str);
-	}
+	str =3D sim->mnc;
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_SIM_MANAGER_INTERFACE,
+					"MobileNetworkCode",
+					DBUS_TYPE_STRING, &str);
 =

 	sim_set_ready(sim);
 =

@@ -1772,8 +1783,12 @@ static void sim_ad_read_cb(int ok, int length, int r=
ecord,
 	if (!ok)
 		return;
 =

+	if (length < 3) {
+		ofono_error("EFad should contain at least three bytes");
+		return;
+	}
 	if (length < 4) {
-		ofono_error("EFad should contain@least four bytes");
+		ofono_info("EFad does not contain MNC length");
 		return;
 	}
 =

@@ -2234,6 +2249,14 @@ const char *ofono_sim_get_mnc(struct ofono_sim *sim)
 	return sim->mnc;
 }
 =

+unsigned ofono_sim_get_mnc_length(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return 0;
+
+	return sim->mnc_length;
+}
+
 const char *ofono_sim_get_spn(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-- =

1.8.1.2


--===============9022406503832916132==--


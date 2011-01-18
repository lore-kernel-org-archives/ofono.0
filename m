Content-Type: multipart/mixed; boundary="===============1036309616872928788=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 7/8] sim: getters for mcc and mnc implementation
Date: Tue, 18 Jan 2011 10:09:31 +0200
Message-ID: <1295338172-12773-8-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295338172-12773-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1036309616872928788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d627647..86c3f13 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -78,6 +78,8 @@ struct ofono_sim {
 	gboolean barred_dialing;
 =

 	char *imsi;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
 =

 	GSList *own_numbers;
 	GSList *new_numbers;
@@ -348,21 +350,13 @@ static DBusMessage *sim_get_properties(DBusConnection=
 *conn,
 	bdn =3D sim->barred_dialing;
 	ofono_dbus_dict_append(&dict, "BarredDialing", DBUS_TYPE_BOOLEAN, &bdn);
 =

-	if (sim->mnc_length && sim->imsi) {
-		char mcc[OFONO_MAX_MCC_LENGTH + 1];
-		char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	if (sim->mcc[0] !=3D '\0' && sim->mnc[0] !=3D '\0') {
 		const char *str;
-
-		strncpy(mcc, sim->imsi, OFONO_MAX_MCC_LENGTH);
-		mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
-		strncpy(mnc, sim->imsi + OFONO_MAX_MCC_LENGTH, sim->mnc_length);
-		mnc[sim->mnc_length] =3D '\0';
-
-		str =3D mcc;
+		str =3D sim->mcc;
 		ofono_dbus_dict_append(&dict, "MobileCountryCode",
 					DBUS_TYPE_STRING, &str);
 =

-		str =3D mnc;
+		str =3D sim->mnc;
 		ofono_dbus_dict_append(&dict, "MobileNetworkCode",
 					DBUS_TYPE_STRING, &str);
 	}
@@ -1299,22 +1293,21 @@ static void sim_imsi_cb(const struct ofono_error *e=
rror, const char *imsi,
 						DBUS_TYPE_STRING, &sim->imsi);
 =

 	if (sim->mnc_length) {
-		char mcc[OFONO_MAX_MCC_LENGTH + 1];
-		char mnc[OFONO_MAX_MNC_LENGTH + 1];
 		const char *str;
 =

-		strncpy(mcc, sim->imsi, OFONO_MAX_MCC_LENGTH);
-		mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
-		strncpy(mnc, sim->imsi + OFONO_MAX_MCC_LENGTH, sim->mnc_length);
-		mnc[sim->mnc_length] =3D '\0';
+		strncpy(sim->mcc, sim->imsi, OFONO_MAX_MCC_LENGTH);
+		sim->mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+		strncpy(sim->mnc, sim->imsi + OFONO_MAX_MCC_LENGTH,
+			sim->mnc_length);
+		sim->mnc[sim->mnc_length] =3D '\0';
 =

-		str =3D mcc;
+		str =3D sim->mcc;
 		ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"MobileCountryCode",
 						DBUS_TYPE_STRING, &str);
 =

-		str =3D mnc;
+		str =3D sim->mnc;
 		ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"MobileNetworkCode",
@@ -1997,6 +1990,22 @@ const char *ofono_sim_get_imsi(struct ofono_sim *sim)
 	return sim->imsi;
 }
 =

+const char *ofono_sim_get_mcc(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	return sim->mcc;
+}
+
+const char *ofono_sim_get_mnc(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return NULL;
+
+	return sim->mnc;
+}
+
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
@@ -2060,6 +2069,9 @@ static void sim_free_state(struct ofono_sim *sim)
 		sim->imsi =3D NULL;
 	}
 =

+	sim->mcc[0] =3D '\0';
+	sim->mnc[0] =3D '\0';
+
 	if (sim->own_numbers) {
 		g_slist_foreach(sim->own_numbers, (GFunc)g_free, NULL);
 		g_slist_free(sim->own_numbers);
-- =

1.7.1


--===============1036309616872928788==--


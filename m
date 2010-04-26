Content-Type: multipart/mixed; boundary="===============2469804271318431333=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v0] Read EF_ICCID property of SIM
Date: Mon, 26 Apr 2010 17:38:24 +0200
Message-ID: <20100426153824.GA19346@aao-dell>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2469804271318431333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Read out Intergrated Cicruit Card Identifier from SIM.
---
 v0: initial version

 doc/sim-api.txt |    5 +++++
 include/types.h |    2 ++
 src/sim.c       |   29 +++++++++++++++++++++++++++++
 src/simutil.h   |    1 +
 4 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index fd02396..d608205 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -115,3 +115,8 @@ Properties	string SubscriberIdentity [readonly, optiona=
l]
 =

 			The list contains elements of the same format as the
 			PinRequired property.
+
+		string IntegratedCircuitCardIdentifier [readonly]
+
+			Contains the Intergrated Circuit Card Identifer (ICCID)
+			and is read directly from the SIM.
diff --git a/include/types.h b/include/types.h
index 7b08b8c..7b903bb 100644
--- a/include/types.h
+++ b/include/types.h
@@ -36,6 +36,8 @@ extern "C" {
 =

 typedef int		ofono_bool_t;
 =

+#define OFONO_MAX_ICCID_LENGTH 20
+
 /* MCC is always three digits. MNC is either two or three digits */
 #define OFONO_MAX_MCC_LENGTH 3
 #define OFONO_MAX_MNC_LENGTH 3
diff --git a/src/sim.c b/src/sim.c
index bf28f1e..1ce5751 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -70,6 +70,7 @@ struct sim_file_op {
 };
 =

 struct ofono_sim {
+	char *iccid;
 	char *imsi;
 	enum ofono_sim_phase phase;
 	unsigned char mnc_length;
@@ -288,6 +289,10 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 	if (!present)
 		goto done;
 =

+	if (sim->iccid)
+		ofono_dbus_dict_append(&dict, "IntegratedCircuitCardIdentifier",
+					DBUS_TYPE_STRING, &sim->iccid);
+		=

 	if (sim->imsi)
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
@@ -1292,6 +1297,22 @@ static void sim_retrieve_efli_and_efpl(struct ofono_=
sim *sim)
 			sim_efpl_read_cb, sim);
 }
 =

+static void sim_iccid_read_cb(const struct ofono_error *error,
+				const unsigned char *data, int len, void *user)
+{
+	struct ofono_sim *sim =3D user;
+	char number[OFONO_MAX_ICCID_LENGTH+ 1];
+
+	if (!error || error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || len !=3D 10)
+		return;
+
+	extract_bcd_number(data, len, number);
+	number[OFONO_MAX_ICCID_LENGTH] =3D '\0';
+	sim->iccid =3D g_strdup(number);
+
+	DBG("ICCID %s", sim->iccid);
+}
+
 static void sim_efphase_read_cb(const struct ofono_error *error,
 				const unsigned char *data, int len, void *user)
 {
@@ -1320,6 +1341,9 @@ static void sim_determine_phase(struct ofono_sim *sim)
 =

 static void sim_initialize(struct ofono_sim *sim)
 {
+	sim->driver->read_file_transparent(sim, SIM_EF_ICCID_FILEID, 0, 10,
+					   sim_iccid_read_cb, sim);
+
 	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
 	 * The assumption here is that if sim manager is being initialized,
 	 * then sim commands are implemented, and the sim manager is then
@@ -1843,6 +1867,11 @@ static void sim_free_state(struct ofono_sim *sim)
 		sim->simop_q =3D NULL;
 	}
 =

+	if (sim->iccid) {
+		g_free(sim->iccid);
+		sim->iccid =3D NULL;
+	}
+
 	if (sim->imsi) {
 		g_free(sim->imsi);
 		sim->imsi =3D NULL;
diff --git a/src/simutil.h b/src/simutil.h
index 7590cca..d6c52fc 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -21,6 +21,7 @@
 =

 enum sim_fileid {
 	SIM_EFPL_FILEID =3D 0x2f05,
+	SIM_EF_ICCID_FILEID =3D 0x2fe2,
 	SIM_EFLI_FILEID =3D 0x6f05,
 	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
-- =

1.6.6.1


--===============2469804271318431333==--


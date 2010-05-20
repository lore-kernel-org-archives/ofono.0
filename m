Content-Type: multipart/mixed; boundary="===============3633636537466239459=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v1] Read EF_ICCID property of SIM
Date: Thu, 20 May 2010 12:01:48 +0200
Message-ID: <20100520100148.GA18006@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3633636537466239459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tested with phonesim.

---
v0: initial patch
v1: use ofono_read_sim

 doc/sim-api.txt |    5 +++++
 include/types.h |    2 ++
 src/sim.c       |   37 +++++++++++++++++++++++++++++++++++++
 src/simutil.h   |    1 +
 4 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index fd02396..74da31f 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -115,3 +115,8 @@ Properties	string SubscriberIdentity [readonly, optiona=
l]
 =

 			The list contains elements of the same format as the
 			PinRequired property.
+
+		string CardIdentifier [readonly]
+
+			Contains the Intergrated Circuit Card Identifer (ICCID)
+			and is read directly from the SIM.
diff --git a/include/types.h b/include/types.h
index 2b154f0..adaf319 100644
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
index bf28f1e..f37ffb3 100644
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
+		ofono_dbus_dict_append(&dict, "CardIdentifier",
+					DBUS_TYPE_STRING, &sim->iccid);
+
 	if (sim->imsi)
 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
 					DBUS_TYPE_STRING, &sim->imsi);
@@ -1292,6 +1297,29 @@ static void sim_retrieve_efli_and_efpl(struct ofono_=
sim *sim)
 			sim_efpl_read_cb, sim);
 }
 =

+static void sim_iccid_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	char iccid[OFONO_MAX_ICCID_LENGTH + 1];
+
+	if (!ok || length < 10)
+		return;
+
+	extract_bcd_number(data, length, iccid);
+	iccid[OFONO_MAX_ICCID_LENGTH] =3D '\0';
+	sim->iccid =3D g_strdup(iccid);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"CardIdentifier",
+						DBUS_TYPE_STRING,
+						&sim->iccid);
+}
+
 static void sim_efphase_read_cb(const struct ofono_error *error,
 				const unsigned char *data, int len, void *user)
 {
@@ -1320,6 +1348,10 @@ static void sim_determine_phase(struct ofono_sim *si=
m)
 =

 static void sim_initialize(struct ofono_sim *sim)
 {
+	ofono_sim_read(sim, SIM_EF_ICCID_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_iccid_read_cb, sim);
+
 	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
 	 * The assumption here is that if sim manager is being initialized,
 	 * then sim commands are implemented, and the sim manager is then
@@ -1843,6 +1875,11 @@ static void sim_free_state(struct ofono_sim *sim)
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
index 45b6847..144bf12 100644
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


--===============3633636537466239459==--


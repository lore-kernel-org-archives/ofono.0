Content-Type: multipart/mixed; boundary="===============8993553360450115348=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] Retrieve CPHS phase (if any) from SIM.
Date: Thu, 07 Jan 2010 12:38:47 +0100
Message-ID: <1262864327-32096-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8993553360450115348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    9 +++++++++
 src/sim.c     |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/simutil.h |    1 +
 3 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index bc846f3..7a61269 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -63,6 +63,12 @@ enum ofono_sim_phase {
 	OFONO_SIM_PHASE_UNKNOWN,
 };
 =

+enum ofono_sim_cphs_phase {
+	OFONO_SIM_CPHS_NONE,
+	OFONO_SIM_CPHS_PHASE1,
+	OFONO_SIM_CPHS_PHASE2,
+};
+
 typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
 					int filelength,
 					enum ofono_sim_file_structure structure,
@@ -162,6 +168,9 @@ void *ofono_sim_get_data(struct ofono_sim *sim);
 const char *ofono_sim_get_imsi(struct ofono_sim *sim);
 enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
 =

+enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
+unsigned short ofono_sim_get_cphs_support(struct ofono_sim *sim);
+
 unsigned int ofono_sim_add_ready_watch(struct ofono_sim *sim,
 				ofono_sim_ready_notify_cb_t cb,
 				void *data, ofono_destroy_func destroy);
diff --git a/src/sim.c b/src/sim.c
index 3f28086..3fcebec 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -88,6 +88,8 @@ struct ofono_sim {
 	unsigned char efmsisdn_records;
 	unsigned char *efli;
 	unsigned char efli_length;
+	enum ofono_sim_cphs_phase cphs_phase;
+	unsigned short cphs_support;
 	struct ofono_watchlist *ready_watches;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
@@ -951,6 +953,29 @@ static void sim_ready(void *user)
 			sim_sdn_read_cb, sim);
 }
 =

+static void sim_cphs_information_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	sim->cphs_phase =3D OFONO_SIM_CPHS_NONE;
+	sim->cphs_support =3D 0;
+
+	if (!ok || length < 3)
+		goto ready;
+
+	if (data[0] =3D=3D 0x01)
+		sim->cphs_phase =3D OFONO_SIM_CPHS_PHASE1;
+	else if (data[0] >=3D 0x02)
+		sim->cphs_phase =3D OFONO_SIM_CPHS_PHASE2;
+
+	sim->cphs_support =3D (data[2] << 8) | data[1];
+
+ready:
+	ofono_sim_set_ready(sim);
+}
+
 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
 		void *data)
 {
@@ -963,7 +988,11 @@ static void sim_imsi_cb(const struct ofono_error *erro=
r, const char *imsi,
 =

 	sim->imsi =3D g_strdup(imsi);
 =

-	ofono_sim_set_ready(sim);
+	/* Read CPHS-support bits, this is still part of the SIM
+	 * initialisation but no order is specified for it.  */
+	ofono_sim_read(sim, SIM_EF_CPHS_INFORMATION_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_cphs_information_read_cb, sim);
 }
 =

 static void sim_retrieve_imsi(struct ofono_sim *sim)
@@ -1700,6 +1729,22 @@ enum ofono_sim_phase ofono_sim_get_phase(struct ofon=
o_sim *sim)
 	return sim->phase;
 }
 =

+enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return OFONO_SIM_CPHS_NONE;
+
+	return sim->cphs_phase;
+}
+
+unsigned short ofono_sim_get_cphs_support(struct ofono_sim *sim)
+{
+	if (sim =3D=3D NULL)
+		return 0;
+
+	return sim->cphs_support;
+}
+
 unsigned int ofono_sim_add_ready_watch(struct ofono_sim *sim,
 				ofono_sim_ready_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
diff --git a/src/simutil.h b/src/simutil.h
index f90c792..66e684a 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -22,6 +22,7 @@
 enum sim_fileid {
 	SIM_EFPL_FILEID =3D 0x2f05,
 	SIM_EFLI_FILEID =3D 0x6f05,
+	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFSDN_FILEID =3D 0x6f49,
-- =

1.6.1


--===============8993553360450115348==--


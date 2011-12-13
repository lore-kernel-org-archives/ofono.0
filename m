Content-Type: multipart/mixed; boundary="===============6025332102582533597=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 2/3] network: Add CPHS SPN, short-SPN fallbacks
Date: Tue, 13 Dec 2011 13:36:23 +0200
Message-ID: <1323776184-27086-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1323776184-27086-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6025332102582533597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |  178 +++++++++++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 148 insertions(+), 30 deletions(-)

diff --git a/src/network.c b/src/network.c
index cc708a2..5b2dc9a 100644
--- a/src/network.c
+++ b/src/network.c
@@ -57,6 +57,12 @@ enum operator_status {
 	OPERATOR_STATUS_FORBIDDEN =3D	3,
 };
 =

+enum spn_flags {
+	SPN_3GPP =3D		0x1,
+	SPN_CPHS =3D		0x2,
+	SPN_CPHS_SHORT =3D	0x4,
+};
+
 struct ofono_netreg {
 	int status;
 	int location;
@@ -70,7 +76,6 @@ struct ofono_netreg {
 	int flags;
 	DBusMessage *pending;
 	int signal_strength;
-	char *spn;
 	struct sim_spdi *spdi;
 	struct sim_eons *eons;
 	struct ofono_sim *sim;
@@ -82,6 +87,8 @@ struct ofono_netreg {
 	void *driver_data;
 	struct ofono_atom *atom;
 	unsigned int hfp_watch;
+	char *spn;
+	guint8 spn_flags;
 };
 =

 struct network_operator_data {
@@ -1679,27 +1686,150 @@ static gboolean sim_spn_parse(const void *data, in=
t length, char **dst)
 	return TRUE;
 }
 =

+static inline gboolean sim_cphs_spn_enabled(struct ofono_sim *sim)
+{
+	const guint8 *st;
+
+	if (ofono_sim_get_cphs_phase(sim) !=3D OFONO_SIM_CPHS_PHASE_2G)
+		return FALSE;
+
+	st =3D ofono_sim_get_cphs_service_table(sim);
+
+	/*
+	 * CPHS short SPN bits are located in byte 1, bits 7 and 8
+	 */
+	return (st && (st[0] >> 6 =3D=3D 3));
+}
+
+static void ofono_netreg_spn_free(struct ofono_netreg *netreg)
+{
+	gboolean had_spn =3D netreg->spn !=3D NULL && strlen(netreg->spn) > 0;
+
+	g_free(netreg->spn);
+	netreg->spn =3D NULL;
+	netreg->spn_flags =3D 0;
+
+	/*
+	 * We can't determine whether the property really changed
+	 * without checking the name, before and after.  Instead we use a
+	 * simple heuristic, which will not always be correct
+	 */
+	if (had_spn && netreg->current_operator)
+		netreg_emit_operator_display_name(netreg);
+}
+
+static void sim_cphs_spn_short_read_cb(int ok, int length, int record,
+					const unsigned char *data,
+					int record_length, void *user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	if (netreg->spn_flags & (SPN_3GPP | SPN_CPHS) || !ok)
+		return;
+
+	if (!sim_spn_parse(data, length, &netreg->spn))
+		return;
+
+	netreg->spn_flags =3D SPN_CPHS_SHORT;
+
+	if (netreg->current_operator)
+		netreg_emit_operator_display_name(netreg);
+}
+
+static void sim_cphs_spn_read_cb(int ok, int length, int record,
+					const unsigned char *data,
+					int record_length, void *user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	if (netreg->spn_flags & SPN_3GPP)
+		return;
+
+	if (!ok) {
+		if (sim_cphs_spn_enabled(netreg->sim))
+			ofono_sim_read(netreg->sim_context,
+					SIM_EF_CPHS_SPN_SHORT_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_cphs_spn_short_read_cb, netreg);
+
+		return;
+	}
+
+	if (!sim_spn_parse(data, length, &netreg->spn))
+		return;
+
+	netreg->spn_flags =3D SPN_CPHS;
+
+	if (netreg->current_operator)
+		netreg_emit_operator_display_name(netreg);
+}
+
 static void sim_spn_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	unsigned char dcbyte;
 =

-	if (!ok)
-		return;
+	if (!ok) {
+		if (sim_cphs_spn_enabled(netreg->sim))
+			ofono_sim_read(netreg->sim_context,
+					SIM_EF_CPHS_SPN_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_cphs_spn_read_cb, netreg);
 =

-	dcbyte =3D data[0];
+		return;
+	}
 =

 	if (!sim_spn_parse(data + 1, length - 1, &netreg->spn))
 		return;
 =

-	sim_spn_display_condition_parse(netreg, dcbyte);
+	netreg->spn_flags =3D SPN_3GPP;
+
+	sim_spn_display_condition_parse(netreg, data[0]);
 =

 	if (netreg->current_operator)
 		netreg_emit_operator_display_name(netreg);
 }
 =

+static void sim_cphs_spn_short_changed(int id, void *userdata)
+{
+	struct ofono_netreg *netreg =3D userdata;
+
+	if (netreg->spn_flags & (SPN_3GPP | SPN_CPHS))
+		return;
+
+	ofono_netreg_spn_free(netreg);
+
+	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_cphs_spn_short_read_cb, netreg);
+}
+
+static void sim_cphs_spn_changed(int id, void *userdata)
+{
+	struct ofono_netreg *netreg =3D userdata;
+
+	if (netreg->spn_flags & SPN_3GPP)
+		return;
+
+	ofono_netreg_spn_free(netreg);
+
+	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_cphs_spn_read_cb, netreg);
+}
+
+static void sim_spn_changed(int id, void *userdata)
+{
+	struct ofono_netreg *netreg =3D userdata;
+
+	ofono_netreg_spn_free(netreg);
+
+	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_spn_read_cb, netreg);
+}
+
 int ofono_netreg_get_location(struct ofono_netreg *netreg)
 {
 	if (netreg =3D=3D NULL)
@@ -1989,30 +2119,6 @@ static void sim_pnn_opl_changed(int id, void *userda=
ta)
 			sim_pnn_read_cb, netreg);
 }
 =

-static void sim_spn_changed(int id, void *userdata)
-{
-	struct ofono_netreg *netreg =3D userdata;
-	gboolean had_spn =3D netreg->spn !=3D NULL && strlen(netreg->spn) > 0;
-
-	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
-			NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
-
-	g_free(netreg->spn);
-	netreg->spn =3D NULL;
-
-	/*
-	 * We can't determine whether the property really changed
-	 * without checking the name, before and after.  Instead we use a
-	 * simple heuristic, which will not always be correct
-	 */
-	if (netreg->current_operator && had_spn)
-		netreg_emit_operator_display_name(netreg);
-
-	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
-			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-			sim_spn_read_cb, netreg);
-}
-
 static void sim_spdi_changed(int id, void *userdata)
 {
 	struct ofono_netreg *netreg =3D userdata;
@@ -2143,6 +2249,18 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 						sim_spn_changed, netreg,
 						NULL);
 =

+		if (sim_cphs_spn_enabled(netreg->sim)) {
+			ofono_sim_add_file_watch(netreg->sim_context,
+						SIM_EF_CPHS_SPN_SHORT_FILEID,
+						sim_cphs_spn_short_changed,
+						netreg, NULL);
+
+			ofono_sim_add_file_watch(netreg->sim_context,
+						SIM_EF_CPHS_SPN_FILEID,
+						sim_cphs_spn_changed, netreg,
+						NULL);
+		}
+
 		if (__ofono_sim_service_available(netreg->sim,
 				SIM_UST_SERVICE_PROVIDER_DISPLAY_INFO,
 				SIM_SST_SERVICE_PROVIDER_DISPLAY_INFO)) {
-- =

1.7.5.4


--===============6025332102582533597==--


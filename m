Content-Type: multipart/mixed; boundary="===============3757263138517639504=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 4/4] network: Use sim SPN watch API
Date: Mon, 09 Jan 2012 12:30:44 +0200
Message-ID: <1326105044-26408-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326105044-26408-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3757263138517639504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |  163 +++++++----------------------------------------------=
---
 1 files changed, 21 insertions(+), 142 deletions(-)

diff --git a/src/network.c b/src/network.c
index 92256a8..0b30c13 100644
--- a/src/network.c
+++ b/src/network.c
@@ -43,7 +43,6 @@
 #define NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN	0x1
 #define NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN	0x2
 #define NETWORK_REGISTRATION_FLAG_READING_PNN		0x4
-#define NETWORK_REGISTRATION_FLAG_READING_SPN		0x8
 =

 enum network_registration_mode {
 	NETWORK_REGISTRATION_MODE_AUTO =3D	0,
@@ -84,6 +83,7 @@ struct ofono_netreg {
 	struct ofono_atom *atom;
 	unsigned int hfp_watch;
 	char *spn;
+	unsigned int spn_watch;
 };
 =

 struct network_operator_data {
@@ -1648,127 +1648,15 @@ static void sim_spn_display_condition_parse(struct=
 ofono_netreg *netreg,
 		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN;
 }
 =

-static gboolean sim_spn_parse(const void *data, int length, char **dst)
+static void spn_read_cb(const char *spn, const char *dc, void *data)
 {
-	char *spn;
-
-	/*
-	 * TS 31.102 says:
-	 *
-	 * the string shall use:
-	 *
-	 * - either the SMS default 7-bit coded alphabet as defined in
-	 *   TS 23.038 [5] with bit 8 set to 0. The string shall be left
-	 *   justified. Unused bytes shall be set to 'FF'.
-	 *
-	 * - or one of the UCS2 code options defined in the annex of TS
-	 *   31.101 [11].
-	 *
-	 * 31.101 has no such annex though.  51.101 refers to Annex B of
-	 * itself which is not there either.  11.11 contains the same
-	 * paragraph as 51.101 and has an Annex B which we implement.
-	 */
-	spn =3D sim_string_to_utf8(data, length);
-	if (spn =3D=3D NULL) {
-		ofono_error("EFspn read successfully, but couldn't parse");
-		return FALSE;
-	}
-
-	if (strlen(spn) =3D=3D 0) {
-		g_free(spn);
-		return FALSE;
-	}
-
-	*dst =3D spn;
-	return TRUE;
-}
-
-static void sim_cphs_spn_short_read_cb(int ok, int length, int record,
-					const unsigned char *data,
-					int record_length, void *user_data)
-{
-	struct ofono_netreg *netreg =3D user_data;
-
-	netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
-
-	if (!ok)
-		return;
-
-	if (!sim_spn_parse(data, length, &netreg->spn))
-		return;
-
-	if (netreg->current_operator)
-		netreg_emit_operator_display_name(netreg);
-}
-
-static void sim_cphs_spn_read_cb(int ok, int length, int record,
-					const unsigned char *data,
-					int record_length, void *user_data)
-{
-	struct ofono_netreg *netreg =3D user_data;
-
-	if (!ok) {
-		if (__ofono_sim_cphs_service_available(netreg->sim,
-						SIM_CPHS_SERVICE_SHORT_SPN))
-			ofono_sim_read(netreg->sim_context,
-					SIM_EF_CPHS_SPN_SHORT_FILEID,
-					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-					sim_cphs_spn_short_read_cb, netreg);
-		else
-			netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
-
-		return;
-	}
-
-	netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
-
-	if (!sim_spn_parse(data, length, &netreg->spn))
-		return;
-
-	if (netreg->current_operator)
-		netreg_emit_operator_display_name(netreg);
-}
-
-static void sim_spn_read_cb(int ok, int length, int record,
-				const unsigned char *data,
-				int record_length, void *user_data)
-{
-	struct ofono_netreg *netreg =3D user_data;
-
-	if (!ok) {
-		ofono_sim_read(netreg->sim_context,
-				SIM_EF_CPHS_SPN_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				sim_cphs_spn_read_cb, netreg);
-
-		return;
-	}
-
-	netreg->flags &=3D ~NETWORK_REGISTRATION_FLAG_READING_SPN;
-
-	if (!sim_spn_parse(data + 1, length - 1, &netreg->spn))
-		return;
-
-	sim_spn_display_condition_parse(netreg, data[0]);
-
-	if (netreg->current_operator)
-		netreg_emit_operator_display_name(netreg);
-}
-
-static void sim_spn_changed(int id, void *userdata)
-{
-	struct ofono_netreg *netreg =3D userdata;
-	gboolean had_spn;
-
-	if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN)
-		return;
-
-	had_spn =3D netreg->spn !=3D NULL && strlen(netreg->spn) > 0;
-	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
-				NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
+	struct ofono_netreg *netreg =3D data;
+	gboolean had_spn =3D netreg->spn !=3D NULL && strlen(netreg->spn) > 0;
 =

 	g_free(netreg->spn);
 	netreg->spn =3D NULL;
+	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
+				NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
 =

 	/*
 	 * We can't determine whether the property really changed
@@ -1778,10 +1666,13 @@ static void sim_spn_changed(int id, void *userdata)
 	if (had_spn && netreg->current_operator)
 		netreg_emit_operator_display_name(netreg);
 =

-	netreg->flags |=3D NETWORK_REGISTRATION_FLAG_READING_SPN;
-	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
-			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-			sim_spn_read_cb, netreg);
+	if (dc)
+		sim_spn_display_condition_parse(netreg, *dc);
+
+	netreg->spn =3D g_strdup(spn);
+
+	if (netreg->current_operator)
+		netreg_emit_operator_display_name(netreg);
 }
 =

 int ofono_netreg_get_location(struct ofono_netreg *netreg)
@@ -1919,6 +1810,12 @@ static void netreg_unregister(struct ofono_atom *ato=
m)
 		netreg->settings =3D NULL;
 	}
 =

+	if (netreg->spn_watch)
+		ofono_sim_remove_spn_watch(netreg->sim, &netreg->spn_watch);
+
+	g_free(netreg->spn);
+	netreg->spn =3D NULL;
+
 	if (netreg->sim_context) {
 		ofono_sim_context_free(netreg->sim_context);
 		netreg->sim_context =3D NULL;
@@ -1947,7 +1844,6 @@ static void netreg_remove(struct ofono_atom *atom)
 	sim_eons_free(netreg->eons);
 	sim_spdi_free(netreg->spdi);
 =

-	g_free(netreg->spn);
 	g_free(netreg);
 }
 =

@@ -2199,25 +2095,8 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 						sim_pnn_opl_changed, netreg,
 						NULL);
 =

-		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_READING_SPN;
-		ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				sim_spn_read_cb, netreg);
-
-		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFSPN_FILEID,
-						sim_spn_changed, netreg,
-						NULL);
-		ofono_sim_add_file_watch(netreg->sim_context,
-						SIM_EF_CPHS_SPN_FILEID,
-						sim_spn_changed, netreg,
-						NULL);
-
-		if (__ofono_sim_cphs_service_available(netreg->sim,
-						SIM_CPHS_SERVICE_SHORT_SPN))
-			ofono_sim_add_file_watch(netreg->sim_context,
-						SIM_EF_CPHS_SPN_SHORT_FILEID,
-						sim_spn_changed,
-						netreg, NULL);
+		ofono_sim_add_spn_watch(netreg->sim, &netreg->spn_watch,
+						spn_read_cb, netreg, NULL);
 =

 		if (__ofono_sim_service_available(netreg->sim,
 				SIM_UST_SERVICE_PROVIDER_DISPLAY_INFO,
-- =

1.7.5.4


--===============3757263138517639504==--


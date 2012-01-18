Content-Type: multipart/mixed; boundary="===============5058800274317367775=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 4/4] network: Access SPN directly from the sim atom
Date: Wed, 18 Jan 2012 13:56:29 +0200
Message-ID: <1326887789-16478-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326887789-16478-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5058800274317367775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/src/network.c b/src/network.c
index e5f67a8..0699ff2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -82,7 +82,6 @@ struct ofono_netreg {
 	void *driver_data;
 	struct ofono_atom *atom;
 	unsigned int hfp_watch;
-	char *spn;
 	unsigned int spn_watch;
 };
 =

@@ -362,6 +361,7 @@ static char *get_operator_display_name(struct ofono_net=
reg *netreg)
 {
 	struct network_operator_data *opd =3D netreg->current_operator;
 	const char *plmn;
+	const char *spn;
 	static char name[1024];
 	static char mccmnc[OFONO_MAX_MCC_LENGTH + OFONO_MAX_MNC_LENGTH + 1];
 	int len =3D sizeof(name);
@@ -392,7 +392,9 @@ static char *get_operator_display_name(struct ofono_net=
reg *netreg)
 	if (opd->eons_info && opd->eons_info->longname)
 		plmn =3D opd->eons_info->longname;
 =

-	if (netreg->spn =3D=3D NULL || strlen(netreg->spn) =3D=3D 0) {
+	spn =3D ofono_sim_get_spn(netreg->sim);
+
+	if (spn =3D=3D NULL || strlen(spn) =3D=3D 0) {
 		g_strlcpy(name, plmn, len);
 		return name;
 	}
@@ -406,14 +408,14 @@ static char *get_operator_display_name(struct ofono_n=
etreg *netreg)
 	if (home_or_spdi)
 		if (netreg->flags & NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN)
 			/* Case 1 */
-			snprintf(name, len, "%s (%s)", netreg->spn, plmn);
+			snprintf(name, len, "%s (%s)", spn, plmn);
 		else
 			/* Case 2 */
-			snprintf(name, len, "%s", netreg->spn);
+			snprintf(name, len, "%s", spn);
 	else
 		if (netreg->flags & NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN)
 			/* Case 3 */
-			snprintf(name, len, "%s (%s)", netreg->spn, plmn);
+			snprintf(name, len, "%s (%s)", spn, plmn);
 		else
 			/* Case 4 */
 			snprintf(name, len, "%s", plmn);
@@ -1652,16 +1654,12 @@ static void spn_read_cb(const char *spn, const char=
 *dc, void *data)
 {
 	struct ofono_netreg *netreg =3D data;
 =

-	g_free(netreg->spn);
-	netreg->spn =3D NULL;
 	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
 				NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
 =

 	if (dc)
 		sim_spn_display_condition_parse(netreg, *dc);
 =

-	netreg->spn =3D g_strdup(spn);
-
 	if (netreg->current_operator)
 		netreg_emit_operator_display_name(netreg);
 }
@@ -1804,9 +1802,6 @@ static void netreg_unregister(struct ofono_atom *atom)
 	if (netreg->spn_watch)
 		ofono_sim_remove_spn_watch(netreg->sim, &netreg->spn_watch);
 =

-	g_free(netreg->spn);
-	netreg->spn =3D NULL;
-
 	if (netreg->sim_context) {
 		ofono_sim_context_free(netreg->sim_context);
 		netreg->sim_context =3D NULL;
-- =

1.7.5.4


--===============5058800274317367775==--


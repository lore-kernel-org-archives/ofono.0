Content-Type: multipart/mixed; boundary="===============7526995719990226548=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 3/9] network: Rename spname to spn
Date: Fri, 02 Dec 2011 13:10:31 +0200
Message-ID: <1322824237-10039-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7526995719990226548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/network.c b/src/network.c
index 677b936..fbcd449 100644
--- a/src/network.c
+++ b/src/network.c
@@ -70,7 +70,7 @@ struct ofono_netreg {
 	int flags;
 	DBusMessage *pending;
 	int signal_strength;
-	char *spname;
+	char *spn;
 	struct sim_spdi *spdi;
 	struct sim_eons *eons;
 	struct ofono_sim *sim;
@@ -390,7 +390,7 @@ static char *get_operator_display_name(struct ofono_net=
reg *netreg)
 	if (opd->eons_info && opd->eons_info->longname)
 		plmn =3D opd->eons_info->longname;
 =

-	if (netreg->spname =3D=3D NULL || strlen(netreg->spname) =3D=3D 0) {
+	if (netreg->spn =3D=3D NULL || strlen(netreg->spn) =3D=3D 0) {
 		g_strlcpy(name, plmn, len);
 		return name;
 	}
@@ -404,14 +404,14 @@ static char *get_operator_display_name(struct ofono_n=
etreg *netreg)
 	if (home_or_spdi)
 		if (netreg->flags & NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN)
 			/* Case 1 */
-			snprintf(name, len, "%s (%s)", netreg->spname, plmn);
+			snprintf(name, len, "%s (%s)", netreg->spn, plmn);
 		else
 			/* Case 2 */
-			snprintf(name, len, "%s", netreg->spname);
+			snprintf(name, len, "%s", netreg->spn);
 	else
 		if (netreg->flags & NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN)
 			/* Case 3 */
-			snprintf(name, len, "%s (%s)", netreg->spname, plmn);
+			snprintf(name, len, "%s (%s)", netreg->spn, plmn);
 		else
 			/* Case 4 */
 			snprintf(name, len, "%s", plmn);
@@ -1722,7 +1722,7 @@ static void sim_spn_read_cb(int ok, int length, int r=
ecord,
 =

 	dcbyte =3D data[0];
 =

-	if (!sim_spn_parse(data + 1, length - 1, &netreg->spname))
+	if (!sim_spn_parse(data + 1, length - 1, &netreg->spn))
 		return;
 =

 	ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
@@ -1898,7 +1898,7 @@ static void netreg_remove(struct ofono_atom *atom)
 	sim_eons_free(netreg->eons);
 	sim_spdi_free(netreg->spdi);
 =

-	g_free(netreg->spname);
+	g_free(netreg->spn);
 	g_free(netreg);
 }
 =

@@ -2031,8 +2031,8 @@ static void sim_spn_spdi_changed(int id, void *userda=
ta)
 	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
 			NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
 =

-	g_free(netreg->spname);
-	netreg->spname =3D NULL;
+	g_free(netreg->spn);
+	netreg->spn =3D NULL;
 =

 	sim_spdi_free(netreg->spdi);
 	netreg->spdi =3D NULL;
-- =

1.7.5.4


--===============7526995719990226548==--


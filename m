Content-Type: multipart/mixed; boundary="===============3886601997952116667=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 2/4] voicecall: refactor emergency number list handling
Date: Mon, 28 Mar 2011 06:58:07 -0700
Message-ID: <1301320689-25201-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301320689-25201-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3886601997952116667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index b1d5586..826e10c 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -47,7 +47,8 @@ struct ofono_voicecall {
 	GSList *release_list;
 	GSList *multiparty_list;
 	GSList *en_list;  /* emergency number list */
-	GSList *new_en_list; /* Emergency numbers being read from SIM */
+	GSList *sim_en_list; /* Emergency numbers being read from SIM */
+	GSList *new_en_list; /* Emergency numbers from modem/network/no SIM*/
 	DBusMessage *pending;
 	struct ofono_sim *sim;
 	struct ofono_sim_context *sim_context;
@@ -2071,6 +2072,7 @@ static void emit_en_list_changed(struct ofono_voiceca=
ll *vc)
 static void set_new_ecc(struct ofono_voicecall *vc)
 {
 	int i =3D 0;
+	GSList *l;
 =

 	g_slist_foreach(vc->en_list, (GFunc) g_free, NULL);
 	g_slist_free(vc->en_list);
@@ -2079,6 +2081,12 @@ static void set_new_ecc(struct ofono_voicecall *vc)
 	vc->en_list =3D vc->new_en_list;
 	vc->new_en_list =3D NULL;
 =

+	for (l =3D vc->sim_en_list; l; l =3D l->next) {
+		if (!g_slist_find_custom(vc->en_list, l->data, number_compare))
+			vc->en_list =3D g_slist_prepend(vc->en_list,
+							g_strdup(l->data));
+	}
+
 	while (default_en_list[i]) {
 		GSList *l;
 =

@@ -2120,10 +2128,11 @@ static void ecc_g2_read_cb(int ok, int total_length=
, int record,
 		data +=3D 3;
 =

 		if (en[0] !=3D '\0')
-			vc->new_en_list =3D g_slist_prepend(vc->new_en_list,
+			vc->sim_en_list =3D g_slist_prepend(vc->sim_en_list,
 								g_strdup(en));
 	}
 =

+	vc->sim_en_list =3D g_slist_reverse(vc->sim_en_list);
 	set_new_ecc(vc);
 }
 =

@@ -2149,16 +2158,17 @@ static void ecc_g3_read_cb(int ok, int total_length=
, int record,
 	extract_bcd_number(data, 3, en);
 =

 	if (en[0] !=3D '\0')
-		vc->new_en_list =3D g_slist_prepend(vc->new_en_list,
+		vc->sim_en_list =3D g_slist_prepend(vc->sim_en_list,
 							g_strdup(en));
 =

 	if (record !=3D total)
 		return;
 =

 check:
-	if (!ok && vc->new_en_list =3D=3D NULL)
+	if (!ok && vc->sim_en_list =3D=3D NULL)
 		return;
 =

+	vc->sim_en_list =3D g_slist_reverse(vc->sim_en_list);
 	set_new_ecc(vc);
 }
 =

@@ -2231,6 +2241,12 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->new_en_list =3D NULL;
 	}
 =

+	if (vc->sim_en_list) {
+		g_slist_foreach(vc->sim_en_list, (GFunc) g_free, NULL);
+		g_slist_free(vc->sim_en_list);
+		vc->sim_en_list =3D NULL;
+	}
+
 	if (vc->sim_state_watch) {
 		ofono_sim_remove_state_watch(vc->sim, vc->sim_state_watch);
 		vc->sim_state_watch =3D 0;
@@ -2330,10 +2346,10 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
 		 * Free the currently being read EN list, just in case the
 		 * SIM is removed when we're still reading them
 		 */
-		if (vc->new_en_list) {
-			g_slist_foreach(vc->new_en_list, (GFunc) g_free, NULL);
-			g_slist_free(vc->new_en_list);
-			vc->new_en_list =3D NULL;
+		if (vc->sim_en_list) {
+			g_slist_foreach(vc->sim_en_list, (GFunc) g_free, NULL);
+			g_slist_free(vc->sim_en_list);
+			vc->sim_en_list =3D NULL;
 		}
 =

 		add_to_en_list(&vc->new_en_list, default_en_list_no_sim);
-- =

1.7.0.4


--===============3886601997952116667==--


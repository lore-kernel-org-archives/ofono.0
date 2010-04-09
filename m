Content-Type: multipart/mixed; boundary="===============5216119645797516804=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] Retrieve/forget emergency numbers on SIM insert/remove.
Date: Fri, 09 Apr 2010 08:49:14 +0200
Message-ID: <1270795754-7185-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5216119645797516804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 8bf6379..b6e0226 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -54,6 +54,7 @@ struct ofono_voicecall {
 	gint emit_calls_source;
 	gint emit_multi_source;
 	unsigned int sim_watch;
+	unsigned int sim_state_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1784,6 +1785,10 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 static void voicecall_remove(struct ofono_atom *atom)
 {
 	struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	struct ofono_atom *sim_atom =3D
+		__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	struct ofono_sim *sim =3D NULL;
 =

 	DBG("atom: %p", atom);
 =

@@ -1805,6 +1810,14 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->new_en_list =3D NULL;
 	}
 =

+	if (sim_atom && __ofono_atom_get_registered(sim_atom))
+		sim =3D __ofono_atom_get_data(sim_atom);
+
+	if (sim && vc->sim_state_watch) {
+		ofono_sim_remove_state_watch(sim, vc->sim_state_watch);
+		vc->sim_state_watch =3D 0;
+	}
+
 	g_free(vc);
 }
 =

@@ -1843,6 +1856,46 @@ struct ofono_voicecall *ofono_voicecall_create(struc=
t ofono_modem *modem,
 	return vc;
 }
 =

+static void sim_state_watch(void *user, enum ofono_sim_state new_state)
+{
+	struct ofono_voicecall *vc =3D user;
+
+	if (new_state =3D=3D OFONO_SIM_STATE_INSERTED) {
+		struct ofono_modem *modem =3D
+			__ofono_atom_get_modem(vc->atom);
+		struct ofono_atom *sim_atom =3D
+			__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+		struct ofono_sim *sim =3D
+			__ofono_atom_get_data(sim_atom);
+
+		/* Try both formats, only one or none will work */
+		ofono_sim_read(sim, SIM_EFECC_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				ecc_g2_read_cb, vc);
+		ofono_sim_read(sim, SIM_EFECC_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_FIXED,
+				ecc_g3_read_cb, vc);
+
+		return;
+	}
+
+	if (new_state !=3D OFONO_SIM_STATE_NOT_PRESENT)
+		return;
+
+	if (vc->call_list) {
+		/* TODO: Must release all non-emergency calls */
+	}
+
+	if (vc->new_en_list) {
+		g_slist_foreach(vc->new_en_list, (GFunc) g_free, NULL);
+		g_slist_free(vc->new_en_list);
+		vc->new_en_list =3D NULL;
+	}
+
+	add_to_en_list(&vc->new_en_list, default_en_list_no_sim);
+	set_new_ecc(vc);
+}
+
 static void sim_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
@@ -1850,16 +1903,14 @@ static void sim_watch(struct ofono_atom *atom,
 	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		vc->sim_state_watch =3D 0;
 		return;
 	}
 =

-	/* Try both formats, only one or none will work */
-	ofono_sim_read(sim, SIM_EFECC_FILEID,
-			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-			ecc_g2_read_cb, vc);
-	ofono_sim_read(sim, SIM_EFECC_FILEID,
-			OFONO_SIM_FILE_STRUCTURE_FIXED,
-			ecc_g3_read_cb, vc);
+	vc->sim_state_watch =3D ofono_sim_add_state_watch(sim,
+			sim_state_watch, vc, NULL);
+
+	sim_state_watch(vc, ofono_sim_get_state(sim));
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.6.1


--===============5216119645797516804==--


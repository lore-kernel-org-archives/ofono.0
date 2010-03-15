Content-Type: multipart/mixed; boundary="===============5919520773510780591=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8][RFC] Release calls when SIM is removed.
Date: Mon, 15 Mar 2010 22:21:25 +0100
Message-ID: <1268688085-3872-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5919520773510780591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++---=
---
 1 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 18b923f..eef924c 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -57,6 +57,8 @@ struct ofono_voicecall {
 	gint emit_calls_source;
 	gint emit_multi_source;
 	unsigned int sim_watch;
+	unsigned int sim_ready_watch;
+	unsigned int sim_removed_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1788,6 +1790,10 @@ static void voicecall_unregister(struct ofono_atom *=
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

@@ -1809,6 +1815,19 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->new_en_list =3D NULL;
 	}
 =

+	if (sim_atom && __ofono_atom_get_registered(sim_atom))
+		sim =3D __ofono_atom_get_data(sim_atom);
+
+	if (sim && vc->sim_ready_watch) {
+		ofono_sim_remove_ready_watch(sim, vc->sim_ready_watch);
+		vc->sim_ready_watch =3D 0;
+	}
+
+	if (sim && vc->sim_removed_watch) {
+		ofono_sim_remove_removed_watch(sim, vc->sim_removed_watch);
+		vc->sim_removed_watch =3D 0;
+	}
+
 	g_free(vc);
 }
 =

@@ -1847,6 +1866,34 @@ struct ofono_voicecall *ofono_voicecall_create(struc=
t ofono_modem *modem,
 	return vc;
 }
 =

+static void sim_ready_watch(void *user)
+{
+	struct ofono_voicecall *vc =3D user;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	struct ofono_atom *sim_atom =3D
+		__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+	struct ofono_sim *sim =3D __ofono_atom_get_data(sim_atom);
+
+	/* Try both formats, only one or none will work */
+	ofono_sim_read(sim, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			ecc_g2_read_cb, vc);
+	ofono_sim_read(sim, SIM_EFECC_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			ecc_g3_read_cb, vc);
+}
+
+static void sim_removed_watch(void *user)
+{
+	struct ofono_voicecall *vc =3D user;
+
+	vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
+
+	/* TODO: Don't hang up emergency calls */
+	voicecalls_release_queue(vc, vc->call_list);
+	voicecalls_release_next(vc);
+}
+
 static void sim_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
@@ -1854,16 +1901,18 @@ static void sim_watch(struct ofono_atom *atom,
 	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		vc->sim_ready_watch =3D 0;
+		vc->sim_removed_watch =3D 0;
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
+	vc->sim_ready_watch =3D ofono_sim_add_ready_watch(sim,
+			sim_ready_watch, vc, NULL);
+	vc->sim_removed_watch =3D ofono_sim_add_removed_watch(sim,
+			sim_removed_watch, vc, NULL);
+
+	if (ofono_sim_get_ready(sim))
+		sim_ready_watch(vc);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.6.1


--===============5919520773510780591==--


Content-Type: multipart/mixed; boundary="===============1658356811971204653=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 5/5] src: Adapt to emulator changes
Date: Mon, 02 Nov 2015 18:27:20 +0100
Message-ID: <1446485240-22049-6-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1446485240-22049-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1658356811971204653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adapt to emulator changes for supporting multiple modems.
---
 src/modem.c     | 10 ++++------
 src/network.c   | 30 +++++++++++++++---------------
 src/ofono.h     |  2 +-
 src/sim.c       | 10 +++-------
 src/voicecall.c | 35 +++++++++++++++--------------------
 5 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 01b0e35..684274b 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1528,15 +1528,13 @@ static void gcap_cb(struct ofono_emulator *em,
 static void dun_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
-
 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
 		return;
 =

-	ofono_emulator_add_handler(em, "+GMI", gmi_cb, data, NULL);
-	ofono_emulator_add_handler(em, "+GMM", gmm_cb, data, NULL);
-	ofono_emulator_add_handler(em, "+GMR", gmr_cb, data, NULL);
-	ofono_emulator_add_handler(em, "+GCAP", gcap_cb, data, NULL);
+	ofono_emulator_add_handler(atom, "+GMI", gmi_cb, data, NULL);
+	ofono_emulator_add_handler(atom, "+GMM", gmm_cb, data, NULL);
+	ofono_emulator_add_handler(atom, "+GMR", gmr_cb, data, NULL);
+	ofono_emulator_add_handler(atom, "+GCAP", gcap_cb, data, NULL);
 }
 =

 int ofono_devinfo_driver_register(const struct ofono_devinfo_driver *d)
diff --git a/src/network.c b/src/network.c
index 1dddcac..c98ff9a 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1314,20 +1314,24 @@ static void signal_strength_callback(const struct o=
fono_error *error,
 =

 static void notify_emulator_status(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
-
 	switch (GPOINTER_TO_INT(data)) {
 	case NETWORK_REGISTRATION_STATUS_REGISTERED:
-		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SERVICE, 1);
-		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0);
+		ofono_emulator_set_indicator(atom,
+						OFONO_EMULATOR_IND_SERVICE, 1);
+		ofono_emulator_set_indicator(atom,
+						OFONO_EMULATOR_IND_ROAMING, 0);
 		break;
 	case NETWORK_REGISTRATION_STATUS_ROAMING:
-		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SERVICE, 1);
-		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_ROAMING, 1);
+		ofono_emulator_set_indicator(atom,
+						OFONO_EMULATOR_IND_SERVICE, 1);
+		ofono_emulator_set_indicator(atom,
+						OFONO_EMULATOR_IND_ROAMING, 1);
 		break;
 	default:
-		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0);
-		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0);
+		ofono_emulator_set_indicator(atom,
+						OFONO_EMULATOR_IND_SERVICE, 0);
+		ofono_emulator_set_indicator(atom,
+						OFONO_EMULATOR_IND_ROAMING, 0);
 	}
 }
 =

@@ -1500,13 +1504,12 @@ static void init_registration_status(const struct o=
fono_error *error,
 =

 static void notify_emulator_strength(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	int val =3D 0;
 =

 	if (GPOINTER_TO_INT(data) > 0)
 		val =3D (GPOINTER_TO_INT(data) - 1) / 20 + 1;
 =

-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_SIGNAL, val);
+	ofono_emulator_set_indicator(atom, OFONO_EMULATOR_IND_SIGNAL, val);
 }
 =

 void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strengt=
h)
@@ -1745,9 +1748,7 @@ void ofono_netreg_driver_unregister(const struct ofon=
o_netreg_driver *d)
 =

 static void emulator_remove_handler(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
-
-	ofono_emulator_remove_handler(em, data);
+	ofono_emulator_remove_handler(atom, data);
 }
 =

 static void netreg_unregister(struct ofono_atom *atom)
@@ -2024,13 +2025,12 @@ fail:
 static void emulator_hfp_init(struct ofono_atom *atom, void *data)
 {
 	struct ofono_netreg *netreg =3D data;
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 =

 	notify_emulator_status(atom, GINT_TO_POINTER(netreg->status));
 	notify_emulator_strength(atom,
 				GINT_TO_POINTER(netreg->signal_strength));
 =

-	ofono_emulator_add_handler(em, "+COPS", emulator_cops_cb, data, NULL);
+	ofono_emulator_add_handler(atom, "+COPS", emulator_cops_cb, data, NULL);
 }
 =

 static void emulator_hfp_watch(struct ofono_atom *atom,
diff --git a/src/ofono.h b/src/ofono.h
index bfcb58f..a46f458 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -512,7 +512,7 @@ enum ofono_emulator_slc_condition {
 	OFONO_EMULATOR_SLC_CONDITION_BIND,
 };
 =

-void __ofono_emulator_set_indicator_forced(struct ofono_emulator *em,
+void __ofono_emulator_set_indicator_forced(struct ofono_atom *atom,
 						const char *name, int value);
 void __ofono_emulator_slc_condition(struct ofono_emulator *em,
 					enum ofono_emulator_slc_condition cond);
diff --git a/src/sim.c b/src/sim.c
index 7614b33..2eb524e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2847,9 +2847,7 @@ void ofono_sim_driver_unregister(const struct ofono_s=
im_driver *d)
 =

 static void emulator_remove_handler(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
-
-	ofono_emulator_remove_handler(em, data);
+	ofono_emulator_remove_handler(atom, data);
 }
 =

 static void sim_unregister(struct ofono_atom *atom)
@@ -2973,11 +2971,9 @@ static void emulator_hfp_watch(struct ofono_atom *at=
om,
 				enum ofono_atom_watch_condition cond,
 				void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
-
 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
-		ofono_emulator_add_handler(em, "+CNUM", emulator_cnum_cb, data,
-						NULL);
+		ofono_emulator_add_handler(atom, "+CNUM",
+						emulator_cnum_cb, data, NULL);
 }
 =

 void ofono_sim_register(struct ofono_sim *sim)
diff --git a/src/voicecall.c b/src/voicecall.c
index b088239..1d4a3b8 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -754,36 +754,33 @@ static void emulator_set_indicator_forced(struct ofon=
o_voicecall *vc,
 						const char *name, int value)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
-	struct ofono_emulator *em;
+	struct ofono_atom *atom;
 =

-	em =3D __ofono_atom_find(OFONO_ATOM_TYPE_EMULATOR_HFP, modem);
-	if (em)
-		__ofono_emulator_set_indicator_forced(em, name, value);
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP);
+	if (atom)
+		__ofono_emulator_set_indicator_forced(atom, name, value);
 }
 =

 static void emulator_call_status_cb(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	struct emulator_status *s =3D data;
 =

-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL, s->status);
+	ofono_emulator_set_indicator(atom, OFONO_EMULATOR_IND_CALL, s->status);
 }
 =

 static void emulator_callsetup_status_cb(struct ofono_atom *atom, void *da=
ta)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	struct emulator_status *s =3D data;
 =

-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+	ofono_emulator_set_indicator(atom, OFONO_EMULATOR_IND_CALLSETUP,
 					s->status);
 }
 =

 static void emulator_callheld_status_cb(struct ofono_atom *atom, void *dat=
a)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	struct emulator_status *s =3D data;
 =

-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLHELD,
+	ofono_emulator_set_indicator(atom, OFONO_EMULATOR_IND_CALLHELD,
 					s->status);
 }
 =

@@ -2655,9 +2652,7 @@ void ofono_voicecall_driver_unregister(const struct o=
fono_voicecall_driver *d)
 =

 static void emulator_remove_handler(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
-
-	ofono_emulator_remove_handler(em, data);
+	ofono_emulator_remove_handler(atom, data);
 }
 =

 static void emulator_hfp_unregister(struct ofono_atom *atom)
@@ -3541,13 +3536,13 @@ static void emulator_hfp_watch(struct ofono_atom *a=
tom,
 =

 	notify_emulator_call_status(vc);
 =

-	ofono_emulator_add_handler(em, "A", emulator_ata_cb, vc, NULL);
-	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, vc, NULL);
-	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, vc, NULL);
-	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, vc, NULL);
-	ofono_emulator_add_handler(em, "+VTS", emulator_vts_cb, vc, NULL);
-	ofono_emulator_add_handler(em, "D", emulator_atd_cb, vc, NULL);
-	ofono_emulator_add_handler(em, "+BLDN", emulator_bldn_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "A", emulator_ata_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "+CHUP", emulator_chup_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "+CLCC", emulator_clcc_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "+CHLD", emulator_chld_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "+VTS", emulator_vts_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "D", emulator_atd_cb, vc, NULL);
+	ofono_emulator_add_handler(atom, "+BLDN", emulator_bldn_cb, vc, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

2.1.4


--===============1658356811971204653==--


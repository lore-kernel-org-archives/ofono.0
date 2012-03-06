Content-Type: multipart/mixed; boundary="===============1669247011748301612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] emulator: Fix PTS test case TC_AG_TWC_BV_02_I
Date: Tue, 06 Mar 2012 08:38:37 -0600
Message-ID: <1331044717-8246-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1669247011748301612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   48 +++++++++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 262e782..5f460c2 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -36,6 +36,8 @@
 =

 #define RING_TIMEOUT 3
 =

+#define EMULATOR_FLAG_WAITING_TRANSITION	1
+
 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
@@ -52,6 +54,7 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	int flags;
 };
 =

 struct indicator {
@@ -420,14 +423,6 @@ static gboolean notify_ring(void *user_data)
 		return TRUE;
 =

 	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
-
-	/*
-	 * In case of waiting call becoming an incoming call, call status
-	 * change may not have been done yet, so try to find waiting call too
-	 */
-	if (c =3D=3D NULL)
-		c =3D find_call_with_status(em, CALL_STATUS_WAITING);
-
 	if (c =3D=3D NULL)
 		return TRUE;
 =

@@ -1186,19 +1181,29 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 	gboolean callsetup;
 	gboolean waiting;
 =

+	ofono_debug("name: %s, value: %d", name, value);
+
 	ind =3D find_indicator(em, name, &i);
 =

-	if (ind =3D=3D NULL || ind->value =3D=3D value || value < ind->min
-			|| value > ind->max)
+	if (ind =3D=3D NULL || value < ind->min || value > ind->max)
+		return;
+
+	cs_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, NULL);
+	callsetup =3D ind =3D=3D cs_ind;
+
+	if (em->flags & EMULATOR_FLAG_WAITING_TRANSITION) {
+		if (ind->value =3D=3D value && callsetup)
+			goto callsetup;
+	}
+
+	if (ind->value =3D=3D value)
 		return;
 =

 	ind->value =3D value;
 =

 	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
-	cs_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, NULL);
 =

 	call =3D ind =3D=3D call_ind;
-	callsetup =3D ind =3D=3D cs_ind;
 =

 	/*
 	 * When callsetup indicator goes to Incoming and there is an active
@@ -1218,6 +1223,16 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
 			ind->deferred =3D TRUE;
 	}
 =

+callsetup:
+	/*
+	 * In case of waiting call becoming an incoming call, call status
+	 * change may not have been done yet, so do nothing
+	 */
+	if (find_call_with_status(em, CALL_STATUS_WAITING) !=3D NULL) {
+		em->flags |=3D EMULATOR_FLAG_WAITING_TRANSITION;
+		return;
+	}
+
 	/*
 	 * Ring timer should be started when:
 	 * - callsetup indicator is set to Incoming and there is no active call
@@ -1227,17 +1242,12 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 	 * In those cases, a first RING should be sent just after the +CIEV
 	 * Ring timer should be stopped for all other values of callsetup
 	 */
-	if (waiting)
-		return;
-
-	/* Call state went from active/held + waiting -> incoming */
-	if (call && value =3D=3D OFONO_EMULATOR_CALL_INACTIVE &&
-			cs_ind->value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING)
-		goto start_ring;
 =

 	if (!callsetup)
 		return;
 =

+	em->flags &=3D ~EMULATOR_FLAG_WAITING_TRANSITION;
+
 	if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING) {
 		if (em->callsetup_source > 0) {
 			g_source_remove(em->callsetup_source);
-- =

1.7.3.4


--===============1669247011748301612==--


Content-Type: multipart/mixed; boundary="===============2647658001473746520=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: fix CCWA for PTS
Date: Fri, 24 Jun 2011 16:11:05 +0200
Message-ID: <1308924665-9039-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2647658001473746520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During test TP/TCA/BV-05-I [Terminate Ongoing Call =E2=80=93 While Call Wai=
ting]
PTS fails if multiple +CCWA are sent (waiting for 1st phone number when
waiting one becomes incoming, intead of 2nd phone number).
So, send only 1 +CCWA.

Update RING timer management to be started as soon as an incoming call
exists, and retrieve +CLIP info for incoming or waiting call (in case
of waiting call becoming incoming call, call indicator changes before
internal call status is updated)
---
 src/emulator.c |   74 ++++++++++++++++++++++++++++++----------------------=
---
 1 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 906404d..eea69f0 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -352,7 +352,8 @@ static void notify_ccwa(struct ofono_emulator *em)
 	 */
 	char str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];
 =

-	if (!em->ccwa)
+	if ((em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE) ||
+			!em->ccwa)
 		return;
 =

 	c =3D find_call_with_status(em, CALL_STATUS_WAITING);
@@ -366,8 +367,9 @@ static void notify_ccwa(struct ofono_emulator *em)
 		g_at_server_send_unsolicited(em->server, "+CCWA: \"\",128");
 }
 =

-static void notify_ring(struct ofono_emulator *em)
+static gboolean notify_ring(void *user_data)
 {
+	struct ofono_emulator *em =3D user_data;
 	struct ofono_call *c;
 	const char *phone;
 	/*
@@ -376,15 +378,25 @@ static void notify_ring(struct ofono_emulator *em)
 	 */
 	char str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];
 =

+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE)
+		return TRUE;
+
 	g_at_server_send_unsolicited(em->server, "RING");
 =

 	if (!em->clip)
-		return;
+		return TRUE;
 =

 	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
 =

+	/*
+	 * In case of waiting call becoming an incoming call, call status
+	 * change may not have been done yet, so try to find waiting call too
+	 */
 	if (c =3D=3D NULL)
-		return;
+		c =3D find_call_with_status(em, CALL_STATUS_WAITING);
+
+	if (c =3D=3D NULL)
+		return TRUE;
 =

 	switch (c->clip_validity) {
 	case CLIP_VALIDITY_VALID:
@@ -397,22 +409,6 @@ static void notify_ring(struct ofono_emulator *em)
 		g_at_server_send_unsolicited(em->server, "+CLIP: \"\",128");
 		break;
 	}
-}
-
-static gboolean send_callsetup_notification(gpointer user_data)
-{
-	struct ofono_emulator *em =3D user_data;
-	struct indicator *call_ind;
-
-	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE)
-		return TRUE;
-
-	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
-
-	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
-		notify_ring(em);
-	else
-		notify_ccwa(em);
 =

 	return TRUE;
 }
@@ -1078,7 +1074,10 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
 	char buf[20];
 	struct indicator *ind;
 	struct indicator *call_ind;
+	struct indicator *cs_ind;
+	gboolean call;
 	gboolean callsetup;
+	gboolean waiting;
 =

 	ind =3D find_indicator(em, name, &i);
 =

@@ -1089,16 +1088,20 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 	ind->value =3D value;
 =

 	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
+	cs_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, NULL);
 =

-	callsetup =3D g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP);
+	call =3D (ind =3D=3D call_ind);
+	callsetup =3D (ind =3D=3D cs_ind);
 =

 	/*
 	 * When callsetup indicator goes to Incoming and there is an active
 	 * call a +CCWA should be sent before +CIEV
 	 */
-	if (callsetup && value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING &&
-			call_ind->value =3D=3D OFONO_EMULATOR_CALL_ACTIVE)
-		send_callsetup_notification(em);
+	waiting =3D (callsetup && value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING =
&&
+			call_ind->value =3D=3D OFONO_EMULATOR_CALL_ACTIVE);
+
+	if (waiting)
+		notify_ccwa(em);
 =

 	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
 		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
@@ -1106,21 +1109,24 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 	}
 =

 	/*
-	 * Ring timer should be started when callsetup indicator is set to
-	 * Incoming.  If there is no active call, a first RING should be
-	 * sent just after the +CIEV and should be stopped for all other
-	 * values of callsetup
+	 * Ring timer should be started when:
+	 * - callsetup indicator is set to Incoming and there is no active call
+	 *   (not a waiting call)
+	 * - or call indicator is set to inactive while callsetup is already
+	 *   set to Incoming.
+	 * In those cases, a first RING should be sent just after the +CIEV
+	 * Ring timer should be stopped for all other values of callsetup
 	 */
-	if (!callsetup)
+	if (!((callsetup && !waiting) ||
+			(call && value =3D=3D OFONO_EMULATOR_CALL_INACTIVE &&
+			cs_ind->value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING)))
 		return;
 =

-	switch (value) {
+	switch (cs_ind->value) {
 	case OFONO_EMULATOR_CALLSETUP_INCOMING:
-		if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
-			send_callsetup_notification(em);
-
+		notify_ring(em);
 		em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
-					send_callsetup_notification, em);
+							notify_ring, em);
 		break;
 	default:
 		if (em->callsetup_source > 0) {
-- =

1.7.1


--===============2647658001473746520==--


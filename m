Content-Type: multipart/mixed; boundary="===============0092070590733498774=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 8/8] emulator: add +CCWA support for HFP AG
Date: Thu, 07 Apr 2011 18:34:00 +0200
Message-ID: <1302194040-18811-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302194040-18811-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0092070590733498774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 82 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 7559d07..00588b5 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -60,6 +60,7 @@ struct ofono_emulator {
 	 * + phone type on 3 digits max + terminating null
 	 */
 	char incoming_str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];
+	gboolean ccwa;
 };
 =

 struct indicator {
@@ -208,6 +209,28 @@ static struct indicator *find_indicator(struct ofono_e=
mulator *em,
 	return NULL;
 }
 =

+static void notify_ccwa(struct ofono_emulator *em)
+{
+	const char *phone;
+
+	if (em->incoming &&
+			em->incoming->clip_validity =3D=3D CLIP_VALIDITY_VALID &&
+			em->incoming_str[0] =3D=3D '\0') {
+		phone =3D phone_number_to_string(&em->incoming->phone_number);
+		sprintf(em->incoming_str, "+CCWA: \"%s\",%d", phone,
+				em->incoming->phone_number.type);
+	}
+
+	if (em->ccwa) {
+		if (em->incoming_str[0] =3D=3D '\0')
+			g_at_server_send_unsolicited(em->server,
+							"+CCWA: \"\",128");
+		else
+			g_at_server_send_unsolicited(em->server,
+							em->incoming_str);
+	}
+}
+
 static void notify_ring(struct ofono_emulator *em)
 {
 	const char *phone;
@@ -238,6 +261,8 @@ static gboolean ring_cb(gpointer user_data)
 =

 	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
 		notify_ring(em);
+	else
+		notify_ccwa(em);
 =

 	return TRUE;
 }
@@ -488,6 +513,42 @@ fail:
 	};
 }
 =

+static void ccwa_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	if (em->slc =3D=3D FALSE)
+		goto fail;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto fail;
+
+		if (val !=3D 0 && val !=3D 1)
+			goto fail;
+
+		/* check this is last parameter */
+		if (g_at_result_iter_skip_next(&iter))
+			goto fail;
+
+		em->ccwa =3D val;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	};
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
 					int min, int max, int dflt)
 {
@@ -574,6 +635,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
 		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
+		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -793,6 +855,7 @@ void ofono_emulator_set_indicator(struct ofono_emulator=
 *em,
 	char buf[20];
 	struct indicator *ind;
 	struct indicator *call_ind;
+	gboolean callsetup;
 =

 	ind =3D find_indicator(em, name, &i);
 =

@@ -802,8 +865,26 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 =

 	ind->value =3D value;
 =

+	/*
+	 * When call indicator goes to inactive, force to re-generate
+	 * incoming call (+CLIP or +CCWA) string
+	 */
+	if (g_str_equal(name, OFONO_EMULATOR_IND_CALL) =3D=3D TRUE &&
+			value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
+		em->incoming_str[0] =3D '\0';
+
 	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
 =

+	callsetup =3D g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP);
+
+	/*
+	 * When callsetup indicator goes to Incoming and there is an active call
+	 * a +CCWA should be sent before +CIEV
+	 */
+	if (callsetup && value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING &&
+			call_ind->value =3D=3D OFONO_EMULATOR_CALL_ACTIVE)
+		ring_cb(em);
+
 	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
 		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
 		g_at_server_send_info(em->server, buf, TRUE);
@@ -816,7 +897,7 @@ void ofono_emulator_set_indicator(struct ofono_emulator=
 *em,
 	 *   the +CIEV
 	 * It should be stopped for all other values of callsetup
 	 */
-	if (g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D FALSE)
+	if (!callsetup)
 		return;
 =

 	if (value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING && em->ring =3D=3D 0) {
-- =

1.7.1


--===============0092070590733498774==--


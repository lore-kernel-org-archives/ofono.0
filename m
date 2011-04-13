Content-Type: multipart/mixed; boundary="===============9118883900316038657=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 4/6] emulator: add +CCWA support for HFP AG
Date: Wed, 13 Apr 2011 18:05:32 +0200
Message-ID: <1302710734-6103-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302710734-6103-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9118883900316038657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Conflicts:

	src/emulator.c
---
 src/emulator.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 8e18785..86d9c4f 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -54,6 +54,7 @@ struct ofono_emulator {
 	GSList *indicators;
 	guint callsetup_source;
 	gboolean clip;
+	gboolean ccwa;
 };
 =

 struct indicator {
@@ -219,6 +220,30 @@ static struct ofono_call *find_call_with_status(struct=
 ofono_emulator *em,
 	return __ofono_voicecall_find_call_with_status(vc, status);
 }
 =

+static void notify_ccwa(struct ofono_emulator *em)
+{
+	struct ofono_call *c;
+	const char *phone;
+	/*
+	 * '+CCWA: "+",' + phone number + phone type on 3 digits max
+	 * + terminating null
+	 */
+	char str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];
+
+	if (!em->ccwa)
+		return;
+
+	c =3D find_call_with_status(em, CALL_STATUS_WAITING);
+
+	if (c && c->clip_validity =3D=3D CLIP_VALIDITY_VALID) {
+		phone =3D phone_number_to_string(&c->phone_number);
+		sprintf(str, "+CCWA: \"%s\",%d", phone, c->phone_number.type);
+
+		g_at_server_send_unsolicited(em->server, str);
+	} else
+		g_at_server_send_unsolicited(em->server, "+CCWA: \"\",128");
+}
+
 static void notify_ring(struct ofono_emulator *em)
 {
 	struct ofono_call *c;
@@ -256,6 +281,8 @@ static gboolean send_callsetup_notification(gpointer us=
er_data)
 =

 	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
 		notify_ring(em);
+	else
+		notify_ccwa(em);
 =

 	return TRUE;
 }
@@ -506,6 +533,42 @@ fail:
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
@@ -592,6 +655,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
 		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
+		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -810,6 +874,7 @@ void ofono_emulator_set_indicator(struct ofono_emulator=
 *em,
 	char buf[20];
 	struct indicator *ind;
 	struct indicator *call_ind;
+	gboolean callsetup;
 =

 	ind =3D find_indicator(em, name, &i);
 =

@@ -821,6 +886,16 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 =

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
+		send_callsetup_notification(em);
+
 	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
 		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
 		g_at_server_send_unsolicited(em->server, buf);
@@ -833,7 +908,7 @@ void ofono_emulator_set_indicator(struct ofono_emulator=
 *em,
 	 *   the +CIEV
 	 * It should be stopped for all other values of callsetup
 	 */
-	if (g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D FALSE)
+	if (!callsetup)
 		return;
 =

 	if (value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING) {
-- =

1.7.1


--===============9118883900316038657==--


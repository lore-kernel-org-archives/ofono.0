Content-Type: multipart/mixed; boundary="===============1251510476373205676=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/4] emulator: add AT+BIA support for HFP
Date: Wed, 31 Aug 2011 17:21:30 +0200
Message-ID: <1314804093-12504-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1251510476373205676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 06ec06c..a907b12 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -60,6 +60,8 @@ struct indicator {
 	int min;
 	int max;
 	gboolean deferred;
+	gboolean active;
+	gboolean mandatory;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -360,7 +362,8 @@ static void notify_deferred_indicators(GAtServer *serve=
r, void *user_data)
 		if (!ind->deferred)
 			continue;
 =

-		if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
+		if (em->events_mode =3D=3D 3 && em->events_ind && em->slc &&
+				ind->active) {
 			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
 			g_at_server_send_unsolicited(em->server, buf);
 		}
@@ -783,8 +786,60 @@ fail:
 	}
 }
 =

+static void bia_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		GSList *l;
+		struct indicator *ind;
+		int val;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		/* check validity of the request */
+		while (g_at_result_iter_next_number_default(&iter, 0, &val)) {
+			if (val !=3D 0 &&  val !=3D 1)
+				goto fail;
+		}
+
+		if (g_at_result_iter_skip_next(&iter))
+			goto fail;
+
+		/* request is valid, update the indicator activation status */
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		for (l =3D em->indicators; l; l =3D l->next) {
+			ind =3D l->data;
+
+			if (!g_at_result_iter_next_number_default(&iter,
+							ind->active, &val))
+				break;
+
+			if (!ind->mandatory)
+				ind->active =3D val;
+		}
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	}
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
-					int min, int max, int dflt)
+					int min, int max, int dflt,
+					gboolean mandatory)
 {
 	struct indicator *ind;
 =

@@ -798,6 +853,8 @@ static void emulator_add_indicator(struct ofono_emulato=
r *em, const char* name,
 	ind->min =3D min;
 	ind->max =3D max;
 	ind->value =3D dflt;
+	ind->active =3D TRUE;
+	ind->mandatory =3D mandatory;
 =

 	em->indicators =3D g_slist_append(em->indicators, ind);
 }
@@ -860,15 +917,20 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 						em);
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
-		emulator_add_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0, 1, 0);
-		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALL, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0, 1, 0,
+									FALSE);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALL, 0, 1, 0,
+									TRUE);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, 0, 3,
-									0);
+								0, TRUE);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALLHELD, 0, 2,
-									0);
-		emulator_add_indicator(em, OFONO_EMULATOR_IND_SIGNAL, 0, 5, 0);
-		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0);
-		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
+								0, TRUE);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_SIGNAL, 0, 5, 0,
+									FALSE);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0,
+									FALSE);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5,
+									FALSE);
 =

 		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
@@ -876,6 +938,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
 		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
 		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
+		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -1149,7 +1212,7 @@ void ofono_emulator_set_indicator(struct ofono_emulat=
or *em,
 	if (waiting)
 		notify_ccwa(em);
 =

-	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
+	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc && ind->active)=
 {
 		if (!g_at_server_command_pending(em->server)) {
 			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
 			g_at_server_send_unsolicited(em->server, buf);
-- =

1.7.1


--===============1251510476373205676==--


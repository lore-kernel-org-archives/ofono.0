Content-Type: multipart/mixed; boundary="===============3529053465358136050=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: fix indicator notification
Date: Wed, 27 Jul 2011 17:12:15 +0200
Message-ID: <1311779535-13909-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3529053465358136050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

unsollicited event can not occurs during a command, so defer indicator
notification after 'final' has been sent
---
 src/emulator.c  |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/voicecall.c |   11 -----------
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index deb4780..2edddfe 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -52,6 +52,8 @@ struct ofono_emulator {
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
+	gboolean inprogress;
+	guint deferred_source;
 };
 =

 struct indicator {
@@ -59,6 +61,7 @@ struct indicator {
 	int value;
 	int min;
 	int max;
+	gboolean deferred;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -345,6 +348,35 @@ static struct ofono_call *find_call_with_status(struct=
 ofono_emulator *em,
 	return __ofono_voicecall_find_call_with_status(vc, status);
 }
 =

+static gboolean notify_deferred_indicators(void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	int i =3D 0;
+	char buf[20];
+	GSList *l;
+	struct indicator *ind;
+
+	if (em->events_mode !=3D 3 || !em->events_ind || !em->slc)
+		goto end;
+
+	for (l =3D em->indicators; l; l =3D l->next) {
+		ind =3D l->data;
+
+		if (ind->deferred) {
+			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
+			g_at_server_send_unsolicited(em->server, buf);
+			ind->deferred =3D FALSE;
+		}
+
+		i++;
+	}
+
+end:
+	em->deferred_source =3D 0;
+
+	return FALSE;
+}
+
 static gboolean notify_ccwa(void *user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -790,6 +822,11 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 		em->callsetup_source =3D 0;
 	}
 =

+	if (em->deferred_source) {
+		g_source_remove(em->deferred_source);
+		em->deferred_source =3D 0;
+	}
+
 	for (l =3D em->indicators; l; l =3D l->next) {
 		struct indicator *ind =3D l->data;
 =

@@ -961,6 +998,10 @@ failure:
 		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 		break;
 	};
+
+	em->inprogress =3D FALSE;
+	em->deferred_source =3D g_timeout_add_seconds(0,
+					notify_deferred_indicators, em);
 }
 =

 void ofono_emulator_send_unsolicited(struct ofono_emulator *em,
@@ -1021,6 +1062,8 @@ static void handler_proxy(GAtServer *server, GAtServe=
rRequestType type,
 	g_at_result_iter_init(&req.iter, result);
 	g_at_result_iter_next(&req.iter, "");
 =

+	h->em->inprogress =3D TRUE;
+
 	h->cb(h->em, &req, h->data);
 }
 =

@@ -1124,8 +1167,11 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
 		notify_ccwa(em);
 =

 	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
-		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
-		g_at_server_send_unsolicited(em->server, buf);
+		if (!em->inprogress) {
+			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
+			g_at_server_send_unsolicited(em->server, buf);
+		} else
+			ind->deferred =3D TRUE;
 	}
 =

 	/*
diff --git a/src/voicecall.c b/src/voicecall.c
index 23976af..168ce96 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -700,9 +700,6 @@ static void emulator_call_status_cb(struct ofono_atom *=
atom, void *data)
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	struct emulator_status *s =3D data;
 =

-	if (em =3D=3D s->vc->pending_em)
-		return;
-
 	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL, s->status);
 }
 =

@@ -711,9 +708,6 @@ static void emulator_callsetup_status_cb(struct ofono_a=
tom *atom, void *data)
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	struct emulator_status *s =3D data;
 =

-	if (em =3D=3D s->vc->pending_em)
-		return;
-
 	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
 					s->status);
 }
@@ -723,9 +717,6 @@ static void emulator_callheld_status_cb(struct ofono_at=
om *atom, void *data)
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	struct emulator_status *s =3D data;
 =

-	if (em =3D=3D s->vc->pending_em)
-		return;
-
 	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLHELD,
 					s->status);
 }
@@ -3210,8 +3201,6 @@ static void emulator_dial_callback(const struct ofono=
_error *error, void *data)
 =

 	vc->pending_em =3D NULL;
 =

-	notify_emulator_call_status(vc);
-
 	if (need_to_emit)
 		voicecalls_emit_call_added(vc, v);
 }
-- =

1.7.1


--===============3529053465358136050==--


Content-Type: multipart/mixed; boundary="===============4530485956321322954=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 2/2] emulator: fix indicator notification
Date: Thu, 04 Aug 2011 16:29:50 +0200
Message-ID: <1312468190-27253-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1312468190-27253-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4530485956321322954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c  |   33 +++++++++++++++++++++++++++++++--
 src/voicecall.c |   11 -----------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index deb4780..06ec06c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -59,6 +59,7 @@ struct indicator {
 	int value;
 	int min;
 	int max;
+	gboolean deferred;
 };
 =

 static void emulator_debug(const char *str, void *data)
@@ -345,6 +346,29 @@ static struct ofono_call *find_call_with_status(struct=
 ofono_emulator *em,
 	return __ofono_voicecall_find_call_with_status(vc, status);
 }
 =

+static void notify_deferred_indicators(GAtServer *server, void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	int i;
+	char buf[20];
+	GSList *l;
+	struct indicator *ind;
+
+	for (i =3D 1, l =3D em->indicators; l; l =3D l->next, i++) {
+		ind =3D l->data;
+
+		if (!ind->deferred)
+			continue;
+
+		if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
+			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
+			g_at_server_send_unsolicited(em->server, buf);
+		}
+
+		ind->deferred =3D FALSE;
+	}
+}
+
 static gboolean notify_ccwa(void *user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -832,6 +856,8 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 	g_at_server_set_debug(em->server, emulator_debug, "Server");
 	g_at_server_set_disconnect_function(em->server,
 						emulator_disconnect, em);
+	g_at_server_set_finish_callback(em->server, notify_deferred_indicators,
+						em);
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0, 1, 0);
@@ -1124,8 +1150,11 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
 		notify_ccwa(em);
 =

 	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
-		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
-		g_at_server_send_unsolicited(em->server, buf);
+		if (!g_at_server_command_pending(em->server)) {
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


--===============4530485956321322954==--


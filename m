Content-Type: multipart/mixed; boundary="===============7649166102927909321=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 1/6] emulator: add RING for HFP AG
Date: Wed, 13 Apr 2011 18:05:29 +0200
Message-ID: <1302710734-6103-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302710734-6103-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7649166102927909321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++-----=
---
 1 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 2707592..9005c66 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -37,6 +37,8 @@
 #define DUN_DNS_SERVER_1       "10.10.10.10"
 #define DUN_DNS_SERVER_2       "10.10.10.11"
 =

+#define RING_TIMEOUT 3
+
 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
@@ -49,6 +51,7 @@ struct ofono_emulator {
 	int events_mode;
 	gboolean events_ind;
 	GSList *indicators;
+	guint callsetup_source;
 };
 =

 struct indicator {
@@ -177,6 +180,43 @@ error:
 	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static struct indicator *find_indicator(struct ofono_emulator *em,
+						const char *name, int *index)
+{
+	GSList *l;
+	int i;
+
+	for (i =3D 1, l =3D em->indicators; l; l =3D l->next, i++) {
+		struct indicator *ind =3D l->data;
+
+		if (g_str_equal(ind->name, name) =3D=3D FALSE)
+			continue;
+
+		if (index)
+			*index =3D i;
+
+		return ind;
+	}
+
+	return NULL;
+}
+
+static gboolean send_callsetup_notification(gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	struct indicator *call_ind;
+
+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE)
+		return TRUE;
+
+	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
+
+	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
+		g_at_server_send_unsolicited(em->server, "RING");
+
+	return TRUE;
+}
+
 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -418,6 +458,11 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 		em->source =3D 0;
 	}
 =

+	if (em->callsetup_source) {
+		g_source_remove(em->callsetup_source);
+		em->callsetup_source =3D 0;
+	}
+
 	for (l =3D em->indicators; l; l =3D l->next) {
 		struct indicator *ind =3D l->data;
 =

@@ -681,27 +726,45 @@ enum ofono_emulator_request_type ofono_emulator_reque=
st_get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value)
 {
-	GSList *l;
 	int i;
 	char buf[20];
+	struct indicator *ind;
+	struct indicator *call_ind;
 =

-	for (i =3D 1, l =3D em->indicators; l; l =3D l->next, i++) {
-		struct indicator *ind =3D l->data;
+	ind =3D find_indicator(em, name, &i);
 =

-		if (g_str_equal(ind->name, name) =3D=3D FALSE)
-			continue;
+	if (ind =3D=3D NULL || ind->value =3D=3D value || value < ind->min
+			|| value > ind->max)
+		return;
 =

-		if (ind->value =3D=3D value || value < ind->min
-					|| value > ind->max)
-			return;
+	ind->value =3D value;
 =

-		ind->value =3D value;
+	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
 =

-		if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
-			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
-			g_at_server_send_info(em->server, buf, TRUE);
-		}
+	if (em->events_mode =3D=3D 3 && em->events_ind && em->slc) {
+		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
+		g_at_server_send_unsolicited(em->server, buf);
+	}
 =

+	/*
+	 * Ring timer should be started when callsetup indicator is set to
+	 *   Incoming
+	 * If there is no active call, a first RING should be sent just after
+	 *   the +CIEV
+	 * It should be stopped for all other values of callsetup
+	 */
+	if (g_str_equal(name, OFONO_EMULATOR_IND_CALLSETUP) =3D=3D FALSE)
 		return;
+
+	if (value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING) {
+		if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
+			send_callsetup_notification(em);
+
+		em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
+					send_callsetup_notification, em);
+	} else if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING &&
+						em->callsetup_source) {
+		g_source_remove(em->callsetup_source);
+		em->callsetup_source =3D 0;
 	}
 }
-- =

1.7.1


--===============7649166102927909321==--


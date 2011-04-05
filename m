Content-Type: multipart/mixed; boundary="===============6254938237353650957=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 5/7] emulator: add +CLIP support for HFP AG
Date: Tue, 05 Apr 2011 17:40:29 +0200
Message-ID: <1302018031-12401-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302018031-12401-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6254938237353650957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c  |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/voicecall.c |   17 ++++++++++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 104693d..5a1e509 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 =

 #include "ofono.h"
+#include "common.h"
 #include "gatserver.h"
 #include "gatppp.h"
 =

@@ -53,6 +54,9 @@ struct ofono_emulator {
 	GSList *indicators;
 	guint ring;
 	gboolean active_call;
+	struct ofono_call *incoming;
+	gboolean clip;
+	char clip_str[OFONO_MAX_PHONE_NUMBER_LENGTH + 13 + 1];
 };
 =

 struct indicator {
@@ -184,12 +188,25 @@ error:
 static gboolean ring_cb(gpointer user_data)
 {
 	struct ofono_emulator *em =3D user_data;
+	const char *phone;
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE)
 		return TRUE;
 =

 	g_at_server_send_unsolicited(em->server, "RING");
 =

+	if (!em->clip || !em->incoming ||
+			em->incoming->clip_validity !=3D CLIP_VALIDITY_VALID)
+		return TRUE;
+
+	if (em->clip_str[0] =3D=3D '\0') {
+		phone =3D phone_number_to_string(&em->incoming->phone_number);
+		sprintf(em->clip_str, "+CLIP: \"%s\",%d", phone,
+				em->incoming->phone_number.type);
+	}
+
+	g_at_server_send_unsolicited(em->server, em->clip_str);
+
 	return TRUE;
 }
 =

@@ -403,6 +420,35 @@ fail:
 	}
 }
 =

+static void clip_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
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
+		em->clip =3D val;
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
@@ -488,6 +534,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
+		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -531,6 +578,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 	/* TODO: Check real local features */
 	em->l_features =3D 32;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
+	em->clip_str[0] =3D '\0';
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
@@ -744,9 +792,17 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 					em->ring) {
 				g_source_remove(em->ring);
 				em->ring =3D 0;
+				em->incoming =3D NULL;
+				em->clip_str[0] =3D '\0';
 			}
 		}
 =

 		return;
 	}
 }
+
+void ofono_emulator_incoming_call(struct ofono_emulator *em,
+					struct ofono_call *call)
+{
+	em->incoming =3D call;
+}
diff --git a/src/voicecall.c b/src/voicecall.c
index a3ea6de..8e68243 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -714,6 +714,13 @@ static void emulator_callheld_status_cb(struct ofono_a=
tom *atom, void *data)
 						GPOINTER_TO_INT(data));
 }
 =

+static void emulator_incoming_cb(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_incoming_call(em, data);
+}
+
 static void notify_emulator_call_status(struct ofono_voicecall *vc)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
@@ -726,6 +733,7 @@ static void notify_emulator_call_status(struct ofono_vo=
icecall *vc)
 	gboolean waiting =3D FALSE;
 	GSList *l;
 	struct voicecall *v;
+	struct ofono_call *caller =3D NULL;
 =

 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
@@ -749,10 +757,12 @@ static void notify_emulator_call_status(struct ofono_=
voicecall *vc)
 =

 		case CALL_STATUS_INCOMING:
 			incoming =3D TRUE;
+			caller =3D v->call;
 			break;
 =

 		case CALL_STATUS_WAITING:
 			waiting =3D TRUE;
+			caller =3D v->call;
 			break;
 		}
 	}
@@ -765,9 +775,12 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 						emulator_call_status_cb,
 						GINT_TO_POINTER(status));
 =

-	if (incoming || waiting)
+	if (incoming || waiting) {
 		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
-	else if (dialing)
+		__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_incoming_cb, caller);
+	} else if (dialing)
 		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
 	else if (alerting)
 		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
-- =

1.7.1


--===============6254938237353650957==--


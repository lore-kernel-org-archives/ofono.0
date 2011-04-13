Content-Type: multipart/mixed; boundary="===============5163639995855853674=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 3/6] emulator: add +CLIP support for HFP AG
Date: Wed, 13 Apr 2011 18:05:31 +0200
Message-ID: <1302710734-6103-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302710734-6103-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5163639995855853674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 9005c66..8e18785 100644
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

@@ -52,6 +53,7 @@ struct ofono_emulator {
 	gboolean events_ind;
 	GSList *indicators;
 	guint callsetup_source;
+	gboolean clip;
 };
 =

 struct indicator {
@@ -201,6 +203,47 @@ static struct indicator *find_indicator(struct ofono_e=
mulator *em,
 	return NULL;
 }
 =

+static struct ofono_call *find_call_with_status(struct ofono_emulator *em,
+								int status)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(em->atom);
+	struct ofono_atom *vc_atom;
+	struct ofono_voicecall *vc;
+
+	vc_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL);
+	if (vc_atom =3D=3D NULL)
+		return NULL;
+
+	vc =3D __ofono_atom_get_data(vc_atom);
+
+	return __ofono_voicecall_find_call_with_status(vc, status);
+}
+
+static void notify_ring(struct ofono_emulator *em)
+{
+	struct ofono_call *c;
+	const char *phone;
+	/*
+	 * '+CLIP: "+",' + phone number + phone type on 3 digits max
+	 * + terminating null
+	 */
+	char str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];
+
+	g_at_server_send_unsolicited(em->server, "RING");
+
+	if (!em->clip)
+		return;
+
+	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
+
+	if (c && c->clip_validity =3D=3D CLIP_VALIDITY_VALID) {
+		phone =3D phone_number_to_string(&c->phone_number);
+		sprintf(str, "+CLIP: \"%s\",%d", phone, c->phone_number.type);
+
+		g_at_server_send_unsolicited(em->server, str);
+	}
+}
+
 static gboolean send_callsetup_notification(gpointer user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -212,7 +255,7 @@ static gboolean send_callsetup_notification(gpointer us=
er_data)
 	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
 =

 	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
-		g_at_server_send_unsolicited(em->server, "RING");
+		notify_ring(em);
 =

 	return TRUE;
 }
@@ -427,6 +470,42 @@ fail:
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
@@ -512,6 +591,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
+		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
-- =

1.7.1


--===============5163639995855853674==--


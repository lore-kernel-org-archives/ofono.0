Content-Type: multipart/mixed; boundary="===============4272729998872923806=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] emulator: add AT+CMEE support for HFP
Date: Fri, 01 Apr 2011 16:21:33 +0200
Message-ID: <1301667693-7781-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4272729998872923806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..24897b4 100644
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

@@ -48,6 +49,7 @@ struct ofono_emulator {
 	int r_features;
 	int events_mode;
 	gboolean events_ind;
+	char cme_error_ind;
 	GSList *indicators;
 };
 =

@@ -387,6 +389,52 @@ fail:
 	}
 }
 =

+static void cmee_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+	char buf[16];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
+			goto fail;
+
+		if ((val < 0) && (val > 1))
+			goto fail;
+
+		em->cme_error_ind =3D (char)val;
+
+		sprintf(buf, "+CMEE: %d", em->cme_error_ind);
+		g_at_server_send_info(em->server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		sprintf(buf, "+CMEE: %d", em->cme_error_ind);
+		g_at_server_send_info(em->server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		/* HFP only support 0 and 1 */
+		sprintf(buf, "+CMEE: (0,1)");
+		g_at_server_send_info(em->server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
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
 					int min, int max, int dflt)
 {
@@ -462,6 +510,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
+		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -505,6 +554,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 	/* TODO: Check real local features */
 	em->l_features =3D 32;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
+	em->cme_error_ind =3D 0;	/* numeric only */
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
@@ -533,7 +583,14 @@ void ofono_emulator_send_final(struct ofono_emulator *=
em,
 		break;
 =

 	case OFONO_ERROR_TYPE_CME:
-		sprintf(buf, "+CME ERROR: %d", final->error);
+		/* default string */
+		sprintf(buf, "ERROR");
+
+		if (em->cme_error_ind =3D=3D 1)
+			sprintf(buf, "+CME ERROR: %d", final->error);
+		else if (em->cme_error_ind =3D=3D 2)
+			sprintf(buf, "+CME ERROR: %s", telephony_error_to_str(final));
+
 		g_at_server_send_ext_final(em->server, buf);
 		break;
 =

-- =

1.7.1


--===============4272729998872923806==--


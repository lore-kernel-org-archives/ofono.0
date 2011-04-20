Content-Type: multipart/mixed; boundary="===============9050473849006221115=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2] emulator: add AT+CMEE support for HFP
Date: Wed, 20 Apr 2011 13:34:55 +0200
Message-ID: <1303299295-4080-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9050473849006221115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 9b4647b..cffda21 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -51,6 +51,7 @@ struct ofono_emulator {
 	int r_features;
 	int events_mode;
 	gboolean events_ind;
+	unsigned char cme_error_ind;
 	GSList *indicators;
 	guint callsetup_source;
 	gboolean clip;
@@ -569,6 +570,52 @@ fail:
 	};
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
+		if (val < 0 && val > 1)
+			goto fail;
+
+		em->cme_error_ind =3D val;
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
@@ -656,6 +703,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
 		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
 		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
+		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -699,6 +747,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 	/* TODO: Check real local features */
 	em->l_features =3D 32;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
+	em->cme_error_ind =3D 0;	/* CME ERROR disabled by default */
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
@@ -727,7 +776,23 @@ void ofono_emulator_send_final(struct ofono_emulator *=
em,
 		break;
 =

 	case OFONO_ERROR_TYPE_CME:
-		sprintf(buf, "+CME ERROR: %d", final->error);
+		/* default string */
+		sprintf(buf, "ERROR");
+
+		switch (em->cme_error_ind) {
+		case 1:
+			sprintf(buf, "+CME ERROR: %d", final->error);
+			break;
+
+		case 2:
+			sprintf(buf, "+CME ERROR: %s",
+						telephony_error_to_str(final));
+			break;
+
+		default:
+			goto failure;
+		}
+
 		g_at_server_send_ext_final(em->server, buf);
 		break;
 =

@@ -738,6 +803,13 @@ void ofono_emulator_send_final(struct ofono_emulator *=
em,
 	case OFONO_ERROR_TYPE_CEER:
 	case OFONO_ERROR_TYPE_SIM:
 	case OFONO_ERROR_TYPE_FAILURE:
+failure:
+		if (final->error =3D=3D 30) {
+			g_at_server_send_final(em->server,
+					G_AT_SERVER_RESULT_NO_CARRIER);
+			break;
+		}
+
 		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 		break;
 	};
-- =

1.7.1


--===============9050473849006221115==--


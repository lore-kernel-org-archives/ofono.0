Content-Type: multipart/mixed; boundary="===============1227185531270392673=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7xxx: handling of sms ready state for xmm7xxx plugin
Date: Mon, 16 Dec 2019 16:07:25 +0530
Message-ID: <1576492645-1995-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1227185531270392673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+XSIM:7 state as defined in xmm7560 functional AT specification
only indicates ready for attach. PB ready and SMS ready has to be
quired seperately using +XSIMSTATE command after +XSIM:12 state
is received indicating SIM SMS Caching Completed. (Sent only when
SMS caching enabled). +XSIM:12 may or may not be received so moving
the sms ready and pb ready logic to post sim function afteR receiving
+CPIN:READY
---
 plugins/xmm7xxx.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 32c024e..f62a093 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -106,7 +106,8 @@ struct xmm7xxx_data {
 	GAtChat *chat;		/* AT chat */
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
-	ofono_bool_t sms_phonebook_added;
+	ofono_bool_t phonebook_added;
+	ofono_bool_t sms_added;
 	unsigned int netreg_watch;
 };
 =

@@ -968,6 +969,59 @@ static GAtChat *open_device(struct ofono_modem *modem,
 					NULL);
 }
 =

+static void xsimstate_sms_ready_query_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+	int sms_ready, pb_ready;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XSIMSTATE:"))
+		return;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &pb_ready))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &sms_ready))
+		return;
+
+	DBG("sms_ready=3D%d\n", sms_ready);
+
+	DBG("data->sms_added=3D%d\n", data->sms_added);
+
+	if (pb_ready && data->phonebook_added =3D=3D FALSE) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+		data->phonebook_added =3D TRUE;
+	}
+
+	if (sms_ready && data->sms_added =3D=3D FALSE) {
+		ofono_sms_create(modem, 0, "atmodem", data->chat);
+		data->sms_added =3D TRUE;
+	}
+}
+
+static void xmm7xxx_get_sms_ready_state(struct ofono_modem *modem)
+{
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+
+	g_at_chat_send(data->chat, "AT+XSIMSTATE?", xsimstate_prefix,
+		xsimstate_sms_ready_query_cb, modem, NULL);
+}
+
 static void switch_sim_state_status(struct ofono_modem *modem, int status)
 {
 	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
@@ -980,7 +1034,8 @@ static void switch_sim_state_status(struct ofono_modem=
 *modem, int status)
 		if (data->have_sim =3D=3D TRUE) {
 			ofono_sim_inserted_notify(data->sim, FALSE);
 			data->have_sim =3D FALSE;
-			data->sms_phonebook_added =3D FALSE;
+			data->phonebook_added =3D FALSE;
+			data->sms_added =3D FALSE;
 		}
 		break;
 	case 1: /* SIM inserted, PIN verification needed */
@@ -991,20 +1046,13 @@ static void switch_sim_state_status(struct ofono_mod=
em *modem, int status)
 		break;
 	case 2:	/* SIM inserted, PIN verification not needed - READY */
 	case 3:	/* SIM inserted, PIN verified - READY */
-	case 7: /* SIM inserted, SMS and phonebook - READY */
+	case 7:	/* SIM inserted, READY for ATTACH - READY */
 		if (data->have_sim =3D=3D FALSE) {
 			ofono_sim_inserted_notify(data->sim, TRUE);
 			data->have_sim =3D TRUE;
 		}
 =

 		ofono_sim_initialized_notify(data->sim);
-
-		if (data->sms_phonebook_added =3D=3D FALSE) {
-			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
-			ofono_sms_create(modem, 0, "atmodem", data->chat);
-			data->sms_phonebook_added =3D TRUE;
-		}
-
 		break;
 	default:
 		ofono_warn("Unknown SIM state %d received", status);
@@ -1083,7 +1131,8 @@ static void cfun_enable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
 =

 	data->have_sim =3D FALSE;
-	data->sms_phonebook_added =3D FALSE;
+	data->phonebook_added =3D FALSE;
+	data->sms_added =3D FALSE;
 =

 	ofono_modem_set_powered(modem, TRUE);
 =

@@ -1225,6 +1274,7 @@ static void xmm7xxx_post_sim(struct ofono_modem *mode=
m)
 {
 	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
 =

+	xmm7xxx_get_sms_ready_state(modem);
 	ofono_lte_create(modem, 0, "atmodem", data->chat);
 	ofono_radio_settings_create(modem, 0, "xmm7modem", data->chat);
 	ofono_sim_auth_create(modem);
-- =

1.9.1

--===============1227185531270392673==--


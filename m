Content-Type: multipart/mixed; boundary="===============7230624723825699540=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7xxx: modified handling of XSIM states for xmm modems
Date: Thu, 19 Dec 2019 18:26:04 +0530
Message-ID: <1576760164-30892-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7230624723825699540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+XSIM:7 state as defined in xmm7560 functional AT specification
only indicates ready for attach.

+CPIN: READY is received after SIM is completely initialized.
Also indicating readiness of Phonebook and SMS. Hence moving the
creation of SMS and Phonebook atom to xmm7xxx_post_sim function.

+XSIM:4 PUK needed state was not handled. It must be handled
same as PIN needed state. Added handling of this case to
switch_sim_state_status function.
---
 plugins/xmm7xxx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 32c024e..b3aaf85 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -106,8 +106,8 @@ struct xmm7xxx_data {
 	GAtChat *chat;		/* AT chat */
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
-	ofono_bool_t sms_phonebook_added;
 	unsigned int netreg_watch;
+	int xsim_status;
 };
 =

 /* Coex Implementation */
@@ -980,10 +980,10 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
 		if (data->have_sim =3D=3D TRUE) {
 			ofono_sim_inserted_notify(data->sim, FALSE);
 			data->have_sim =3D FALSE;
-			data->sms_phonebook_added =3D FALSE;
 		}
 		break;
 	case 1: /* SIM inserted, PIN verification needed */
+	case 4: /* SIM inserted, PUK verification needed */
 		if (data->have_sim =3D=3D FALSE) {
 			ofono_sim_inserted_notify(data->sim, TRUE);
 			data->have_sim =3D TRUE;
@@ -991,30 +991,26 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
 		break;
 	case 2:	/* SIM inserted, PIN verification not needed - READY */
 	case 3:	/* SIM inserted, PIN verified - READY */
-	case 7: /* SIM inserted, SMS and phonebook - READY */
+	case 7: /* SIM inserted, Ready for ATTACH - READY */
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
 		break;
 	}
+
+	data->xsim_status =3D status;
 }
 =

 static void xsimstate_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
 	int status;
 	GAtResultIter iter;
 =

@@ -1029,7 +1025,8 @@ static void xsimstate_notify(GAtResult *result, gpoin=
ter user_data)
 =

 	DBG("status=3D%d\n", status);
 =

-	switch_sim_state_status(modem, status);
+	if (data->xsim_status !=3D status)
+		switch_sim_state_status(modem, status);
 }
 =

 static void xsimstate_query_cb(gboolean ok, GAtResult *result,
@@ -1083,7 +1080,7 @@ static void cfun_enable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
 =

 	data->have_sim =3D FALSE;
-	data->sms_phonebook_added =3D FALSE;
+	data->xsim_status =3D -1;
 =

 	ofono_modem_set_powered(modem, TRUE);
 =

@@ -1239,6 +1236,9 @@ static void xmm7xxx_post_online(struct ofono_modem *m=
odem)
 =

 	DBG("%p", modem);
 =

+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
+
 	ofono_netreg_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_IFX, "atmodem",
-- =

1.9.1

--===============7230624723825699540==--


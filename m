Content-Type: multipart/mixed; boundary="===============6838117183399835400=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: signal sim inserted when sim ready.
Date: Tue, 18 Dec 2012 10:47:24 +0100
Message-ID: <1355824044-14361-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50CF3F28.4080301@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6838117183399835400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to wait for #QSS: 3 until SIM inserted may be signaled or
subsequent commands like +CMER will report SIM BUSY which in turn
leads to a removal of the network registration atom. This has been
observed with Telit HE910.

In case of #QSS: 1 we need to check if the SIM is locked.
If the SIM is unlocked we just wait for #QSS: 3,
if the SIM is locked we signal SIM inserted to be able to
enter a PIN code.

Since the modem firmware (at least for Telit UC864 and HE910) does only
send #QSS: 1 iff a PIN is required, we can go without an explicit PIN
check.

Move the creation of the phonebook and sms atom back to post_sim()
as we are only getting there after #QSS: 3 (SMS and phonebook ready).
---
 plugins/telit.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 79bc421..9907824 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -68,7 +68,6 @@ struct telit_data {
 	GAtChat *modem;		/* Data port */
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
-	ofono_bool_t sms_phonebook_added;
 	struct ofono_modem *sap_modem;
 	GIOChannel *bt_io;
 	GIOChannel *hw_io;
@@ -232,21 +231,30 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
 		if (data->have_sim =3D=3D TRUE) {
 			ofono_sim_inserted_notify(data->sim, FALSE);
 			data->have_sim =3D FALSE;
-			data->sms_phonebook_added =3D FALSE;
 		}
 		break;
 	case 1:	/* SIM inserted */
-	case 2:	/* SIM inserted and PIN unlocked */
+		/*
+		 * We want to call ofono_sim_inserted_notify() only if #QSS: 3
+		 * (SIM READY), as otherwise subsequent commands like +CMER may
+		 * report SIM BUSY.
+		 * In case a PIN is required, we have to signal
+		 * sim inserted on #QSS: 1 and wait in the SIM atom for #QSS: 3
+		 * after entering the PIN.
+		 * The modem will only emit #QSS: 1 if a PIN is required,
+		 * if the SIM is unlocked we get #QSS: 2 right away.
+		 */
 		if (data->have_sim =3D=3D FALSE) {
 			ofono_sim_inserted_notify(data->sim, TRUE);
 			data->have_sim =3D TRUE;
 		}
 		break;
-	case 3:	/* SIM inserted, SMS and phonebook ready */
-		if (data->sms_phonebook_added =3D=3D FALSE) {
-			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
-			ofono_sms_create(modem, 0, "atmodem", data->chat);
-			data->sms_phonebook_added =3D TRUE;
+	case 2:	/* SIM inserted and PIN unlocked */
+		break;
+	case 3:	/* SIM inserted and READY (SMS & Phonebook access possible) */
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
 		}
 		break;
 	default:
@@ -297,7 +305,6 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
 =

 	data->have_sim =3D FALSE;
-	data->sms_phonebook_added =3D FALSE;
 =

 	ofono_modem_set_powered(m, TRUE);
 =

@@ -569,6 +576,8 @@ static void telit_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============6838117183399835400==--


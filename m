Content-Type: multipart/mixed; boundary="===============5906155908135426763=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] sim: return from CPIN when SIM unlocked for telit
Date: Wed, 22 Aug 2012 16:24:05 +0200
Message-ID: <1345645446-3387-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50325AE5.8090502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5906155908135426763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only return from CPIN when the modem informs that the SIM is unlocked.
---
 drivers/atmodem/sim.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d480185..cf3345c 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1084,6 +1084,36 @@ static void at_epev_notify(GAtResult *result, gpoint=
er user_data)
 	sd->ready_id =3D 0;
 }
 =

+static void at_qss_notify(GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+	GAtResultIter iter;
+	int state;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#QSS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &state))
+		return;
+
+	switch (state) {
+	case 2:	/* PIN unlocked */
+		break;
+	default:
+		return;
+	}
+
+	cb(&error, cbd->data);
+
+	g_at_chat_unregister(sd->chat, sd->ready_id);
+	sd->ready_id =3D 0;
+}
+
 static void sim_state_cb(gboolean present, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -1133,6 +1163,16 @@ static void at_pin_send_cb(gboolean ok, GAtResult *r=
esult,
 							at_epev_notify,
 							FALSE, cbd, g_free);
 		return;
+	case OFONO_VENDOR_TELIT:
+		/*
+		 * On the Telit modem, AT+CPIN? can return READY too
+		 * early and so use #QSS notification to detect
+		 * the ready state of the SIM.
+		 */
+		sd->ready_id =3D g_at_chat_register(sd->chat, "#QSS",
+							at_qss_notify,
+							FALSE, cbd, g_free);
+		return;
 	case OFONO_VENDOR_ZTE:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============5906155908135426763==--


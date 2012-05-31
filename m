Content-Type: multipart/mixed; boundary="===============0445710110811727001=="
MIME-Version: 1.0
From: pablo@gnumonks.org
Subject: [PATCH 2/2] plugins: add support for Wavecom Q2403/Q2686 modems
Date: Thu, 31 May 2012 16:01:25 +0200
Message-ID: <1338472885-30645-3-git-send-email-pablo@gnumonks.org>
In-Reply-To: <1338472885-30645-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0445710110811727001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pablo Neira Ayuso <pablo@netfilter.org>

---
 drivers/atmodem/sim.c |    3 +++
 plugins/wavecom.c     |   21 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 603024d..7b48cd9 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1305,6 +1305,9 @@ static int at_sim_probe(struct ofono_sim *sim, unsign=
ed int vendor,
 	case OFONO_VENDOR_MBM:
 		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_WAVECOM_Q2XXX:
+		g_at_chat_add_terminator(chat, "+CPIN: READY", -1, TRUE);
+		break;
 	default:
 		break;
 	}
diff --git a/plugins/wavecom.c b/plugins/wavecom.c
index 5d30f39..f3f022c 100644
--- a/plugins/wavecom.c
+++ b/plugins/wavecom.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -134,28 +135,44 @@ static int wavecom_disable(struct ofono_modem *modem)
 static void wavecom_pre_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
+	const char *model;
+	enum ofono_vendor vendor =3D 0;
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

+	model =3D ofono_modem_get_string(modem, "Model");
+	if (model && strcmp(model, "Q2XXX") =3D=3D 0)
+		vendor =3D OFONO_VENDOR_WAVECOM_Q2XXX;
+
 	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	ofono_sim_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
+	sim =3D ofono_sim_create(modem, vendor, "atmodem", chat);
 	ofono_voicecall_create(modem, 0, "atmodem", chat);
+
+	if (vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX)
+		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void wavecom_post_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
+	const char *model;
+	enum ofono_vendor vendor =3D 0;
 =

 	DBG("%p", modem);
 =

+	model =3D ofono_modem_get_string(modem, "Model");
+	if (model && strcmp(model, "Q2XXX") =3D=3D 0)
+		vendor =3D OFONO_VENDOR_WAVECOM_Q2XXX;
+
 	ofono_ussd_create(modem, 0, "atmodem", chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
 	ofono_call_settings_create(modem, 0, "atmodem", chat);
 	ofono_netreg_create(modem, 0, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_sms_create(modem, 0, "atmodem", chat);
+	ofono_sms_create(modem, vendor, "atmodem", chat);
 	ofono_phonebook_create(modem, 0, "atmodem", chat);
 =

 	mw =3D ofono_message_waiting_create(modem);
-- =

1.7.10


--===============0445710110811727001==--


Content-Type: multipart/mixed; boundary="===============6733819394735543311=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCHv2 2/7] atmodem: Enable STE usage of AT*EPEV and AT*EPEE for
 PIN handling.
Date: Mon, 16 Aug 2010 15:54:03 +0200
Message-ID: <1281966848-14553-3-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1281966848-14553-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6733819394735543311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index eb40ad7..8e7c403 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -567,10 +567,12 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	/*
-	 * On the MBM modem, AT+CPIN? keeps returning SIM PIN for a moment
-	 * after successful AT+CPIN=3D"..", but sends *EPEV when that changes.
+	 * On the MBM and STE modem, AT+CPIN? keeps returning SIM PIN for a
+	 * moment after successful AT+CPIN=3D"..", but sends *EPEV when that
+	 * changes.
 	 */
-	if (ok && sd->vendor =3D=3D OFONO_VENDOR_MBM) {
+	if (ok && (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_STE)) {
 		sd->epev_id =3D g_at_chat_register(sd->chat, "*EPEV",
 							at_epev_notify,
 							FALSE, cbd, g_free);
@@ -817,6 +819,7 @@ static int at_sim_probe(struct ofono_sim *sim, unsigned=
 int vendor,
 	case OFONO_VENDOR_WAVECOM:
 		g_at_chat_add_terminator(sd->chat, "+CPIN:", 6, TRUE);
 		break;
+	case OFONO_VENDOR_STE:
 	case OFONO_VENDOR_MBM:
 		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
 		break;
-- =

1.6.3.3


--===============6733819394735543311==--


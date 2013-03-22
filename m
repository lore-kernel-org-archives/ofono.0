Content-Type: multipart/mixed; boundary="===============7680255232395013058=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 3/4] SIMCOM SIM card ready quirk
Date: Fri, 22 Mar 2013 11:36:17 +0100
Message-ID: <1363948578-24128-3-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1363948578-24128-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7680255232395013058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a quirk for waiting SIM availability.

SIM is busy right after pin is entered. Use the quirk which
add a CPIN? pooling check until having "CPIN: READY" answer.

diff -pruN ofono-1.12.orig/drivers/atmodem/sim.c ofono-1.12/drivers/atmodem=
/sim.c
--- ofono-1.12.orig/drivers/atmodem/sim.c	2013-01-23 11:38:22.959609087 +01=
00
+++ ofono-1.12/drivers/atmodem/sim.c	2013-01-23 11:57:52.602608948 +0100
@@ -1023,12 +1023,18 @@ static void at_pin_send_cb(gboolean ok,
 							FALSE, cbd, g_free);
 		return;
 	case OFONO_VENDOR_ZTE:
 	case OFONO_VENDOR_ALCATEL:
 	case OFONO_VENDOR_HUAWEI:
+	case OFONO_VENDOR_SIMCOM:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
 		 * notification of SIM readiness.
+		 *
+		 * On SIMCOM modems, SIM is busy after pin is entered (we've
+		 * got an "+CME ERROR: 14" at "AT+CPIN?" request) and ofono
+		 * don't catch the "+CPIN: READY" message sent by the modem
+		 * when SIM is ready. So, use extra CPIN to check the state.
 		 */
 		sd->sim_state_query =3D at_util_sim_state_query_new(sd->chat,
 						2, 20, sim_state_cb, cbd,

--===============7680255232395013058==--


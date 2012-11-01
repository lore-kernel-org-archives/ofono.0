Content-Type: multipart/mixed; boundary="===============0411201805890533025=="
MIME-Version: 1.0
From: Holger Hans Peter Freyther <holger@freyther.de>
Subject: [PATCH] sim: Fix the quirk handling of CPIN for Wavecom
Date: Thu, 01 Nov 2012 10:05:03 +0100
Message-ID: <1351760703-28090-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0411201805890533025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Holger Hans Peter Freyther <hfreyther@sysmocom.de>

The Wavecom Q2XXX support broke in commit 72ce19bf3e87b5e73c053f7ea1.
This is because at_cpin_cb called decode_at_error with final and not
with OK. This lead to an error being set in the error variable and the
new code returns early when an error is set.

The addition of the terminator in at_sim_probe for Wavecom broke in
git commit ac524be99f8c72a2593e4ffcecad8beea7679e55 because
terminators can not be added on cloned chats.

Move the addition of the terminator from the atmodem to the wavecom
plugin. Use the same terminator for Q2XXX and the normal Wavecom
class. The WAVECOM terminator has been tested on a Q2XXX modem.

Apply the CPIN quirk for both WAVECOM and WAVECOM_Q2XXX inside the
sim.c file. Introduce needs_wavecom_sim_quirk to handle it for
WAVECOM and WAVECOM_Q2XXX.
---
 drivers/atmodem/sim.c |   24 +++++++++---------------
 plugins/wavecom.c     |    2 ++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index cf3345c..ea3b180 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -967,6 +967,12 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

+static int needs_wavecom_sim_quirk(int vendor)
+{
+	return vendor =3D=3D OFONO_VENDOR_WAVECOM ||
+			vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX;
+}
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -980,7 +986,7 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	int len =3D sizeof(at_sim_name) / sizeof(*at_sim_name);
 	const char *final =3D g_at_result_final_response(result);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM && ok && strlen(final) > 7)
+	if (needs_wavecom_sim_quirk(sd->vendor) && ok && strlen(final) > 7)
 		decode_at_error(&error, "OK");
 	else
 		decode_at_error(&error, final);
@@ -990,8 +996,7 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM ||
-			sd->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX) {
+	if (needs_wavecom_sim_quirk(sd->vendor)) {
 		/* +CPIN: <pin> */
 		pin_required =3D final + 7;
 	} else {
@@ -1402,19 +1407,8 @@ static int at_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 	sd->chat =3D g_at_chat_clone(chat);
 	sd->vendor =3D vendor;
 =

-	switch (sd->vendor) {
-	case OFONO_VENDOR_WAVECOM:
-		g_at_chat_add_terminator(sd->chat, "+CPIN:", 6, TRUE);
-		break;
-	case OFONO_VENDOR_MBM:
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
 		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
-		break;
-	case OFONO_VENDOR_WAVECOM_Q2XXX:
-		g_at_chat_add_terminator(chat, "+CPIN: READY", -1, TRUE);
-		break;
-	default:
-		break;
-	}
 =

 	ofono_sim_set_data(sim, sd);
 	g_idle_add(at_sim_register, sim);
diff --git a/plugins/wavecom.c b/plugins/wavecom.c
index f3f022c..7f24eae 100644
--- a/plugins/wavecom.c
+++ b/plugins/wavecom.c
@@ -111,6 +111,8 @@ static int wavecom_enable(struct ofono_modem *modem)
 	if (chat =3D=3D NULL)
 		return -ENOMEM;
 =

+	g_at_chat_add_terminator(chat, "+CPIN:", 6, TRUE);
+
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, wavecom_debug, "");
 =

-- =

1.7.10.4


--===============0411201805890533025==--


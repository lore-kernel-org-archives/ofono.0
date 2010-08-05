Content-Type: multipart/mixed; boundary="===============0432408643165523856=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] calypso: Create STK atom and reorder initialisation.
Date: Thu, 05 Aug 2010 19:31:58 +0200
Message-ID: <1281029518-9152-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1281029518-9152-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0432408643165523856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

See comment in the code.  The Sim Toolkit apps seem to work rather
reliably with this, tested on both PIN-enabled and unprotected cards.
---
 plugins/calypso.c |   81 +++++++++++++++++++++++++++++++++++--------------=
---
 1 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index 5367684..6ef6968 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -54,6 +54,7 @@
 #include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
+#include <ofono/stk.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

@@ -86,6 +87,7 @@ struct calypso_data {
 };
 =

 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *none_prefix[] =3D { NULL };
 =

 static void calypso_debug(const char *str, void *data)
 {
@@ -197,31 +199,6 @@ static void setup_modem(struct ofono_modem *modem)
 			NULL, NULL, NULL);
 }
 =

-static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct calypso_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	if (ok =3D=3D FALSE) {
-		int i;
-
-		for (i =3D 0; i < NUM_DLC; i++) {
-			g_at_chat_unref(data->dlcs[i]);
-			data->dlcs[i] =3D NULL;
-		}
-
-		g_at_mux_shutdown(data->mux);
-		g_at_mux_unref(data->mux);
-		data->mux =3D NULL;
-	} else {
-		setup_modem(modem);
-	}
-
-	ofono_modem_set_powered(modem, ok);
-}
-
 static void simpin_check_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -232,8 +209,9 @@ static void simpin_check_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	/* Modem returns ERROR if there is no SIM in slot. */
 	data->have_sim =3D ok;
 =

-	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", NULL,
-					cfun_set_on_cb, modem, NULL);
+	setup_modem(modem);
+
+	ofono_modem_set_powered(modem, TRUE);
 }
 =

 static void init_simpin_check(struct ofono_modem *modem)
@@ -469,6 +447,55 @@ static void calypso_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_voicecall_create(modem, 0, "calypsomodem", data->dlcs[VOICE_DLC]);
 =

+	/*
+	 * The STK atom is only useful after SIM has been initialised,
+	 * so really it belongs in post_sim.  However, the order of the
+	 * following three actions is adapted to work around different
+	 * issues with the Calypso's firmware in its different versions
+	 * (may have been fixed starting at some version, but this order
+	 * should work with any version).
+	 *
+	 * To deal with PIN-enabled and PIN-disabled SIM cards, the order
+	 * needs to be as follows:
+	 *
+	 * AT%SATC=3D"..."
+	 * ...
+	 * AT+CFUN=3D1
+	 * ...
+	 * AT+CPIN=3D"..."
+	 *
+	 * %SATC comes before the other two actions because it provides
+	 * the Terminal Profile data to the modem, which will be used
+	 * during the Profile Download either during +CFUN=3D1 (on
+	 * unprotected cards) or +CPIN=3D"..." (on protected cards).
+	 * The STK atom needs to be present at this time because the
+	 * card may start issuing proactive commands immediately after
+	 * the Download.
+	 *
+	 * +CFUN=3D1 appears before PIN entry because switching from +CFUN
+	 * mode 0 later, on the Calypso has side effects at least on some
+	 * versions of the firmware:
+	 *
+	 * mode 0 -> 1 transition forces PIN re-authentication.
+	 * mode 0 -> 4 doesn't work at all.
+	 * mode 1 -> 4 and
+	 * mode 4 -> 1 transitions work and have no side effects.
+	 *
+	 * So in order to switch to Offline mode at startup,
+	 * AT+CFUN=3D1;+CFUN=3D4 would be needed.
+	 *
+	 * Additionally AT+CFUN=3D1 response is not checked: on PIN-enabled
+	 * cards, it will in most situations return "+CME ERROR: SIM PIN
+	 * required" (CME ERROR 11) even though the switch to mode 1
+	 * succeeds.  It will not perform Profile Download on those cards
+	 * though, until another +CPIN command.
+	 */
+	if (data->have_sim && sim)
+		ofono_stk_create(modem, 0, "calypsomodem", data->dlcs[AUX_DLC]);
+
+	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D1",
+			none_prefix, NULL, NULL, NULL);
+
 	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
-- =

1.7.1.86.g0e460.dirty


--===============0432408643165523856==--


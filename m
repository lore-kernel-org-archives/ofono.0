Content-Type: multipart/mixed; boundary="===============2052002988649610903=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] calypso: Subscribe to %SIMREM, %SIMINS notifications.
Date: Tue, 17 Aug 2010 17:37:01 +0200
Message-ID: <1282059423-28864-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1282059423-28864-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2052002988649610903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These notifications should be emitted on SIM removal and insertion.
These notifications don't work very well though, on the hardware this
has been tested on, the modem never issued %SIMINS, and %SIMREM was
emitted only in some specific circumenstances.
---
 plugins/calypso.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index 6ef6968..a2d4ec8 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -84,6 +84,7 @@ struct calypso_data {
 	gboolean phonebook_added;
 	gboolean sms_added;
 	gboolean have_sim;
+	struct ofono_sim *sim;
 };
 =

 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
@@ -170,6 +171,23 @@ static void cstat_notify(GAtResult *result, gpointer u=
ser_data)
 	}
 }
 =

+static void simind_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct calypso_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+
+	if (!data->sim)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "%SIMREM:"))
+		ofono_sim_inserted_notify(data->sim, FALSE);
+	else if (g_at_result_iter_next(&iter, "%SIMINS:"))
+		ofono_sim_inserted_notify(data->sim, TRUE);
+}
+
 static void setup_modem(struct ofono_modem *modem)
 {
 	struct calypso_data *data =3D ofono_modem_get_data(modem);
@@ -197,6 +215,14 @@ static void setup_modem(struct ofono_modem *modem)
 	/* Disable deep sleep */
 	g_at_chat_send(data->dlcs[SETUP_DLC], "AT%SLEEP=3D2", NULL,
 			NULL, NULL, NULL);
+
+	/* Enable SIM removed/inserted notifications */
+	g_at_chat_register(data->dlcs[SETUP_DLC], "%SIMREM:", simind_notify,
+				FALSE, modem, NULL);
+	g_at_chat_register(data->dlcs[SETUP_DLC], "%SIMINS:", simind_notify,
+				FALSE, modem, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT%SIMIND=3D1", NULL,
+				NULL, NULL, NULL);
 }
 =

 static void simpin_check_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -439,12 +465,11 @@ static int calypso_disable(struct ofono_modem *modem)
 static void calypso_pre_sim(struct ofono_modem *modem)
 {
 	struct calypso_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("");
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
+	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_voicecall_create(modem, 0, "calypsomodem", data->dlcs[VOICE_DLC]);
 =

 	/*
@@ -490,14 +515,14 @@ static void calypso_pre_sim(struct ofono_modem *modem)
 	 * succeeds.  It will not perform Profile Download on those cards
 	 * though, until another +CPIN command.
 	 */
-	if (data->have_sim && sim)
+	if (data->have_sim && data->sim)
 		ofono_stk_create(modem, 0, "calypsomodem", data->dlcs[AUX_DLC]);
 =

 	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D1",
 			none_prefix, NULL, NULL, NULL);
 =

-	if (data->have_sim && sim)
-		ofono_sim_inserted_notify(sim, TRUE);
+	if (data->have_sim && data->sim)
+		ofono_sim_inserted_notify(data->sim, TRUE);
 }
 =

 static void calypso_post_sim(struct ofono_modem *modem)
-- =

1.7.1.86.g0e460.dirty


--===============2052002988649610903==--


Content-Type: multipart/mixed; boundary="===============7372573894838503508=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] calypso: Check if SIM is present on modem startup.
Date: Thu, 05 Aug 2010 19:30:53 +0200
Message-ID: <1281029457-9048-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1281029457-9048-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7372573894838503508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Like in case of MBM modem, the SIM slot is not easily accessible
while the device is running so we assume there's no need to check
for SIM presence after startup.
---
 plugins/calypso.c |   36 +++++++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index 60f3242..7798e10 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -82,8 +82,11 @@ struct calypso_data {
 	enum powercycle_state state;
 	gboolean phonebook_added;
 	gboolean sms_added;
+	gboolean have_sim;
 };
 =

+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+
 static void calypso_debug(const char *str, void *data)
 {
 	guint dlc =3D GPOINTER_TO_UINT(data);
@@ -217,6 +220,34 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	ofono_modem_set_powered(modem, ok);
 }
 =

+static void simpin_check_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct calypso_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* Modem returns ERROR if there is no SIM in slot. */
+	data->have_sim =3D ok;
+
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", NULL,
+					cfun_set_on_cb, modem, NULL);
+}
+
+static void init_simpin_check(struct ofono_modem *modem)
+{
+	struct calypso_data *data =3D ofono_modem_get_data(modem);
+
+	/*
+	 * Check for SIM presence by seeing if AT+CPIN? succeeds.
+	 * The SIM can not be practically inserted/removed without
+	 * restarting the device so there's no need to check more
+	 * than once.
+	 */
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CPIN?", cpin_prefix,
+			simpin_check_cb, modem, NULL);
+}
+
 static void mux_setup(GAtMux *mux, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -254,8 +285,7 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
 		g_at_chat_set_wakeup_command(data->dlcs[i], "AT\r", 500, 5000);
 	}
 =

-	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", NULL,
-					cfun_set_on_cb, modem, NULL);
+	init_simpin_check(modem);
 }
 =

 static void modem_initialize(struct ofono_modem *modem)
@@ -437,7 +467,7 @@ static void calypso_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
 	ofono_voicecall_create(modem, 0, "calypsomodem", data->dlcs[VOICE_DLC]);
 =

-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============7372573894838503508==--


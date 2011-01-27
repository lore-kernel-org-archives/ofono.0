Content-Type: multipart/mixed; boundary="===============7590541133491058741=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH v6] ifx: Adding modem selftest for Infineon modem
Date: Wed, 26 Jan 2011 16:08:04 -0800
Message-ID: <1296086884-14687-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7590541133491058741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Infineon modem selftest, during ifx_enable().
Two steps trigger, with timeout. In case one
fails, modem will not power up.

---
 plugins/ifx.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 0d31167..39f38ab 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -72,6 +72,8 @@
 #define GPRS3_DLC   4
 #define AUX_DLC     5
 =

+#define IFX_SETUP_TIMEOUT	10
+
 static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
 					"GPRS2: ", "GPRS3: ", "Aux: " };
 =

@@ -89,7 +91,7 @@ struct ifx_data {
 	guint dlc_poll_count;
 	guint dlc_poll_source;
 	guint dlc_init_source;
-	guint mux_init_timeout;
+	guint cmd_setup_timeout;
 	guint frame_size;
 	int mux_ldisc;
 	int saved_ldisc;
@@ -100,6 +102,9 @@ struct ifx_data {
 	int audio_loopback;
 	struct ofono_sim *sim;
 	gboolean have_sim;
+	gboolean rtc_gti_selftest_timeout;
+	gboolean dev_ver_selftest_timeout;
+	gboolean mux_setup_timeout;
 };
 =

 static void ifx_debug(const char *str, void *user_data)
@@ -475,9 +480,9 @@ static void mux_setup_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	DBG("");
 =

-	if (data->mux_init_timeout > 0) {
-		g_source_remove(data->mux_init_timeout);
-		data->mux_init_timeout =3D 0;
+	if (data->cmd_setup_timeout > 0) {
+		g_source_remove(data->cmd_setup_timeout);
+		data->cmd_setup_timeout =3D 0;
 	}
 =

 	g_at_chat_unref(data->dlcs[AUX_DLC]);
@@ -519,26 +524,88 @@ error:
 	ofono_modem_set_powered(modem, FALSE);
 }
 =

-static gboolean mux_timeout_cb(gpointer user_data)
+static gboolean cmd_setup_timeout_cb(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_error("Timeout with multiplexer setup");
+	if (data->rtc_gti_selftest_timeout)
+		ofono_error("ERROR:IFX Selftest"
+			"at(a)rtc:rtc_gti_test_verify_32khz()-TIMEOUT");
+	else if (data->dev_ver_selftest_timeout)
+		ofono_error("ERROR:IFX Selftest"
+			"at(a)vers:device_version_id()-TIMEOUT");
+	else if (data->mux_setup_timeout)
+		ofono_error("ERROR:IFX Mux setup-TIMEOUT");
 =

-	data->mux_init_timeout =3D 0;
+	data->cmd_setup_timeout =3D 0;
 =

-	g_at_chat_unref(data->dlcs[AUX_DLC]);
-	data->dlcs[AUX_DLC] =3D NULL;
+	if (data->dlcs[AUX_DLC]) {
+		g_at_chat_unref(data->dlcs[AUX_DLC]);
+		data->dlcs[AUX_DLC] =3D NULL;
+	}
 =

-	g_io_channel_unref(data->device);
-	data->device =3D NULL;
+	if (data->device) {
+		g_io_channel_unref(data->device);
+		data->device =3D NULL;
+	}
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

 	return FALSE;
 }
 =

+static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	data->dev_ver_selftest_timeout =3D FALSE;
+
+	if (!ok) {
+		ofono_error("ERROR:IFX Selftest at(a)vers:device_version_id()"
+			"-FAILED");
+
+		if (data->dlcs[AUX_DLC]) {
+			g_at_chat_unref(data->dlcs[AUX_DLC]);
+			data->dlcs[AUX_DLC] =3D NULL;
+		}
+
+		if (data->device) {
+			g_io_channel_unref(data->device);
+			data->device =3D NULL;
+		}
+
+		ofono_modem_set_powered(modem, FALSE);
+	}
+}
+
+static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	data->rtc_gti_selftest_timeout =3D FALSE;
+
+	if (!ok) {
+		ofono_error("ERROR:IFX Selftest"
+			"at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
+
+		if (data->dlcs[AUX_DLC]) {
+			g_at_chat_unref(data->dlcs[AUX_DLC]);
+			data->dlcs[AUX_DLC] =3D NULL;
+		}
+
+		if (data->device) {
+			g_io_channel_unref(data->device);
+			data->device =3D NULL;
+		}
+
+		ofono_modem_set_powered(modem, FALSE);
+	}
+}
 static int ifx_enable(struct ofono_modem *modem)
 {
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
@@ -592,16 +659,27 @@ static int ifx_enable(struct ofono_modem *modem)
 	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
 					NULL, NULL, NULL);
 =

-	data->frame_size =3D 1509;
+	/* Execute Modem Self tests */
+	data->dlcs[AUX_DLC] =3D chat;
 =

-	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
-					mux_setup_cb, modem, NULL);
+	g_at_chat_send(data->dlcs[AUX_DLC],
+		"at(a)rtc:rtc_gti_test_verify_32khz()",
+		NULL, rtc_gti_selftest_cb, modem, NULL);
+	data->rtc_gti_selftest_timeout =3D TRUE;
 =

-	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
-								modem);
+	g_at_chat_send(data->dlcs[AUX_DLC], "at(a)vers:device_version_id()",
+		NULL, dev_ver_selftest_cb, modem, NULL);
+	data->dev_ver_selftest_timeout =3D TRUE;
 =

-	data->dlcs[AUX_DLC] =3D chat;
+	/* Enable  MUX Channels */
+	data->frame_size =3D 1509;
+	g_at_chat_send(data->dlcs[AUX_DLC],
+			"AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
+			mux_setup_cb, modem, NULL);
+	data->mux_setup_timeout =3D TRUE;
 =

+	data->cmd_setup_timeout =3D g_timeout_add_seconds(
+		IFX_SETUP_TIMEOUT, cmd_setup_timeout_cb, modem);
 	return -EINPROGRESS;
 }
 =

-- =

1.7.0.4


--===============7590541133491058741==--


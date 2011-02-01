Content-Type: multipart/mixed; boundary="===============0095927734390214611=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH v7] ifx: Adding modem selftest for Infineon modem
Date: Mon, 31 Jan 2011 19:49:51 -0800
Message-ID: <1296532191-22449-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0095927734390214611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Infineon modem selftest, during ifx_enable().
Two steps trigger, with timeout. In case one
fails, modem will not power up.

---
 plugins/ifx.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 411c012..da8ed0b 100644
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

@@ -524,10 +526,12 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_error("Timeout with multiplexer setup");
+	ofono_error("Timeout with AT command setup");
 =

 	data->mux_init_timeout =3D 0;
 =

+	g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
+
 	g_at_chat_unref(data->dlcs[AUX_DLC]);
 	data->dlcs[AUX_DLC] =3D NULL;
 =

@@ -539,6 +543,35 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 =

+static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		ofono_error("ERROR:IFX Selftest at(a)vers:device_version_id()"
+				"-FAILED");
+
+		g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
+	}
+}
+
+static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
+			gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		ofono_error("ERROR:IFX Selftest"
+			"at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
+
+		g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
+	}
+}
+
 static int ifx_enable(struct ofono_modem *modem)
 {
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
@@ -592,13 +625,24 @@ static int ifx_enable(struct ofono_modem *modem)
 	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
 					NULL, NULL, NULL);
 =

+	/* Execute Modem Self tests */
+	data->dlcs[AUX_DLC] =3D chat;
+
+	g_at_chat_send(data->dlcs[AUX_DLC],
+		"at(a)rtc:rtc_gti_test_verify_32khz()",
+		NULL, rtc_gti_selftest_cb, modem, NULL);
+
+	g_at_chat_send(data->dlcs[AUX_DLC], "at(a)vers:device_version_id()",
+		NULL, dev_ver_selftest_cb, modem, NULL);
+
+	/* Enable  MUX Channels */
 	data->frame_size =3D 1509;
 =

 	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
 					mux_setup_cb, modem, NULL);
 =

-	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
-								modem);
+	data->mux_init_timeout =3D g_timeout_add_seconds(
+		IFX_SETUP_TIMEOUT, mux_timeout_cb, modem);
 =

 	data->dlcs[AUX_DLC] =3D chat;
 =

-- =

1.7.1


--===============0095927734390214611==--


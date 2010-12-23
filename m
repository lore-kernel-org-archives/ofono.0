Content-Type: multipart/mixed; boundary="===============3603600200092610473=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH v3] ifx: Adding modem selftest for Infineon modem
Date: Thu, 23 Dec 2010 14:47:07 -0800
Message-ID: <1293144427-12296-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3603600200092610473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This is another attempt to submit a patch that triggers Infineon
modem selftest during ofono boot. Patch addresses issues raised
by Marcel from the previous submissions.

Thank you,
-- r.

---
 plugins/ifx.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index c0a69c2..e0eb982 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -71,6 +71,8 @@
 #define GPRS3_DLC   4
 #define AUX_DLC     5
 =

+#define IFX_SELF_TESTS_TIMEOUT	10
+
 static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
 					"GPRS2: ", "GPRS3: ", "Aux: " };
 =

@@ -81,6 +83,16 @@ static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM=
1", "/dev/ttyGSM2",
 static const char *none_prefix[] =3D { NULL };
 static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
 =

+static struct {
+	char *test_desc;
+	char *at_cmd;
+} const mst[] =3D {
+	{ "AT Command Test", "ATE0 +CMEE=3D1" }, /* set echo & error reporting */
+	{ "RTC GTI Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
+	{ "Device Version Test", "at(a)vers:device_version_id()" },
+	{ NULL, NULL }
+};
+
 struct ifx_data {
 	GIOChannel *device;
 	GAtMux *mux;
@@ -99,6 +111,7 @@ struct ifx_data {
 	int audio_loopback;
 	struct ofono_sim *sim;
 	gboolean have_sim;
+	int self_test_idx;
 };
 =

 static void ifx_debug(const char *str, void *user_data)
@@ -545,6 +558,52 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 =

+static void ifx_self_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->mux_init_timeout > 0) {
+		g_source_remove(data->mux_init_timeout);
+		data->mux_init_timeout =3D 0;
+	}
+
+	if (!ok) {
+		ofono_error("Modem %s: FAIL",
+			mst[data->self_test_idx].test_desc);
+		g_at_chat_unref(data->dlcs[AUX_DLC]);
+		data->dlcs[AUX_DLC] =3D NULL;
+
+		g_io_channel_unref(data->device);
+		data->device =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+
+		return;
+	}
+
+	data->self_test_idx++;
+
+	if (mst[data->self_test_idx].at_cmd !=3D NULL) {
+		g_at_chat_send(data->dlcs[AUX_DLC],
+			mst[data->self_test_idx].at_cmd,
+			NULL, ifx_self_test_cb, modem, NULL);
+
+		data->mux_init_timeout =3D g_timeout_add_seconds(
+			IFX_SELF_TESTS_TIMEOUT, mux_timeout_cb, modem);
+
+	} else {	/* Enable  MUX Channels */
+		data->frame_size =3D 1509;
+		g_at_chat_send(data->dlcs[AUX_DLC],
+				"AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
+				mux_setup_cb, modem, NULL);
+
+		data->mux_init_timeout =3D g_timeout_add_seconds(5,
+				mux_timeout_cb,	modem);
+	}
+}
+
 static int ifx_enable(struct ofono_modem *modem)
 {
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
@@ -595,18 +654,15 @@ static int ifx_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, ifx_debug, "Master: ");
 =

-	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
-					NULL, NULL, NULL);
-
-	data->frame_size =3D 1509;
-
-	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
-					mux_setup_cb, modem, NULL);
+	/* Execute Modem Self tests */
+	data->dlcs[AUX_DLC] =3D chat;
+	data->self_test_idx =3D 0;
 =

-	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
-								modem);
+	g_at_chat_send(data->dlcs[AUX_DLC], mst[data->self_test_idx].at_cmd,
+		NULL, ifx_self_test_cb, modem, NULL);
 =

-	data->dlcs[AUX_DLC] =3D chat;
+	data->mux_init_timeout =3D g_timeout_add_seconds(
+		IFX_SELF_TESTS_TIMEOUT, mux_timeout_cb,	modem);
 =

 	return -EINPROGRESS;
 }
-- =

1.7.0.4


--===============3603600200092610473==--


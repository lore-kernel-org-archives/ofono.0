Content-Type: multipart/mixed; boundary="===============0560679768022834384=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH v2] ifx: Adding modem selftest to Infineon modem
Date: Fri, 17 Dec 2010 17:51:59 -0800
Message-ID: <1292637119-9288-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0560679768022834384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This is a second attempt to submit a patch that triggers Infineon
modem selftest during ofono boot. Patch addresses issues raised
by Marcel from the previous submission.

Thank you,
-- r.


---
 plugins/ifx.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 2f4c65b..3647dbc 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -71,6 +71,8 @@
 #define GPRS3_DLC   4
 #define AUX_DLC     5
 =

+#define IFX_SELF_TESTS_TIMEOUT	5
+
 static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
 					"GPRS2: ", "GPRS3: ", "Aux: " };
 =

@@ -80,6 +82,18 @@ static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM=
1", "/dev/ttyGSM2",
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
+static const char *empty_prefix[] =3D { "", NULL };
+
+struct ifx_self_tests {
+	char *test_desc;
+	char *at_cmd;
+};
+
+static const struct ifx_self_tests mst[] =3D {
+		{ "RTC GTI Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
+		{ "Device Version Test", "at(a)vers:device_version_id()" },
+		{ NULL, NULL }
+};
 =

 struct ifx_data {
 	GIOChannel *device;
@@ -99,6 +113,8 @@ struct ifx_data {
 	int audio_loopback;
 	struct ofono_sim *sim;
 	gboolean have_sim;
+	guint self_test_timeout;
+	int self_test_idx;
 };
 =

 static void ifx_debug(const char *str, void *user_data)
@@ -545,6 +561,64 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 =

+static gboolean self_test_timeout_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_error("Modem %s: TIMED OUT",
+			mst[data->self_test_idx].test_desc);
+
+	g_source_remove(data->self_test_timeout);
+	data->self_test_timeout =3D 0;
+
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+
+	return FALSE;
+}
+
+static void ifx_self_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->self_test_timeout > 0) {
+		g_source_remove(data->self_test_timeout);
+		data->self_test_timeout =3D 0;
+	}
+
+	if (!ok) {
+		ofono_error("Modem %s: FAIL",
+			mst[data->self_test_idx].test_desc);
+		shutdown_device(data);
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
+			empty_prefix, ifx_self_test_cb, modem, NULL);
+
+		data->self_test_timeout =3D g_timeout_add_seconds(
+			IFX_SELF_TESTS_TIMEOUT, self_test_timeout_cb, modem);
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
@@ -598,15 +672,16 @@ static int ifx_enable(struct ofono_modem *modem)
 	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
 					NULL, NULL, NULL);
 =

-	data->frame_size =3D 1509;
+	/* Execute Modem Self tests */
 =

-	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
-					mux_setup_cb, modem, NULL);
+	data->dlcs[AUX_DLC] =3D chat;
+	data->self_test_idx =3D 0;
 =

-	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
-								modem);
+	g_at_chat_send(data->dlcs[AUX_DLC], mst[data->self_test_idx].at_cmd,
+		empty_prefix, ifx_self_test_cb, modem, NULL);
 =

-	data->dlcs[AUX_DLC] =3D chat;
+	data->self_test_timeout =3D g_timeout_add_seconds(IFX_SELF_TESTS_TIMEOUT,
+				self_test_timeout_cb,	modem);
 =

 	return -EINPROGRESS;
 }
-- =

1.7.0.4


--===============0560679768022834384==--


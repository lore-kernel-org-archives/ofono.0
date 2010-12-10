Content-Type: multipart/mixed; boundary="===============5064555558227232308=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH] ifx: adding Infineon modem self test
Date: Fri, 10 Dec 2010 02:26:44 -0800
Message-ID: <1291976804-8739-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5064555558227232308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Adding Infineon modem selftest to the plugin. It executes couple of AT
commands, and based on the responses,  it continues with ifx modem
enabling or powers the modem down.

Thanks,
-- r.

---
 plugins/ifx.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
---
 1 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 2f4c65b..fcc57c0 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -80,6 +80,12 @@ static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM=
1", "/dev/ttyGSM2",
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
+static const char *empty_prefix[] =3D { "", NULL };
+
+static const char *modem_self_tests[][2] =3D {
+			{ "RTC Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
+			{ "Version Info Test", "at(a)vers:device_version_id()" },
+			{ NULL, NULL } };
 =

 struct ifx_data {
 	GIOChannel *device;
@@ -99,6 +105,8 @@ struct ifx_data {
 	int audio_loopback;
 	struct ofono_sim *sim;
 	gboolean have_sim;
+	guint self_test_timeout;
+	int self_test_idx;
 };
 =

 static void ifx_debug(const char *str, void *user_data)
@@ -545,6 +553,82 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 =

+static gboolean self_test_timeout_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_error("Timeout with modem self_test");
+	g_source_remove(data->self_test_timeout);
+	data->self_test_timeout =3D 0;
+
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+	return FALSE;
+}
+
+static void ifx_self_test_get_device_resp(GAtResult *result, int test_id)
+{
+	GAtResultIter iter;
+	const char *str;
+
+	ofono_info("Modem Response: %s",
+				modem_self_tests[test_id][0]);
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, NULL)) {
+
+		if (g_at_result_iter_next_string(&iter, &str))
+			ofono_info("Modem Response: %s", str);
+	}
+}
+
+static void ifx_self_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (ok) {
+
+		if (data->self_test_timeout > 0) {
+			g_source_remove(data->self_test_timeout);
+			data->self_test_timeout =3D 0;
+		}
+
+		ifx_self_test_get_device_resp(result, data->self_test_idx);
+		data->self_test_idx++;
+
+		if (modem_self_tests[data->self_test_idx][1] !=3D NULL) {
+
+			g_at_chat_send(data->dlcs[AUX_DLC],
+				modem_self_tests[data->self_test_idx][1],
+				empty_prefix, ifx_self_test_cb, modem, NULL);
+
+			data->self_test_timeout =3D g_timeout_add_seconds(10,
+					self_test_timeout_cb, modem);
+			return;
+
+		} else {
+
+			/* Enable  MUX Channels */
+			data->frame_size =3D 1509;
+			g_at_chat_send(data->dlcs[AUX_DLC],
+					"AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
+					mux_setup_cb, modem, NULL);
+
+			data->mux_init_timeout =3D g_timeout_add_seconds(5,
+					mux_timeout_cb,	modem);
+			return;
+		}
+	}
+
+	ofono_error("Modem %s: FAIL", modem_self_tests[data->self_test_idx][0]);
+	shutdown_device(data);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static int ifx_enable(struct ofono_modem *modem)
 {
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
@@ -598,15 +682,17 @@ static int ifx_enable(struct ofono_modem *modem)
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
+	g_at_chat_send(data->dlcs[AUX_DLC],
+		modem_self_tests[data->self_test_idx][1],
+		empty_prefix, ifx_self_test_cb, modem, NULL);
 =

-	data->dlcs[AUX_DLC] =3D chat;
+	data->self_test_timeout =3D g_timeout_add_seconds(10,
+				self_test_timeout_cb,	modem);
 =

 	return -EINPROGRESS;
 }
-- =

1.7.0.4


--===============5064555558227232308==--


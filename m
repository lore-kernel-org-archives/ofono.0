Content-Type: multipart/mixed; boundary="===============6424708388705268005=="
MIME-Version: 1.0
From: anandx.ramakrishna@intel.com
Subject: [PATCH v10] ifx: Adding modem selftest for Infineon modem
Date: Mon, 07 Feb 2011 13:25:05 -0800
Message-ID: <1297113905-3061-1-git-send-email-anandx.ramakrishna@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6424708388705268005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anand Ramakrishna <anandx.ramakrishna@intel.com>

Infineon modem selftest, during ifx_enable().
Two steps trigger, with timeout. In case one fails, modem will not power up

---
 plugins/ifx.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 411c012..fce055d 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -524,7 +524,7 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_error("Timeout with multiplexer setup");
+	ofono_error("Timeout with modem and multiplexer setup");
 =

 	data->mux_init_timeout =3D 0;
 =

@@ -539,6 +539,56 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 =

+static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (ok)
+		return;
+
+	ofono_error("at(a)vers:device_version_id()-FAILED");
+
+	if (data->mux_init_timeout > 0) {
+		g_source_remove(data->mux_init_timeout);
+		data->mux_init_timeout =3D 0;
+	}
+
+	g_at_chat_unref(data->dlcs[AUX_DLC]);
+	data->dlcs[AUX_DLC] =3D NULL;
+
+	g_io_channel_unref(data->device);
+	data->device =3D NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct ifx_data *data =3D ofono_modem_get_data(modem);
+
+	if (ok)
+		return;
+
+	ofono_error("at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
+
+	if (data->mux_init_timeout > 0) {
+		g_source_remove(data->mux_init_timeout);
+		data->mux_init_timeout =3D 0;
+	}
+
+	g_at_chat_unref(data->dlcs[AUX_DLC]);
+	data->dlcs[AUX_DLC] =3D NULL;
+
+	g_io_channel_unref(data->device);
+	data->device =3D NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static int ifx_enable(struct ofono_modem *modem)
 {
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
@@ -592,12 +642,24 @@ static int ifx_enable(struct ofono_modem *modem)
 	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
 					NULL, NULL, NULL);
 =

+	/* Execute modem self tests */
+	g_at_chat_send(chat, "at(a)rtc:rtc_gti_test_verify_32khz()",
+		NULL, rtc_gti_selftest_cb, modem, NULL);
+
+	g_at_chat_send(chat, "at(a)vers:device_version_id()",
+		NULL, dev_ver_selftest_cb, modem, NULL);
+
+	/* Enable multiplexer */
 	data->frame_size =3D 1509;
 =

 	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
 					mux_setup_cb, modem, NULL);
 =

-	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
+	/*
+	 * Total self test execution ... 2 seconds. Use
+	 * 10 seconds timeout to cover self tests and multiplexer setup.
+	 */
+	data->mux_init_timeout =3D g_timeout_add_seconds(10, mux_timeout_cb,
 								modem);
 =

 	data->dlcs[AUX_DLC] =3D chat;
-- =

1.7.2.3


--===============6424708388705268005==--


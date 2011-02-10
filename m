Content-Type: multipart/mixed; boundary="===============2027403134789912800=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] ifx: Remove modem selftest
Date: Thu, 10 Feb 2011 17:59:30 +0200
Message-ID: <1297353570-9453-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2027403134789912800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Command used for self test is not working for all
versions of the modem firmware.
---
 plugins/ifx.c |   65 +----------------------------------------------------=
---
 1 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index a41fc36..527a8c4 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -524,7 +524,7 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_error("Timeout with modem or multiplexer setup");
+	ofono_error("Timeout with multiplexer setup");
 =

 	data->mux_init_timeout =3D 0;
 =

@@ -539,56 +539,6 @@ static gboolean mux_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 =

-static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct ifx_data *data =3D ofono_modem_get_data(modem);
-
-	if (ok)
-		return;
-
-	ofono_error("at(a)vers:device_version_id()-FAILED");
-
-	if (data->mux_init_timeout > 0) {
-		g_source_remove(data->mux_init_timeout);
-		data->mux_init_timeout =3D 0;
-	}
-
-	g_at_chat_unref(data->dlcs[AUX_DLC]);
-	data->dlcs[AUX_DLC] =3D NULL;
-
-	g_io_channel_unref(data->device);
-	data->device =3D NULL;
-
-	ofono_modem_set_powered(modem, FALSE);
-}
-
-static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct ifx_data *data =3D ofono_modem_get_data(modem);
-
-	if (ok)
-		return;
-
-	ofono_error("at(a)rtc_drv:rtc_gti_test_verify_32khz()-FAILED");
-
-	if (data->mux_init_timeout > 0) {
-		g_source_remove(data->mux_init_timeout);
-		data->mux_init_timeout =3D 0;
-	}
-
-	g_at_chat_unref(data->dlcs[AUX_DLC]);
-	data->dlcs[AUX_DLC] =3D NULL;
-
-	g_io_channel_unref(data->device);
-	data->device =3D NULL;
-
-	ofono_modem_set_powered(modem, FALSE);
-}
-
 static int ifx_enable(struct ofono_modem *modem)
 {
 	struct ifx_data *data =3D ofono_modem_get_data(modem);
@@ -642,24 +592,13 @@ static int ifx_enable(struct ofono_modem *modem)
 	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
 					NULL, NULL, NULL);
 =

-	/* Execute modem self tests */
-	g_at_chat_send(chat, "at(a)rtc_drv:rtc_gti_test_verify_32khz()", NULL,
-					rtc_gti_selftest_cb, modem, NULL);
-
-	g_at_chat_send(chat, "at(a)vers:device_version_id()", NULL,
-					dev_ver_selftest_cb, modem, NULL);
-
 	/* Enable multiplexer */
 	data->frame_size =3D 1509;
 =

 	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
 					mux_setup_cb, modem, NULL);
 =

-	/*
-	 * Total self test execution time is around 2 seconds. Use
-	 * 10 seconds timeout to cover self tests and multiplexer setup.
-	 */
-	data->mux_init_timeout =3D g_timeout_add_seconds(10, mux_timeout_cb,
+	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
 								modem);
 =

 	data->dlcs[AUX_DLC] =3D chat;
-- =

1.7.0.4


--===============2027403134789912800==--


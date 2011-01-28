Content-Type: multipart/mixed; boundary="===============0322534114938558101=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/5] huaweimodem: add NULL check
Date: Fri, 28 Jan 2011 03:50:06 -0800
Message-ID: <1296215408-4946-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296215408-4946-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0322534114938558101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/radio-settings.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 68112fe..c850e33 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -182,11 +182,13 @@ static void huawei_query_rat_mode(struct ofono_radio_=
settings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
-				syscfg_query_mode_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, -1, data);
-		g_free(cbd);
-	}
+	if (cbd && g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
+				syscfg_query_mode_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static void syscfg_modify_mode_cb(gboolean ok, GAtResult *result,
@@ -210,6 +212,9 @@ static void huawei_set_rat_mode(struct ofono_radio_sett=
ings *rs,
 	char buf[40];
 	unsigned int value =3D 2, acq_order =3D 0;
 =

+	if (cbd =3D=3D NULL)
+		goto error;
+
 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
 		value =3D 2;
@@ -261,6 +266,9 @@ static void huawei_set_band(struct ofono_radio_settings=
 *rs,
 	char buf[40];
 	unsigned int huawei_band;
 =

+	if (cbd =3D=3D NULL)
+		goto error;
+
 	if (band_gsm =3D=3D OFONO_RADIO_BAND_GSM_ANY
 			&& band_umts =3D=3D OFONO_RADIO_BAND_UMTS_ANY) {
 		huawei_band =3D HUAWEI_BAND_ANY;
@@ -344,11 +352,13 @@ static void huawei_query_band(struct ofono_radio_sett=
ings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
-				syscfg_query_band_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, -1, -1, data);
-		g_free(cbd);
-	}
+	if (cbd && g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
+				syscfg_query_band_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
 }
 =

 static void syscfg_support_cb(gboolean ok, GAtResult *result,
-- =

1.7.0.4


--===============0322534114938558101==--


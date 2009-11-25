Content-Type: multipart/mixed; boundary="===============6872489534051015721=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Fix: Move CHLD from voicecall driver to plugin
Date: Wed, 25 Nov 2009 13:48:43 +0800
Message-ID: <1259128123-19161-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6872489534051015721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The second patch is to move CHLD=3D? from voicecall.c to plugin.

According HFP v1.5 spec, AT+CHLD=3D? should be a part of SLC
connection. So we should not do it after SLC connection is
created.
---
 drivers/hfpmodem/hfpmodem.h  |    9 ++++++
 drivers/hfpmodem/voicecall.c |   55 +-----------------------------------
 plugins/hfp.c                |   64 ++++++++++++++++++++++++++++++++++++++=
+--
 3 files changed, 70 insertions(+), 58 deletions(-)

diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index c0e4c7e..1935cb2 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -42,6 +42,14 @@
 #define HF_FEATURE_ENHANCED_CALL_STATUS 0x20
 #define HF_FEATURE_ENHANCED_CALL_CONTROL 0x40
 =

+#define AG_CHLD_0 0x01
+#define AG_CHLD_1 0x02
+#define AG_CHLD_1x 0x04
+#define AG_CHLD_2 0x08
+#define AG_CHLD_2x 0x10
+#define AG_CHLD_3 0x20
+#define AG_CHLD_4 0x40
+
 enum hfp_indicator {
 	HFP_INDICATOR_SERVICE =3D 0,
 	HFP_INDICATOR_CALL,
@@ -56,6 +64,7 @@ enum hfp_indicator {
 struct hfp_data {
 	GAtChat *chat;
 	unsigned int ag_features;
+	unsigned int ag_mpty_features;
 	unsigned int hf_features;
 	unsigned char cind_pos[HFP_INDICATOR_LAST];
 	unsigned int cind_val[HFP_INDICATOR_LAST];
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 52cdfd7..2cd14b5 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -39,16 +39,7 @@
 =

 #include "hfpmodem.h"
 =

-#define AG_CHLD_0 0x01
-#define AG_CHLD_1 0x02
-#define AG_CHLD_1x 0x04
-#define AG_CHLD_2 0x08
-#define AG_CHLD_2x 0x10
-#define AG_CHLD_3 0x20
-#define AG_CHLD_4 0x40
-
 static const char *none_prefix[] =3D { NULL };
-static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 static const char *clcc_prefix[] =3D { "+CLCC:", NULL };
 =

 struct voicecall_data {
@@ -900,47 +891,6 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 		ciev_callheld_notify(vc, value);
 }
 =

-static void chld_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct voicecall_data *vd =3D user_data;
-	unsigned int ag_mpty_feature =3D 0;
-	GAtResultIter iter;
-	const char *str;
-
-	if (!ok)
-		return;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CHLD:"))
-		return;
-
-	if (!g_at_result_iter_open_list(&iter))
-		return;
-
-	while (g_at_result_iter_next_unquoted_string(&iter, &str)) {
-		if (!strcmp(str, "0"))
-			ag_mpty_feature |=3D AG_CHLD_0;
-		else if (!strcmp(str, "1"))
-			ag_mpty_feature |=3D AG_CHLD_1;
-		else if (!strcmp(str, "1x"))
-			ag_mpty_feature |=3D AG_CHLD_1x;
-		else if (!strcmp(str, "2"))
-			ag_mpty_feature |=3D AG_CHLD_2;
-		else if (!strcmp(str, "2x"))
-			ag_mpty_feature |=3D AG_CHLD_2x;
-		else if (!strcmp(str, "3"))
-			ag_mpty_feature |=3D AG_CHLD_3;
-		else if (!strcmp(str, "4"))
-			ag_mpty_feature |=3D AG_CHLD_4;
-	}
-
-	if (!g_at_result_iter_close_list(&iter))
-		return;
-
-	vd->ag_mpty_features =3D ag_mpty_feature;
-}
-
 static void hfp_voicecall_initialized(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -970,14 +920,11 @@ static int hfp_voicecall_probe(struct ofono_voicecall=
 *vc, unsigned int vendor,
 =

 	vd->chat =3D data->chat;
 	vd->ag_features =3D data->ag_features;
+	vd->ag_mpty_features =3D data->ag_mpty_features;
 =

 	memcpy(vd->cind_pos, data->cind_pos, HFP_INDICATOR_LAST);
 	memcpy(vd->cind_val, data->cind_val, HFP_INDICATOR_LAST);
 =

-	if (vd->ag_features & AG_FEATURE_3WAY)
-		g_at_chat_send(vd->chat, "AT+CHLD=3D?", chld_prefix,
-			chld_cb, vd, NULL);
-
 	ofono_voicecall_set_data(vc, vd);
 =

 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 6e630e8..b56abdb 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -55,6 +55,7 @@
 static const char *brsf_prefix[] =3D { "+BRSF:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
+static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

 static int hfp_disable(struct ofono_modem *modem);
 =

@@ -63,6 +64,60 @@ static void hfp_debug(const char *str, void *user_data)
 	ofono_info("%s", str);
 }
 =

+static void sevice_level_conn_established(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_info("Service level connection established");
+	ofono_modem_set_powered(modem, TRUE);
+
+	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
+}
+
+static void chld_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	unsigned int ag_mpty_feature =3D 0;
+	GAtResultIter iter;
+	const char *str;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CHLD:"))
+		return;
+
+	if (!g_at_result_iter_open_list(&iter))
+		return;
+
+	while (g_at_result_iter_next_unquoted_string(&iter, &str)) {
+		if (!strcmp(str, "0"))
+			ag_mpty_feature |=3D AG_CHLD_0;
+		else if (!strcmp(str, "1"))
+			ag_mpty_feature |=3D AG_CHLD_1;
+		else if (!strcmp(str, "1x"))
+			ag_mpty_feature |=3D AG_CHLD_1x;
+		else if (!strcmp(str, "2"))
+			ag_mpty_feature |=3D AG_CHLD_2;
+		else if (!strcmp(str, "2x"))
+			ag_mpty_feature |=3D AG_CHLD_2x;
+		else if (!strcmp(str, "3"))
+			ag_mpty_feature |=3D AG_CHLD_3;
+		else if (!strcmp(str, "4"))
+			ag_mpty_feature |=3D AG_CHLD_4;
+	}
+
+	if (!g_at_result_iter_close_list(&iter))
+		return;
+
+	data->ag_mpty_features =3D ag_mpty_feature;
+
+	sevice_level_conn_established(modem);
+}
+
 static void cmer_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -73,10 +128,11 @@ static void cmer_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 		return;
 	}
 =

-	ofono_info("Service level connection established");
-	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
-
-	ofono_modem_set_powered(modem, TRUE);
+	if (data->ag_features & AG_FEATURE_3WAY)
+		g_at_chat_send(data->chat, "AT+CHLD=3D?", chld_prefix,
+			chld_cb, modem, NULL);
+	else
+		sevice_level_conn_established(modem);
 }
 =

 static void cind_status_cb(gboolean ok, GAtResult *result,
-- =

1.6.2.5


--===============6872489534051015721==--


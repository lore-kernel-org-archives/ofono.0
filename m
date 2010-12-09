Content-Type: multipart/mixed; boundary="===============8795495818374060187=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/6] huaweimodem: cache mode in radio settings
Date: Thu, 09 Dec 2010 14:43:38 -0200
Message-ID: <1291913020-3103-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291913020-3103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8795495818374060187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Save the current and pending modes in radio_settings_data, so we can
access them later. This patch also splits the parsing of ^SYSCFG
response from the callback call. Then, it's possible to have more
properties that use the same command as is the case of frequency band
selection.
---
 drivers/huaweimodem/radio-settings.c |   68 ++++++++++++++++++++++--------=
----
 1 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 30961da..38c0f3d 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -45,53 +45,64 @@ static const char *syscfg_prefix[] =3D { "^SYSCFG:", NU=
LL };
 =

 struct radio_settings_data {
 	GAtChat *chat;
+	enum ofono_radio_access_mode mode;
+	struct {
+		enum ofono_radio_access_mode mode;
+	} pending;
 };
 =

-static void syscfg_query_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+static ofono_bool_t syscfg_query_parse(struct radio_settings_data *rsd,
+					GAtResult *result)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
-	enum ofono_radio_access_mode mode;
-	struct ofono_error error;
 	GAtResultIter iter;
 	int value;
 =

-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (!ok) {
-		cb(&error, -1, cbd->data);
-		return;
-	}
-
 	g_at_result_iter_init(&iter, result);
 =

 	if (g_at_result_iter_next(&iter, "^SYSCFG:") =3D=3D FALSE)
-		goto error;
+		return FALSE;
 =

 	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
-		goto error;
+		return FALSE;
 =

 	switch (value) {
 	case 2:
-		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		rsd->mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
 		break;
 	case 13:
-		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		rsd->mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
 		break;
 	case 14:
-		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		rsd->mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
 		break;
 	default:
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
+		return FALSE;
 	}
 =

-	cb(&error, mode, cbd->data);
+	return TRUE;
+}
+
+static void huawei_query_rat_mode_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	struct radio_settings_data *rsd =3D cbd->user;
+	struct ofono_error error;
 =

-	return;
+	decode_at_error(&error, g_at_result_final_response(result));
 =

-error:
-	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	if (!syscfg_query_parse(rsd, result)) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, rsd->mode, cbd->data);
 }
 =

 static void huawei_query_rat_mode(struct ofono_radio_settings *rs,
@@ -100,8 +111,10 @@ static void huawei_query_rat_mode(struct ofono_radio_s=
ettings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

+	cbd->user =3D rsd;
+
 	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
-					syscfg_query_cb, cbd, g_free) =3D=3D 0) {
+				huawei_query_rat_mode_cb, cbd, g_free) =3D=3D 0) {
 		CALLBACK_WITH_FAILURE(cb, -1, data);
 		g_free(cbd);
 	}
@@ -111,8 +124,12 @@ static void syscfg_modify_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+	struct radio_settings_data *rsd =3D cbd->user;
 	struct ofono_error error;
 =

+	if (ok)
+		rsd->mode =3D rsd->pending.mode;
+
 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
@@ -147,6 +164,9 @@ static void huawei_set_rat_mode(struct ofono_radio_sett=
ings *rs,
 	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,3FFFFFFF,2,4",
 			value, acq_order);
 =

+	rsd->pending.mode =3D mode;
+	cbd->user =3D rsd;
+
 	if (g_at_chat_send(rsd->chat, buf, none_prefix,
 					syscfg_modify_cb, cbd, g_free) > 0)
 		return;
-- =

1.7.3.3


--===============8795495818374060187==--


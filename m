Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BA19BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="FkPedDuR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=8F1/RyOmrJgp1XocG1DSJS57vv0IN0OU6F0AGTnZKQM=; t=1697528147; x=1697618147; 
	b=FkPedDuRlvcPgXfQl/g+35ZCcRmcj2gPIce3HD30ueTn+iGWm52VJldvx8urewiQHfBv2+CrHEF
	OBzodgwYKBBFo5yNDf22eMkar74ObCXaexVZ/qElht5EQHrEG9Wf6a9Asg6I0LTH+u2rDGNZxpb59
	46OFa+N/ybi5mY+7gvw=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsecB-004oe4-0Y; Tue, 17 Oct 2023 10:35:44 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 14/18] gemalto: radio-settings: Add support EHS5-E
Date: Tue, 17 Oct 2023 12:33:38 +0500
Message-Id: <20231017073342.673160-14-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
References: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F538085040D79C45066D967C3FD20578184EC6D248C413D885244ABA0E2B9F392F8213AFB2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A9D436FF183A167CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637279A5203CF71F5518638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80839FD26D8DB0AB5404B012EF6AF6F65117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3733B5EC72352B9FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FCB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA92D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C34ECBDE8281F904F976E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C224905968FE12AFC105AE827F84554CEF50127C277FBC8AE2E8BF1175FABE1C0F9B6AAAE862A0553A39223F8577A6DFFEA7C90B2CA22E117843D43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5A331DE3898E66B7ADC415D92B1A1BB050E89AB873ECBA7F8F87CCE6106E1FC07E67D4AC08A07B9B0F254576263B31EA99C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF0B00BBF8AFA2D2AB04E0A6C47C76CC203D366A9D9FD99C99DBB05BA01BD773410F85117B495E935BEBFDF7752E1FC337CC0F5185A6FE311B23CDDC5D6936C3A240B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJDqHX41BMrzfg==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9D4DA4058ED4EF9F5C64BA6A2DABABD9387B00FF961393D865D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 drivers/gemaltomodem/radio-settings.c | 233 ++++++++++++++++++--------
 1 file changed, 162 insertions(+), 71 deletions(-)

diff --git a/drivers/gemaltomodem/radio-settings.c b/drivers/gemaltomodem/radio-settings.c
index d711658d..ff7218a1 100644
--- a/drivers/gemaltomodem/radio-settings.c
+++ b/drivers/gemaltomodem/radio-settings.c
@@ -40,6 +40,9 @@
 #include "gatchat.h"
 #include "gatresult.h"
 
+#include "gemaltomodem.h"
+#include "models.h"
+
 static const char *none_prefix[] = { NULL };
 static const char *sxrat_prefix[] = { "^SXRAT:", NULL };
 
@@ -47,13 +50,32 @@ struct radio_settings_data {
 	GAtChat *chat;
 };
 
+static void gemalto_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data) {
+	unsigned int available_rats;
+	struct ofono_modem *modem = ofono_radio_settings_get_modem(rs);
+	const char *model = ofono_modem_get_string(modem, "Model");
+
+	available_rats = OFONO_RADIO_ACCESS_MODE_GSM
+				| OFONO_RADIO_ACCESS_MODE_UMTS;
+
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
+		!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
+		available_rats |= OFONO_RADIO_ACCESS_MODE_LTE;
+
+	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
+}
+
 static void sxrat_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd = user_data;
 	ofono_radio_settings_rat_mode_query_cb_t cb = cbd->cb;
+	struct ofono_radio_settings *rs = cbd->data;
+	struct ofono_modem *modem = ofono_radio_settings_get_modem(rs);
+	const char *model = ofono_modem_get_string(modem, "Model");
 	unsigned int mode;
 	struct ofono_error error;
-	int value, pref1, pref2;
 	GAtResultIter iter;
 
 	DBG("ok %d", ok);
@@ -70,42 +92,76 @@ static void sxrat_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	if (!g_at_result_iter_next(&iter, "^SXRAT:"))
 		goto error;
 
-	if (!g_at_result_iter_next_number(&iter, &value))
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
+		!g_strcmp0(model, GEMALTO_MODEL_ELS81x)) {
+		int value, pref1, pref2;
+		
+		if (!g_at_result_iter_next_number(&iter, &value))
+			goto error;
+		
+		g_at_result_iter_next_number_default(&iter, -1, &pref1);
+		g_at_result_iter_next_number_default(&iter, -1, &pref2);
+
+		DBG("mode %d pref1 %d pref2 %d", value, pref1, pref2);
+
+		switch (value) {
+		case 0:
+			mode = OFONO_RADIO_ACCESS_MODE_GSM;
+			break;
+		case 1:
+			mode = OFONO_RADIO_ACCESS_MODE_GSM |
+				OFONO_RADIO_ACCESS_MODE_UMTS;
+			break;
+		case 2:
+			mode = OFONO_RADIO_ACCESS_MODE_UMTS;
+			break;
+		case 3:
+			mode = OFONO_RADIO_ACCESS_MODE_LTE;
+			break;
+		case 4:
+			mode = OFONO_RADIO_ACCESS_MODE_UMTS |
+				OFONO_RADIO_ACCESS_MODE_LTE;
+			break;
+		case 5:
+			mode = OFONO_RADIO_ACCESS_MODE_GSM |
+				OFONO_RADIO_ACCESS_MODE_LTE;
+			break;
+		case 6:
+			mode = OFONO_RADIO_ACCESS_MODE_ANY;
+			break;
+		default:
+			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+			return;
+		}
+	}
+	else if (!g_strcmp0(model, GEMALTO_MODEL_EHS5_E)) {
+		int act, act_pref;
+		
+		if (!g_at_result_iter_next_number(&iter, &act))
+			goto error;
+		
+		g_at_result_iter_next_number_default(&iter, -1, &act_pref);
+		
+		DBG("act %d act_pref %d", act, act_pref);
+		
+		switch (act) {
+		case 0:
+			mode = OFONO_RADIO_ACCESS_MODE_GSM;
+			break;
+		case 1:
+			mode = OFONO_RADIO_ACCESS_MODE_GSM |
+				OFONO_RADIO_ACCESS_MODE_UMTS;
+			break;
+		case 2:
+			mode = OFONO_RADIO_ACCESS_MODE_UMTS;
+			break;
+		default:
+			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+			return;
+		}
+	}
+	else {
 		goto error;
-
-	g_at_result_iter_next_number_default(&iter, -1, &pref1);
-	g_at_result_iter_next_number_default(&iter, -1, &pref2);
-
-	DBG("mode %d pref1 %d pref2 %d", value, pref1, pref2);
-
-	switch (value) {
-	case 0:
-		mode = OFONO_RADIO_ACCESS_MODE_GSM;
-		break;
-	case 1:
-		mode = OFONO_RADIO_ACCESS_MODE_GSM |
-			OFONO_RADIO_ACCESS_MODE_UMTS;
-		break;
-	case 2:
-		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
-		break;
-	case 3:
-		mode = OFONO_RADIO_ACCESS_MODE_LTE;
-		break;
-	case 4:
-		mode = OFONO_RADIO_ACCESS_MODE_UMTS |
-			OFONO_RADIO_ACCESS_MODE_LTE;
-		break;
-	case 5:
-		mode = OFONO_RADIO_ACCESS_MODE_GSM |
-			OFONO_RADIO_ACCESS_MODE_LTE;
-		break;
-	case 6:
-		mode = OFONO_RADIO_ACCESS_MODE_ANY;
-		break;
-	default:
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
 	}
 
 	cb(&error, mode, cbd->data);
@@ -151,51 +207,85 @@ static void gemalto_set_rat_mode(struct ofono_radio_settings *rs,
 {
 	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd = cb_data_new(cb, data);
-	int val= 6, p1 = 3, p2 = 2;
+	struct ofono_modem *modem = ofono_radio_settings_get_modem(rs);
+	const char *model = ofono_modem_get_string(modem, "Model");
 	char buf[20];
 
 	DBG("mode %d", m);
 
-	switch (m) {
-	case OFONO_RADIO_ACCESS_MODE_ANY:
-		val = 6;
-		p1 = 3;
-		p2 = 2;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_GSM:
-		val = 0;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_UMTS:
-		val = 2;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_LTE:
-		val = 3;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM:
-		val = 1;
-		p1 = 2;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS:
-		val = 4;
-		p1 = 3;
-		break;
-	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
-		val = 5;
-		p1 = 3;
-		break;
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
+		!g_strcmp0(model, GEMALTO_MODEL_ELS81x)) {
+		int val= 6, p1 = 3, p2 = 2;
+		switch (m) {
+		case OFONO_RADIO_ACCESS_MODE_ANY:
+			val = 6;
+			p1 = 3;
+			p2 = 2;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_GSM:
+			val = 0;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_UMTS:
+			val = 2;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_LTE:
+			val = 3;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM:
+			val = 1;
+			p1 = 2;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS:
+			val = 4;
+			p1 = 3;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
+			val = 5;
+			p1 = 3;
+			break;
+		}
+
+		if (val == 6)
+			snprintf(buf, sizeof(buf), "AT^SXRAT=%u,%u,%u", val, p1, p2);
+		else if (val == 1 || val == 4 || val == 5)
+			snprintf(buf, sizeof(buf), "AT^SXRAT=%u,%u", val, p1);
+		else
+			snprintf(buf, sizeof(buf), "AT^SXRAT=%u", val);
+	}
+	else if (!g_strcmp0(model, GEMALTO_MODEL_EHS5_E)) {
+		int act = 1, act_pref = 2;
+		switch (m) {
+		case OFONO_RADIO_ACCESS_MODE_ANY:
+		case OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM:
+			act = 1;
+			act_pref = 2;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_GSM:
+			act = 0;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_UMTS:
+			act = 2;
+			break;
+		case OFONO_RADIO_ACCESS_MODE_LTE:
+		case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS:
+		case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
+			goto error;
+		}
+
+		if (act == 1)
+			snprintf(buf, sizeof(buf), "AT^SXRAT=%u,%u", act, act_pref);
+		else
+			snprintf(buf, sizeof(buf), "AT^SXRAT=%u", act);
+	}
+	else {
+		goto error;
 	}
-
-	if (val == 6)
-		snprintf(buf, sizeof(buf), "AT^SXRAT=%u,%u,%u", val, p1, p2);
-	else if (val == 1 || val == 4 || val == 5)
-		snprintf(buf, sizeof(buf), "AT^SXRAT=%u,%u", val, p1);
-	else
-		snprintf(buf, sizeof(buf), "AT^SXRAT=%u", val);
 
 	if (g_at_chat_send(rsd->chat, buf, none_prefix,
 				sxrat_modify_cb, cbd, g_free) > 0)
 		return;
 
+error:
 	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
 }
@@ -248,6 +338,7 @@ static void gemalto_radio_settings_remove(struct ofono_radio_settings *rs)
 static const struct ofono_radio_settings_driver driver = {
 	.probe			= gemalto_radio_settings_probe,
 	.remove			= gemalto_radio_settings_remove,
+	.query_available_rats = gemalto_query_available_rats,
 	.query_rat_mode		= gemalto_query_rat_mode,
 	.set_rat_mode		= gemalto_set_rat_mode
 };
-- 
2.25.1


Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBC1945F
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="kiArhqEQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=uI2vspsxSymfZBNT7KXvbRK3vqGmeS1ktR6q9DHA4kc=; t=1697528089; x=1697618089; 
	b=kiArhqEQNtMRqnmAM/J+fObJUbluw0W7JdPgR4ARvHfEhv3Lo/erHNAJdB2uqv1s4ErDCBef/A0
	ya7PAUlTQKKUW8ODEBwhRR11j8kSvJD4jh0pCChQDBJtQFPv3ieDJqxtGluQD7RP9P39YUjV0OoFF
	FgtumwSTvK4drfYVU0s=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebF-004oe4-1f; Tue, 17 Oct 2023 10:34:46 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 02/18] drivers: adding support for the SIMCom A7605E-H
Date: Tue, 17 Oct 2023 12:33:26 +0500
Message-Id: <20231017073342.673160-2-m.lyubimov@aqsi.ru>
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
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9A0C7FD9243F13F0AB97817F7407E9626288CEC90671C4148182A05F5380850404C228DA9ACA6FE275A0EF837DDE7890ABAEBF38A988C6B0C67731239EB448C86F7FAC471D6385156
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE707314F92EEE30EB3EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D3219148F76DED538638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B93C38DAEF994DD9AB3B81FA20265505117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC1A9C11735BBA05FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520140C956E756FBB7AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCF7CD7A0D5AA5F256E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C39B48D55734A730D4BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF887A4342A344B6ED1DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE764C02688FEF668DD731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A547606AAB65327C09DC415D92B1A1BB05C6615A230ED7E0A6F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFDE3AF5E2BDC611DDAFBC368F39AA53095F9F30D716067F45081A000FFC82987BFA89AC6828CC4048EBFDF7752E1FC337BD65D18436ED93DBAD2B3E3F4605B1DB40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJDiDP0PmH+3JA==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9D1A17F57629E8A2EC64BA6A2DABABD935CC11B3213E880DE5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

The features of the SIMCom A7605E-H modem are taken into account in the atmodem driver
---
 drivers/atmodem/gprs.c | 60 +++++++++++++++++++++++++++++++++++++++++-
 drivers/atmodem/sim.c  |  7 ++---
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 8c352ba6..a52bf2f1 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -41,6 +41,8 @@
 #include "gatchat.h"
 #include "gatresult.h"
 
+#include "atmodem.h"
+#include "common.h"
 #include "vendor.h"
 
 #define MAX_CONTEXTS 255
@@ -544,6 +546,54 @@ static void telit_mode_notify(GAtResult *result, gpointer user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 
+static void simcom_mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	GAtResultIter iter;
+	gint stat, bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CNSMOD:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter,&stat))
+		return;
+
+	switch (stat) {
+	case 0:
+		bearer = PACKET_BEARER_NONE;
+		break;
+	case 1:
+	case 2:
+		bearer = PACKET_BEARER_GPRS;
+		break;
+	case 3:
+		bearer = PACKET_BEARER_EGPRS;
+		break;
+	case 4:
+		bearer = PACKET_BEARER_UMTS;
+		break;
+	case 5:
+		bearer = PACKET_BEARER_HSDPA;
+		break;
+	case 6:
+		bearer = PACKET_BEARER_HSUPA;
+		break;
+	case 7:
+		bearer = PACKET_BEARER_HSUPA_HSDPA;
+		break;
+	case 8:
+		bearer = PACKET_BEARER_EPS;
+		break;
+	default:
+		bearer = PACKET_BEARER_NONE;
+		break;
+	}
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
 static void ublox_ureg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs = user_data;
@@ -626,6 +676,12 @@ static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_SIMCOM:
+		g_at_chat_register(gd->chat, "+CNSMOD:", simcom_mode_notify,
+						FALSE, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT+CNSMOD=1", none_prefix,
+						NULL, NULL, NULL);
+		break;
 	case OFONO_VENDOR_QUECTEL_EC2X:
 	case OFONO_VENDOR_QUECTEL_SERIAL:
 		break;
@@ -749,7 +805,9 @@ retry:
 		goto error;
 
 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(gd->chat, "AT+CGAUTO=0", none_prefix, NULL, NULL, NULL);
+	if (gd->vendor != OFONO_VENDOR_SIMCOM) {
+		g_at_chat_send(gd->chat, "AT+CGAUTO=0", none_prefix, NULL, NULL, NULL);
+	}
 
 	switch (gd->vendor) {
 	case OFONO_VENDOR_MBM:
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 3cb8c7bd..8849a129 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1642,9 +1642,10 @@ static void at_discover_apps(struct ofono_sim *sim,
 	struct sim_data *sd = ofono_sim_get_data(sim);
 	struct cb_data *cbd;
 
-	/* QUECTEL EC2X reboots when executing the AT+CUAD command with SIM cards
-	of some operators */
-	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X)
+	/* QUECTEL EC2X and SIMCom A7605E-H reboots when executing the AT+CUAD
+	command with SIM cards of some operators */
+	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X
+			|| sd->vendor == OFONO_VENDOR_SIMCOM)
 		goto error;
 
 	cbd = cb_data_new(cb, data);
-- 
2.25.1


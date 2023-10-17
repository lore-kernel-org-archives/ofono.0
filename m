Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BB19BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="QCCQ3Dy0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Z5nY7Dpk7iRhPgRfnc7ChZrhFpgHYeb7GRlPlTy4pg4=; t=1697528154; x=1697618154; 
	b=QCCQ3Dy0mAjr0ppve32h/+r0g9cS0kmr9KI2Bews9of+9YMOuiCNKYzvYD489s9b6EJJ2ak8+MM
	POC/wCrQPucCiArnOZvnN6bwoU54X3VjPhVTGV97XXMcFao7QwnbQfLqMa1k8m5C+iKJIoCmTTIpu
	Uq/8thJKISubQKVBYlQ=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsecJ-004oe4-0M; Tue, 17 Oct 2023 10:35:51 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 16/18] atmodem: added context deactivation event handling
Date: Tue, 17 Oct 2023 12:33:40 +0500
Message-Id: <20231017073342.673160-16-m.lyubimov@aqsi.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF8220711250C2C7F14874E241AD7DC2F9182A05F538085040AFE05A242E995E80D20578184EC6D2487C975523D1FF8A7E31EB9E3BEF7068F1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063750965CC5CDB672DE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87E2DACC2CEDD42F8143313A30E481B89117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3733B5EC72352B9FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6089696B24BB1D1903F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3F5D93BA78F69AFFFBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFC24E78AA85F86F6C1DD303D21008E298D5E8D9A59859A8B64854413538E1713F75ECD9A6C639B01B78DA827A17800CE7D707FD082A5DC212731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5353B051DD4BBA005DC415D92B1A1BB05EAF0B08A1BD6E2FEF87CCE6106E1FC07E67D4AC08A07B9B00A6B3CD6EB70C818C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6DEEB881D8F6CA1FA2E7F461F8636F94F088C18E8FA1FC587C546914A3D84FAFE4A5F4FEF661E8B5EBFDF7752E1FC337E1FAA81D078FA3D3A8874295D14BE6ED40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBvNSwTYx1fiQ==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9A643915182F49A53C64BA6A2DABABD93876E38531A9214E95D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 drivers/atmodem/gprs-context.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 1954c6c6..d92b6392 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -359,9 +359,12 @@ static void cgev_notify(GAtResult *result, gpointer user_data)
 	struct ofono_gprs_context *gc = user_data;
 	struct gprs_context_data *gcd = ofono_gprs_context_get_data(gc);
 	const char *event;
-	int cid;
+	unsigned int cid;
+	int r;
 	GAtResultIter iter;
 
+	DBG("");
+
 	g_at_result_iter_init(&iter, result);
 
 	if (!g_at_result_iter_next(&iter, "+CGEV:"))
@@ -370,18 +373,23 @@ static void cgev_notify(GAtResult *result, gpointer user_data)
 	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
 		return;
 
-	if (g_str_has_prefix(event, "NW DEACT") == FALSE)
-		return;
-
-	if (!g_at_result_iter_skip_next(&iter))
+	if (g_str_has_prefix(event, "NW PDN DEACT"))
+		r = sscanf(event, "%*s %*s %*s %u", &cid);
+	else if (g_str_has_prefix(event, "ME PDN DEACT"))
+		r = sscanf(event, "%*s %*s %*s %u", &cid);
+	else if (g_str_has_prefix(event, "NW DEACT"))
+		r = sscanf(event, "%*s %*s %u", &cid);
+	else if (g_str_has_prefix(event, "ME DEACT"))
+		r = sscanf(event, "%*s %*s %u", &cid);
+	else
 		return;
 
-	if (!g_at_result_iter_next_number(&iter, &cid))
+	if (r != 1)
 		return;
 
-	DBG("cid %d", cid);
+	DBG("cid %u", cid);
 
-	if ((unsigned int) cid != gcd->active_context)
+	if (cid != gcd->active_context)
 		return;
 
 	if (gcd->state != STATE_IDLE && gcd->ppp)
-- 
2.25.1


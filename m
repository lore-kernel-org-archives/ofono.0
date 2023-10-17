Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78B3D39F
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="1u+vMJkP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Z5nY7Dpk7iRhPgRfnc7ChZrhFpgHYeb7GRlPlTy4pg4=; t=1697539803; x=1697629803; 
	b=1u+vMJkPZjEgSU/BJU4oE+eDLbzeHkE+cRtE45xOLFF6zihEhllfHDcfqcWOWSnrtayuTuzc2kn
	OBn8cTqW96IyO1euNlVTTEadA+aXy/F0yfbGpCzWkQlmkqK8Apa/a3rBrGNCDAZurrnc0Qsix3zTB
	amcz5HGQNS3efgh0dWo=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsheC-00Ab9o-0r; Tue, 17 Oct 2023 13:50:00 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 13/15] atmodem: added context deactivation event handling
Date: Tue, 17 Oct 2023 15:49:00 +0500
Message-Id: <20231017104902.717947-13-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFE07483E69DEB83AAA9CF49F7F8BEEC4C182A05F53808504036C4057FE4712059C2C183DA722F6B6548B874EB63F559899F7D8BF1CBD0CF1F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D99F96657F58F1038638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88A3824037324A0DD8D63F79A4B1B91F8117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3733B5EC72352B9FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18E5D25F19253116ADD2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE26055571C92BF10FC0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3A7AC412AE061D85076E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22492AA437DA6D0FD557E827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7CA0A09DF0321F028C43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5210892E79577673665C29474C6E1BB28A409599D8793179EF87CCE6106E1FC07E67D4AC08A07B9B00A6B3CD6EB70C818C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE473C6BC94463AF5AEC89687A735C2BD9E7591C6D5C036598139C42441BD71FDDDCE95BB4BF576A6EBFDF7752E1FC3374C7AB374286F43D1F5E65B6714E3666240B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBDuTlBiBw7hg==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF7467A86E7DFED0932ADA0702D06D9705497C6685C364A8575145D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
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


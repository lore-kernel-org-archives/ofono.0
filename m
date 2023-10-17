Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A941A93
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="mmUMXdlO";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="RvkVtrZt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=WCV9EdBoxBIAj2yL9v44IQFt0a0N/9pfKquMxMzGSp8=;
	t=1697541758;x=1697631758; 
	b=mmUMXdlOLd+Vu6Enf7o4muI0J9pJIbNmlh5J4bZbkRP4y1X0zwvdgaW19iAS/ZHUzMTGeklMcTfSVSs1ol4mmNNKEwq1MJ/nk4eXlwBBJt7TejzWlM0SN5MViA0AGlA62Z1HtEpPFfBYLX2Q/J4jmuKlFvlEmIvE6s3IV2ejzRA=;
Received: from [10.12.4.13] (port=39144 helo=smtp38.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshdg-0039Lt-RU
	for ofono@lists.linux.dev; Tue, 17 Oct 2023 13:49:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=WCV9EdBoxBIAj2yL9v44IQFt0a0N/9pfKquMxMzGSp8=; t=1697539768; x=1697629768; 
	b=RvkVtrZtkR6Jh0QxyzPJZqZlnxF1CPdJkPl26INoLwlTQd1w6tn1bsOMXgNp81MXqQjejmX4eb0
	P/YynsB3NFUjxc77mEx0NhBxlzpnz5h/1Ji4eVUqF+qu1cD6aZI0uP5LvIH/tteJBLAjGu6My9I6d
	olxEcimAsxNBr9jjRdU=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshdY-00Ab9o-0B; Tue, 17 Oct 2023 13:49:20 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: Sergei Golubtsov <sg@aqsi.ru>
Subject: [PATCH 01/15] Skipping AT+CUAD sending for QUECTEL_EC2X vendor
Date: Tue, 17 Oct 2023 15:48:48 +0500
Message-Id: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF12F77ADD25EC5C96C9983EE241B65B69182A05F5380850402B86D50557F97785C2C183DA722F6B6503CEC2E3A043EC39A94F7EF34EF64EED
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BF27F4FA2823CCF0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637ECAF4C2CEE0D0B2F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C83C55DE5E4163DDFA16ABA5FB3E3CD5117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCEA77C8EAE1CE44B0A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE4B6963042765DA4B3D5BA627BF9F2FCFD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE368E4D7E803FA7AD503F1AB874ED89028C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CFE4D9CDE3FF759CF2E808ACE2090B5E1725E5C173C3A84C3ED8438A78DFE0A9E089D37D7C0E48F6C8AA50765F7900637DE56B42BBC93F2A0EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5811BA3D61167465665C29474C6E1BB28891F63FD86D96750F87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227B9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF0105004CC973E407C4DAD2FF51575F4A25F96F4F304D73F196E908F028371D183B77A83432DF81E4EBFDF7752E1FC3370071BF2D7D916EE9719E69A0C3F9F51140B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCEw5HkjcpuFQ==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746B65C8B5B6C56C579A0702D06D9705497AF2C50DC7E177C325D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DEDBBC46D76EB2520ED4F58DABF9B6959C78F57D1C82F16B049FFFDB7839CE9E80FBBB2CB63C9CB5A049993DDE21652A3A11C08CC50AEC59B87F4A2C6D7CDD90
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdVi+mls5yutpZq1JCwkzeTg==
X-Mailru-MI: C000000000000800
X-Mras: Ok

From: Sergei Golubtsov <sg@aqsi.ru>

This workarounds bug in EC200A firmware which leads to modem
reset in case of usage of some SIM cards when sending the next
command
---
 drivers/atmodem/sim.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 67fe21e3..3cb8c7bd 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1640,7 +1640,14 @@ static void at_discover_apps(struct ofono_sim *sim,
 				void *data)
 {
 	struct sim_data *sd = ofono_sim_get_data(sim);
-	struct cb_data *cbd = cb_data_new(cb, data);
+	struct cb_data *cbd;
+
+	/* QUECTEL EC2X reboots when executing the AT+CUAD command with SIM cards
+	of some operators */
+	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X)
+		goto error;
+
+	cbd = cb_data_new(cb, data);
 
 	if (g_at_chat_send(sd->chat, "AT+CUAD", cuad_prefix,
 			at_discover_apps_cb, cbd, g_free) > 0)
@@ -1648,6 +1655,7 @@ static void at_discover_apps(struct ofono_sim *sim,
 
 	g_free(cbd);
 
+error:
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
 }
 
-- 
2.25.1


Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984311CB6
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="STFr5+OQ";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="I7KDhdWp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=WCV9EdBoxBIAj2yL9v44IQFt0a0N/9pfKquMxMzGSp8=;
	t=1697530709;x=1697620709; 
	b=STFr5+OQ46YyBztYO193sH3LYkBZYtSjX5XNVRypVrubuF2+uF8hSpq0Uqc5ls1ytzBVHxcgY1weFYRvTtA8x77XA2lnXmkfrC+kLdIElmkwFOjowQQuxqTJu+v/KOqPPxvNRXRMc+V0sSAHH/gtFuJM3t9auK76NjpziyWDNu0=;
Received: from [10.12.4.35] (port=37198 helo=smtp63.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qseaS-00EGJn-15
	for ofono@lists.linux.dev; Tue, 17 Oct 2023 10:33:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=WCV9EdBoxBIAj2yL9v44IQFt0a0N/9pfKquMxMzGSp8=; t=1697528036; x=1697618036; 
	b=I7KDhdWpqXXN9hGOJ4aEn1lLJRxZMZ14zU3sb79sq4+z2ufw5dolL+pwqhd238COWaQTXye2+d0
	z4Dm7M7lNzVFea0d2Vic9GGkzWZiby+RdHlu7s0Dbu3abL+wBOSPsZaSMvhZebJKYhEnbnHFv8D2S
	k7IzO5W7PrSpDv9q1Y0=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qseaI-004oe4-0K; Tue, 17 Oct 2023 10:33:46 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: Sergei Golubtsov <sg@aqsi.ru>
Subject: [PATCH 01/18] Skipping AT+CUAD sending for QUECTEL_EC2X vendor
Date: Tue, 17 Oct 2023 12:33:25 +0500
Message-Id: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F5380850409FF556342BB614FDD20578184EC6D2488D1D99A0D9DF47B6D382D69397A14480
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E0D4B9A53B20B455EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637ECAF4C2CEE0D0B2F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D874120F2A6FFBECDC9ECE7A2494C6B05B117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC9FC99A4BA45EE8B4A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10F618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA99935A1E27F592749D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3CF7CD7A0D5AA5F25C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CFE4D9CDE3FF759CF2E808ACE2090B5E1725E5C173C3A84C3CF36E64A7E3F8E58089D37D7C0E48F6C8AA50765F790063785BD4F17004B3EE2EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A56E30DF9DA9C1B8DFDC415D92B1A1BB05866A1C66C4FBB915F87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB7EF3583871FFAB2ACA5DC60927FCAC3E11DBAFF45BEBE0FFA0FE155A6A52D6412B9ACBE231CC78AEBFDF7752E1FC337453CE6E6AF7A72B8F5BD7DA029755DDF40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCWKcWVSzU5lA==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9C09D42E65D137B8BC64BA6A2DABABD93F4FE21D981EC2DBB5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DEDBBC46D76EB2520ED4F58DABF9B695DC31409B8D5784D9049FFFDB7839CE9E80FBBB2CB63C9CB5F5F299258AE3F17824C753C7ADAAC5A19407ED22A873CFC8
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdVi+mls5yutoWud8khOrGPg==
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


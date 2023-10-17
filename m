Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE3381A6
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="s99sZ8O3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=9SEQ6V1n6UkP9eOBRq0qGneORI+BsODhhzknTxUHsZ0=; t=1697539787; x=1697629787; 
	b=s99sZ8O3aNkmicGGQB2U9uL/KCA8RCB032FcupJsUPHiylY2rQiFd14hoa562PJ8bEwqQY7U8su
	k8YpTSmOKiG1GZnMKBdNYOJya/+I4BeSc0Cmttr+/20+D+za4552gDP7zTA0mFhEvRejIaH0TfB5a
	r5etLvbwxSut1HjzofE=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshdv-00Ab9o-1g; Tue, 17 Oct 2023 13:49:44 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 04/15] build: adding support for the SIMCom A7605E-H
Date: Tue, 17 Oct 2023 15:48:51 +0500
Message-Id: <20231017104902.717947-4-m.lyubimov@aqsi.ru>
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
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9A0C7FD9243F13F0A0FCA17AF7E0BADE3B13B26AE5DD983FA182A05F5380850404C228DA9ACA6FE27F62AFB450DCECA825A75BD6C2E4F08FC0823825FBAFBC2004272159A9DCFC405
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AB81E605F2C81F9EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E16D8B060A9A23898638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D868550CDCBD6D9285D3CFAF97609222BE117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCBCFBAF3982895081A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B28585415E75ADA9F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E1113711BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6AFFDA16987AEDD6B3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FCE96A3A8AAADC8934E2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE4931B544F03EFBC4D57430FDFEF8887E0B2C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5E18B6E527E8F921B65C29474C6E1BB28CA7E950404D83397F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A091D471462564A2E19CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8E6E335644A9FBDC9D6683EC6B9F6C388AF00B92CA8CB21A66BF08A341769B7A23277A7B3C315D4EEBFDF7752E1FC337A02AD6AE31B7CED7D85B04CA7464E59E40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCuBg88RWaZxA==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746B871411C06C928ACA0702D06D97054970FA0F37F06AE55CE5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Modified the Makefile.am file to build the simcom_a76xx plugin
---
 Makefile.am | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index aac88f54..83c36d34 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -505,6 +505,9 @@ builtin_sources += drivers/atmodem/atutil.h \
 			drivers/xmm7modem/ims.c \
 			drivers/xmm7modem/netmon.c
 
+builtin_sources += drivers/atmodem/atutil.h \
+			drivers/simcommodem/radio-settings.c
+
 if PHONESIM
 builtin_modules += phonesim
 builtin_sources += plugins/phonesim.c
@@ -586,6 +589,9 @@ builtin_sources += plugins/sim900.c
 builtin_modules += sim7100
 builtin_sources += plugins/sim7100.c
 
+builtin_modules += simcom_a76xx
+builtin_sources += plugins/simcom_a76xx.c
+
 builtin_modules += connman
 builtin_sources += plugins/connman.c
 
-- 
2.25.1


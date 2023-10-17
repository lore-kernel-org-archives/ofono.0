Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383019BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="k1kgmu5x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=58re/0NanzARPI4nU+W28zz2yJgLV8zjB543jO6MVqY=; t=1697528135; x=1697618135; 
	b=k1kgmu5xiL4K3X8zPCiy+FMgUiuVjrB5jo8avoPwb/cfHNYkFFUMuwozAJgp1K+rK373ut/dN7c
	PxuQ1PaxtWbWf8xzjGhUWJHFQwEjM0CevOGVGO+lqfLZIUU3qdG7/cGG7sC+OgOnZqGInSLnr6gaK
	Tqr36gPgFUPMpTDtJMk=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebz-004oe4-0m; Tue, 17 Oct 2023 10:35:32 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 12/18] plugins: gemalto: Include models list
Date: Tue, 17 Oct 2023 12:33:36 +0500
Message-Id: <20231017073342.673160-12-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F538085040EB918C7CE998974FD20578184EC6D248B8AC85A86DC8A1FA313191FB6B85642A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CFDA40FA2326E319EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F91103FA893F53AB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D833A56CB52DDAF8C62CC49738F968133E117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC60CDF180582EB8FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA96136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C309122B91796FF21F76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C224941D154D92E01BDF1E827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7C26B9191E2D567F0EC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5AAF74875983F95ADDC415D92B1A1BB0555B2F8746AAC91C1F87CCE6106E1FC07E67D4AC08A07B9B0CF7CD7A0D5AA5F259C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF0D94423FDC73BC37746BE2575F50BE37202118BF65719A979A413864440C927131E81B06003A5D53EBFDF7752E1FC3375F8341E2B236ECF2F4DB855AA1DD029640B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJASrTpKpY2QqQ==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9DE80BD026E619FA6C64BA6A2DABABD93F6D6A072088EC04F5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Include models list from drivers/gemaltomodem/models.h
---
 plugins/gemalto.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index d1962ab8..fb6b79e7 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -53,16 +53,10 @@
 
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
+#include <drivers/gemaltomodem/models.h>
 
 #define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".cinterion.HardwareMonitor"
 
-/* Supported gemalto's modem */
-#define GEMALTO_MODEL_PHS8P	"0053"
-/* ALS3, PLS8-E, and PLS8-X family */
-#define GEMALTO_MODEL_ALS3_PLS8x	"0061"
-/* ELS81 modem */
-#define GEMALTO_MODEL_ELS81x   "005b"
-
 static const char *none_prefix[] = { NULL };
 static const char *sctm_prefix[] = { "^SCTM:", NULL };
 static const char *sbv_prefix[] = { "^SBV:", NULL };
-- 
2.25.1


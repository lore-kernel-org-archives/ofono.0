Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19719BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="J3w8Y8OK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=AcAyK5vEBSEfH+5WT1YQKYQExbZWuYLmMxwf0+ipYkE=; t=1697528116; x=1697618116; 
	b=J3w8Y8OK6Mkih0RNrT8td+WJkmbdzElGO8ekLb/8o+rczfBXyz6DQtdA0nDCA8dC2RP1yRPQyhs
	jK3R1RA0Tt0fQg4nKpbUm4EQ1/48F9dE1PZR//PGdv34CcbMo7kSufNFTpy7wwePLwi2zFWGIGKJ8
	YhUThhbe5C++Ejuop/I=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebf-004oe4-1V; Tue, 17 Oct 2023 10:35:12 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 07/18] plugins: simcom: Add radio settings
Date: Tue, 17 Oct 2023 12:33:31 +0500
Message-Id: <20231017073342.673160-7-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD9A0C7FD9243F13F0AB97817F7407E9626288CEC90671C4148182A05F5380850404C228DA9ACA6FE27D469EC24FA0F00F0BAEBF38A988C6B0CB4FCE89A8E068A08959172F71813842B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70D53446EB66A9CE1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379B0255B5E5688AF88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D887E02A983D3F34D778D86B08E8797CE3117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC9FC99A4BA45EE8B4A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA94D0DA9BD313A0613D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3CF7CD7A0D5AA5F252D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C735DFC8FA7AC12072E808ACE2090B5E1725E5C173C3A84C3ED8438A78DFE0A9E089D37D7C0E48F6C8AA50765F7900637522BF2A1F12CC7CFEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A58607846A88065262DC415D92B1A1BB05298C00A86472F1B0F87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DC79554A2A72441328621D336A7BC284946AD531847A6065AED8438A78DFE0A9EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF889CB410682FD63040EFD30ED65BC03BC4B58D3B4CFBF8E95631A0766606D02745CF0F9AF1251E13EBFDF7752E1FC337F8DCCF3903BF5076E35CA371D4F5820440B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJAC9x39TAT8zQ==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA91E91795E9F7A1438C64BA6A2DABABD9323261FF1C387AD765D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 plugins/simcom_a76xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/simcom_a76xx.c b/plugins/simcom_a76xx.c
index d66ca1b2..059773b5 100644
--- a/plugins/simcom_a76xx.c
+++ b/plugins/simcom_a76xx.c
@@ -56,6 +56,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/lte.h>
+#include <ofono/radio-settings.h>
 
 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
@@ -274,6 +275,7 @@ static void simcom_a76xx_post_sim(struct ofono_modem *modem)
 	ofono_call_barring_create(modem, 0, "atmodem", data->at);
 	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
 	ofono_phonebook_create(modem, 0, "atmodem", data->at);
+	ofono_radio_settings_create(modem, 0, "simcommodem", data->at);
 
 	gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
 	gc = ofono_gprs_context_create(modem, 0, "atmodem", data->ppp);
-- 
2.25.1


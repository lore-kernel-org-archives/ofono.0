Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA719BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="1NFPp0RP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=UrM7j+0+1alFekfQfN2WDUYnpdNdYCkkdjCV89xHLPM=; t=1697528138; x=1697618138; 
	b=1NFPp0RPHmGrpPHUYiYun4hWyhXgkOVwcuMzp242HWzhG9sRQQHEmwbUevX6r/HVr7cMfARlks1
	SbeeawwBFzfb9z81FOXQ6hnIjHFI5RkREfOMOZA78aMhJTRZ7GFIQ6L2YxPvokGBMq8NHP3v4uVf5
	pLdXncPglKELNQbbSXg=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsec3-004oe4-1K; Tue, 17 Oct 2023 10:35:36 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 13/18] plugins: udevng: Add support gemalto EHS5-E
Date: Tue, 17 Oct 2023 12:33:37 +0500
Message-Id: <20231017073342.673160-13-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD9A0C7FD9243F13F0A0FCA17AF7E0BADE3B13B26AE5DD983FA182A05F5380850404C228DA9ACA6FE27CD0560E873B6FA5EBAEBF38A988C6B0C8D1D99A0D9DF47B67F098220F8F0A2FE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73CF9C3B7871ACFEFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637652CD06254D2F21C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C51DB3FD5265DEDCAC3CC4E6E6C32405117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC6FC43C45D3E35E8FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520140C956E756FBB7A2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE437C869540D2AB0FCE99E4F20BAF2718D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE324F796C710B8583C040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CAD0E433DBF1FBFA32E808ACE2090B5E1725E5C173C3A84C3ED8438A78DFE0A9E089D37D7C0E48F6C8AA50765F79006376C5EA4134C4B2465731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A516D058DDD4B86DC2DC415D92B1A1BB053768244C0DDDEF18F87CCE6106E1FC07E67D4AC08A07B9B01F9513A7CA91E5559C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF79F8DCD1A0B433E3155AD5BA77B331C0955E8F1FE5CFEF9A8D9180C58C28764B6D10329F4AAC8FAEEBFDF7752E1FC3373693757FDF02F14617EF5D4121EECBD640B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCzeUgEb+tPQg==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9D53FAAAB1681A83AC64BA6A2DABABD9320D4C3049F133A785D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 plugins/udevng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 41494906..62efb210 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1356,7 +1356,7 @@ static gboolean setup_gemalto(struct modem_info *modem)
 				qmi = info->devnode;
 		}
 
-		/* Cinterion ALS3, PLS8-E, PLS8-X */
+		/* Cinterion ALS3, PLS8-E, PLS8-X, EHS5-E */
 		if (g_strcmp0(info->interface, "2/2/1") == 0) {
 			if (g_strcmp0(info->number, "00") == 0)
 				mdm = info->devnode;
@@ -2033,6 +2033,7 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "gemalto",	"cdc_acm",	"1e2d",	"0058"	},
 	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_acm",	"1e2d",	"005b"	},
-- 
2.25.1


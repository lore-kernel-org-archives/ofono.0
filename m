Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4538DCE
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="Lf8fx4Yv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=N7CUsMFUTlZowO6SrdBNgTt8bHUVdiLrNvecdvic4hY=; t=1697539796; x=1697629796; 
	b=Lf8fx4YvGPJvTRYViEczM561e26qFfH7LUJo/TWRZzfkKV8IjuL0o+T6wCr2xMuOBomuC95vL2u
	vf/i+NV3dnszeOEXEs0nYMSdm4ILFqoBKvcMNk3pBvGAKNAwqs+24RJFOcJJQISx0nbCIfOlwaMCA
	zLHt3Tt3Y3A7mkzXTNI=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshe5-00Ab9o-2V; Tue, 17 Oct 2023 13:49:54 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 10/15] plugins: udevng: Add support gemalto EHS5-E
Date: Tue, 17 Oct 2023 15:48:57 +0500
Message-Id: <20231017104902.717947-10-m.lyubimov@aqsi.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF13E7FB3349EB8EC0E9E46FFC79BA054E182A05F53808504022BA4DEAA6FA7510F7C630B3330F6295669C2F168564C983E618E5100F54CA1A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE723F2EBA4AF3D39F8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637367CCE42412B8BE38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D856F27438100745E768A5AB74CAE74C29117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC8883BAB8B32E402CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86DF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE4B6963042765DA4B985B8ACC81218E19D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE36D3A1509E1113711040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2A336C65186350912E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F790063772B73B1F640F4D17EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5202D1541435DCEE165C29474C6E1BB285AD0401A58EBFCA5F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF5D17816624245B98F037F669822983923EEC98D0496A7D1C9D65EC5D9E5AD32D01C110C29CAC5EA3EBFDF7752E1FC33712ACC5D2BDEBD07A3BF8A800A4F06A7440B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBA39GUDwoNQg==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746CD797040289B1712A0702D06D97054970FF2D94DDA5A807D5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 plugins/udevng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 7fccf670..4adb626b 100644
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
@@ -2035,6 +2035,7 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "gemalto",	"cdc_acm",	"1e2d",	"0058"	},
 	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_acm",	"1e2d",	"005b"	},
-- 
2.25.1


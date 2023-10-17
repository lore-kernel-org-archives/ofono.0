Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898C19BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="ifSvajkn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=N1rsAq021HnWzBTfPqVSWmsOo6A6dTGliTVNJmB9+Kk=; t=1697528111; x=1697618111; 
	b=ifSvajkn4f2mGI5sHEF2dSjWrTVSJlLuVSwYlK6oYsQkXVgcJb9fVgexh4DwUA+tFFMMaCP5C7O
	LhvDNlyENdd8y6ffF596dFU2l7Awf6HfL5gRe6OSk7w8CdYYh+yS7R89u+LFHmkVKPr3Lvx6tySCU
	wUNnt4cX/He4RkhRuE0=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebb-004oe4-0m; Tue, 17 Oct 2023 10:35:08 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 06/18] build: Add simcom radio settings rules
Date: Tue, 17 Oct 2023 12:33:30 +0500
Message-Id: <20231017073342.673160-6-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF5CC7285D8C811E3B51306B6EBC0A0AC2182A05F538085040D945AA67C1703D62D20578184EC6D248B8AC85A86DC8A1FA173ED6DFA0B5FA0C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7678D195E6F08FCA2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063750965CC5CDB672DE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C5BC20469850B0782CC49738F968133E117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCED943DBD20860CC2A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B28585415E75ADA928451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA94782AAF36435267CD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3CF7CD7A0D5AA5F2503F1AB874ED89028C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C1F9513A7CA91E5552E808ACE2090B5E1725E5C173C3A84C3ED8438A78DFE0A9E089D37D7C0E48F6C8AA50765F790063748B4EF0B4CC6827FEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A55557DABB78DF2430DC415D92B1A1BB0555B2F8746AAC91C1F87CCE6106E1FC07E67D4AC08A07B9B0457EE4B4996FC5469C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF707D4C96BCCA8DB1884E937B19698E1114B199C5441C08843203D4F86971A70306D2A967A71B2380EBFDF7752E1FC337E1FA95F2CC85CF58F4DB855AA1DD029640B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJAIbzMAC4kvKw==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9F249FDB50FC6AA59C64BA6A2DABABD93F6D6A072088EC04F5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 Makefile.am | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index a649f085..8c3ea657 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -505,6 +505,12 @@ builtin_sources += drivers/atmodem/atutil.h \
 			drivers/xmm7modem/ims.c \
 			drivers/xmm7modem/netmon.c
 
+builtin_modules += simcommodem
+builtin_sources += drivers/atmodem/atutil.h \
+			drivers/simcommodem/simcommodem.h \
+			drivers/simcommodem/simcommodem.c \
+			drivers/simcommodem/radio-settings.c
+
 if PHONESIM
 builtin_modules += phonesim
 builtin_sources += plugins/phonesim.c
-- 
2.25.1


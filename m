Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0419BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="q1F+G8l5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=8GZZX/vnpCqCoUrKFssBTSFLo4iG7FS0HU0dJzhm/jA=; t=1697528130; x=1697618130; 
	b=q1F+G8l5fr1uwgbmwBiDWDXlTND//rJwOPFLxcH0SRdSA6HOs0WSp53ivKNb8OkJzv0ShdudoHt
	uy3CYynPE2MXxsX99FHgEuh3hl872VvDrPyp0IPDSHDSJ28F3ThrZEca7r114AQIzY0ZVxhFC9JBt
	wRobI6/t0B44s72gySc=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebv-004oe4-1E; Tue, 17 Oct 2023 10:35:28 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 11/18] drivers: gemalto: Add models list
Date: Tue, 17 Oct 2023 12:33:35 +0500
Message-Id: <20231017073342.673160-11-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F5380850404409DB92FAFE42E3BAEBF38A988C6B0C24C752DF7A196021BC4EA9C9F615F20B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70043D879A87EF1BCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378BCFB34D7DDF138E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85877DB3C01FD079E04CA65896C81A83B117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC9FC99A4BA45EE8B4A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA99100238FE36DC7A2D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3CF7CD7A0D5AA5F256136E347CC761E07C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C4E7D9683544204AF2E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F79006376C5EA4134C4B2465731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A53A1FF48C3BF8D11BDC415D92B1A1BB051A4508520D7C436EF87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA5889C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF0BA47218BFCCC529407E9B22E3740354BF11DA0E15FAFD9E67A78D33450C4947D1BAA24A4D7F85D8EBFDF7752E1FC3378E76D3857E11C600E94A53F85B06B9A640B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBzSGlqEhvB1A==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9F6D7E4DC8F460068C64BA6A2DABABD93CD8872D538E8F8CB5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 drivers/gemaltomodem/models.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 drivers/gemaltomodem/models.h

diff --git a/drivers/gemaltomodem/models.h b/drivers/gemaltomodem/models.h
new file mode 100644
index 00000000..6d0d6490
--- /dev/null
+++ b/drivers/gemaltomodem/models.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/* Supported gemalto's modem */
+/* PHS8-P modem */
+#define GEMALTO_MODEL_PHS8P	"0053"
+/* ALS3, PLS8-E, and PLS8-X family */
+#define GEMALTO_MODEL_ALS3_PLS8x	"0061"
+/* ELS81 modem */
+#define GEMALTO_MODEL_ELS81x	"005b"
+/* EHS5-E modem */
+#define GEMALTO_MODEL_EHS5_E	"0058"
+
-- 
2.25.1


Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201973D39F
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="n7K9/pek"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=90/qTnSCnnGlNBITj/wZTYE63UIQuPbcDBq1S54XW24=; t=1697539809; x=1697629809; 
	b=n7K9/pekk2yOST2jW5XDETLPj2ltpNXk2lCgGJYvyKNkyHZs14/foXISDc2QwWBdkxZ90DQt+Ps
	tUyiYS83PCj0jKEB9jkT2mMPknvOitiJDxMdVZgsDrEbjm1JwT57ZUbDgnsFH31HBwCGOKhF4dDcB
	LNQqxo2yxuuH67/9lbk=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsheH-00Ab9o-14; Tue, 17 Oct 2023 13:50:06 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 15/15] ppp: message tracing
Date: Tue, 17 Oct 2023 15:49:02 +0500
Message-Id: <20231017104902.717947-15-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF5CC7285D8C811E3B51306B6EBC0A0AC2182A05F538085040E6670314545A58BB5A75BD6C2E4F08FC393C05885E9E0D0BA6FBD99859CD8E07
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7548C33FFD72831AFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C8D8BCCD49BBA39A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D833894FF5D442597CD41BDAF36AB859E9117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3A703B70628EAD7BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18F04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC65AC60A1F0286FE4DB3626BA78294CCD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3DBD6BAFA574C8444C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C0A6B3CD6EB70C8181DD303D21008E298D5E8D9A59859A8B652D31B9D28593E5175ECD9A6C639B01B78DA827A17800CE7149DEC19AE061930731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5873B1C3404EF494B65C29474C6E1BB28C6EC20BF4CFA3F44F87CCE6106E1FC07E67D4AC08A07B9B0CF7CD7A0D5AA5F259C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9F97D8B11F5A26FC776385C74C226EF7240A8B5227D6ED1B5F52F13A05F03E2A124E09ADABDE4174EBFDF7752E1FC337D7CDC95F2549F8BF4A09099D3D0810EA40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJANw54pice5xw==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746F1A5146B3CC94C6DA0702D06D9705497942E5C935CAB911F5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Added OFONO_PPP_RECORDING_PATH environment variable handling to enable PPP message tracing
---
 gatchat/gatppp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 259e6d5c..a655b35c 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -561,10 +561,16 @@ gboolean g_at_ppp_listen(GAtPPP *ppp, GAtIO *io)
 /* Administrative Open */
 gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
 {
+	char* recording_path;
+
 	ppp->hdlc = g_at_hdlc_new_from_io(io);
 	if (ppp->hdlc == NULL)
 		return FALSE;
 
+	recording_path = getenv("OFONO_PPP_RECORDING_PATH");
+	if (recording_path)
+		g_at_ppp_set_recording(ppp, recording_path);
+
 	ppp->suspended = FALSE;
 	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
 	g_at_hdlc_set_suspend_function(ppp->hdlc,
-- 
2.25.1


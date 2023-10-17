Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA419BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="Y4FmG/PN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Q+/2c8oynHyAJipcTXnOEbqsFPx3rJQMlFil23quZ2g=; t=1697528150; x=1697618150; 
	b=Y4FmG/PNqJFGTJ8IrLoiIauhHVuQjtve8dyVzRBzzrfCuCTT6c++oapTl0tesLEy/ZBxw7uW3bG
	AlCsF90lptN0PyWhhiNbZG8YdK3nqpZF4S/ISY/HBR0qofscSmRXPphwXnAyabUvS8qG5IfLzPSSK
	KM0RIIooMX3+TTtnKPc=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsecF-004oe4-0y; Tue, 17 Oct 2023 10:35:47 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 15/18] Fix PPP LCP Configure-Reject
Date: Tue, 17 Oct 2023 12:33:39 +0500
Message-Id: <20231017073342.673160-15-m.lyubimov@aqsi.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D41D6A7814E6FCC63F182A05F538085040BF8D0747D2A03EC1D20578184EC6D24852FBD2D5B142218B238855932E06D690
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78CB87876C5D626D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373D332FFE8BBF4EB58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8143E41DE84C9F6587BD6F8242301AC2F117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCECADA55FE5B58BB7A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18F04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE437C869540D2AB0F9735652A29929C6C4AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3B30A456A8F29384576E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22498CE9D8A6861299E6E827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7C90B2CA22E117843D43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5B4017830BBE1FBC7DC415D92B1A1BB056A178B9A15A9CEF5F87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE321E6EBAF0E8B5B7C9C61636B80AF9F723AD769B3658774D56B52A9068D71B8C6BFA615E6C3782AEBFDF7752E1FC337DCF9FB0CAC0734C681A607A323AA7FB640B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJD4V1mHbXu2pg==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA9141247AE18D623C6C64BA6A2DABABD93FD9DA1DBC5471EB65D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

According to RFC 1661 5.4

If some Configuration Options received in a Configure-Request are
not recognizable or are not acceptable for negotiation (as
configured by a network administrator), then the implementation
MUST transmit a Configure-Reject.  The Options field is filled
with only the unacceptable Configuration Options from the
Configure-Request.  All recognizable and negotiable Configuration
Options are filtered out of the Configure-Reject, but otherwise
the Configuration Options MUST NOT be reordered or modified in any
way.

Therefore, if the authorization type is NONE, then the authorization
type must be added to the list of not acceptable options.
---
 gatchat/ppp_lcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 7c45a27f..26ee7456 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -236,6 +236,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 		{
 			const guint8 *option_data =
 				ppp_option_iter_get_data(&iter);
+			guint8 option_length = ppp_option_iter_get_length(&iter);
 			guint16 proto = get_host_short(option_data);
 			guint8 method = option_data[2];
 			guint8 *option;
@@ -283,6 +284,15 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 				return RCR_NAK;
 
 			case G_AT_PPP_AUTH_METHOD_NONE:
+				option = g_try_malloc0(option_length + 2);
+				if (option == NULL)
+					return RCR_REJECT;
+
+				option[0] = AUTH_PROTO;
+				option[1] = option_length + 2;
+				memcpy(option + 2, option_data, option_length);
+				*new_options = option;
+				*new_len = option_length + 2;
 				return RCR_REJECT;
 			}
 			break;
-- 
2.25.1


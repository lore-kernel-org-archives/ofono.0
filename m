Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA43C684
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="WZEefqqq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Q+/2c8oynHyAJipcTXnOEbqsFPx3rJQMlFil23quZ2g=; t=1697539801; x=1697629801; 
	b=WZEefqqqUS3se0ygrJfpYLyOlOQZzPs9xt3rkya8mgar5rLFVJ7JIP2Bd/v3TEhRiSNK2lrR8eu
	jgHtefHSQE2sUGBTC7Tjf0wumrTvfx5bOVBuBokAnOFgAdtloR0yWvyIRIfvoRod+0FpGagN3ptc0
	5T2LsqsMsg/oUrBVAtk=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsheA-00Ab9o-09; Tue, 17 Oct 2023 13:49:58 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 12/15] Fix PPP LCP Configure-Reject
Date: Tue, 17 Oct 2023 15:48:59 +0500
Message-Id: <20231017104902.717947-12-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD9A0C7FD9243F13F0AB97817F7407E9626288CEC90671C4148182A05F5380850404C228DA9ACA6FE2746B8F51493FD7E98C2C183DA722F6B65A56ECAA748BF0E67946D57CBF7F493D4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9D6DADD6B53929DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372CAA106849E7D531EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBAD7DA90C0D4B893C248EE62AFF5745120CC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3CF36E64A7E3F8E58117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFEE95CEFCEDEAA6E8BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B66FAD99D6CE36569A76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249505D71D783575ABEE827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7CA0A09DF0321F028C43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5990D686C7C159B0E65C29474C6E1BB284FBEB7549D0728E0F87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FA9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF7F9959B336A58635963209BCFD0CA5768F2D78EEA40427001A23B5B6F3A5BA41A7F6D8DEE3A50DD4EBFDF7752E1FC3377D97AA8C68E91A746CA98385810B2F0440B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBlEPsCISh7tw==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF7469A40935BB5B721B5A0702D06D970549794E9A093BA7D1E925D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
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


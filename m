Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35798381A6
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="t/oqO8re"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=58re/0NanzARPI4nU+W28zz2yJgLV8zjB543jO6MVqY=; t=1697539795; x=1697629795; 
	b=t/oqO8reWjddnkcw8KnKi+fE44tBDgIBr201qCYUF2wMMw6a6edDWdtvi993mVnm7khS+Oracw4
	K+d7m0jFXRXfmJfN5Xo3ef/hr0dqdgv6JUaWH/YwF1JnxXziMvPi/gXrBLS1fZFtm30O/4H+mUwlr
	0a+A2FQMQPOrMo2Fz5M=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshe3-00Ab9o-37; Tue, 17 Oct 2023 13:49:52 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 09/15] plugins: gemalto: Include models list
Date: Tue, 17 Oct 2023 15:48:56 +0500
Message-Id: <20231017104902.717947-9-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D41D6A7814E6FCC63F182A05F5380850404F3E8112BC55C0830BAFA5D251685D61986F20DE99291CE0F6C56EB9AD954A41
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E99F7FC786761FD8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE75DF2B1F23425CAE5EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA4044F513A49383AF08DA38D5D84BA6A6CC7F00164DA146DAFE8445B8C89999728AA50765F79006372A3B24BF85B2E607389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E11137116E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C36F69C752ED3D2DDDBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF643C8550F84855021DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE728E0B16DA17939D7731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A58CDFCBE94C15D3F065C29474C6E1BB28FC7F46EFFC1FFB31F87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227B9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF7B15DB5D1662535CABB017542BFD77F2B67D41792E0E93408B5889705DE570D1E98901B1639BBD63EBFDF7752E1FC337DC0E5E75F42946EB16B1D903E368E0FD40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJD4rJ0XR3sT4Q==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746059518C2ECFD6650A0702D06D97054975EA11F3C5F3A97E85D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
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


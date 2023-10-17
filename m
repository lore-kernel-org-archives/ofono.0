Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F838DCE
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="F8+BG8mL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=8GZZX/vnpCqCoUrKFssBTSFLo4iG7FS0HU0dJzhm/jA=; t=1697539793; x=1697629793; 
	b=F8+BG8mLKBosjcwpMS01IM8h+AYOqW3XmzdKGBX8VQcy4VFdPwhTPvqUJV/HW6pL6Fe0Apsf6p5
	eqDasbd0CBxEKm+xDocU1pvwnJ3fnh5skRB09JYJA2TsHjxMJAqBQEq5X/FN3WzT4YGzpP7/USPu+
	Ix5MB+3QrtSvw3MlMPw=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshe2-00Ab9o-0H; Tue, 17 Oct 2023 13:49:50 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 08/15] drivers: gemalto: Add models list
Date: Tue, 17 Oct 2023 15:48:55 +0500
Message-Id: <20231017104902.717947-8-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD9A0C7FD9243F13F0AB97817F7407E9626288CEC90671C4148182A05F5380850404C228DA9ACA6FE27C36574A42E03B02BC2C183DA722F6B6578E950B2972FE27E721575008D2C60D2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DECE8D0A5E25C0FCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637770CCD3A0ADFB7EEEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA02194F1606FB834BCA21B7869090790BCC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC86089696B24BB1D19F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E1113711040F9FF01DFDA4A84AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3F3EB61DE83B5868CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFDF0FDDE43A621D5D1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C36521BF29929FA48D35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A54186AC4E84BB8A9165C29474C6E1BB2864A5F1BB1F066830F87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA5889C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF297D0DE9177DD68C92EDDA10E9D663FC9E31AB12E063322916109FCDDF0F5CBE5C1052AD1686EE73EBFDF7752E1FC33731B0097330CF9942B871D7A1C1F5ADAF40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJBXJOyEZN8Fig==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF74609432EC0707794D7A0702D06D97054972A243DE5A345A7275D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
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


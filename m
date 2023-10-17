Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25C381A6
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="QoeJfpBd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=0VXLhl5kjZLVAXWbDrpdgdzPwDnHFwJFig+4YA37Zws=; t=1697539791; x=1697629791; 
	b=QoeJfpBd/H4jpSEP/KUUXwOzIo0aSC6SwKgK/d2V6AIXVVT9AoVvmZPIqAVK8CqyuT5RIzJN5hn
	2AXW7zJnN+awabgVhCN4b3nA/3bWZMw5SdPjJt713reTYpfNBC2o6VJ+hoKyvtw5XyQYMKCIVBPD8
	K7vfu5St2eiPxkM9OsQ=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshe0-00Ab9o-0y; Tue, 17 Oct 2023 13:49:48 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 07/15] plugins: quectel: Add radio settings
Date: Tue, 17 Oct 2023 15:48:54 +0500
Message-Id: <20231017104902.717947-7-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFE894D0B694AE649AA7A71757303D0C60182A05F538085040A0781F79AE45317EC2C183DA722F6B650FFE9BE1FF3F0CFFB7740FDEFAAD684B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789066434B85BF7C7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637352A1F9739ED04D38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8597717C7C5023B54A50B27FB2C11E553117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC292D688DDAD4E7BC389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E11137116E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C36F69C752ED3D2DDDBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF97DCCBFEAAA0BC6A1DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE728E0B16DA17939D7731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5552B801B6478DB1D65C29474C6E1BB286A178B9A15A9CEF5F87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA5889C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCA89D2EAC29B62EF0D6FD8BFCC6D8D3566F2AE861906138CB89CBEDE1FC8B4C914755E582FAB3B35EBFDF7752E1FC33727153FBEB5EA50EF7F16DAA923F965E440B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCIqIA3yKyxPg==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF74642D06ECC17AAC2CAA0702D06D9705497FD9DA1DBC5471EB65D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

---
 plugins/quectel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 464845ff..1dd67e80 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -53,6 +53,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
 #include <ofono/dbus.h>
+#include <ofono/radio-settings.h>
 
 #include <gdbus/gdbus.h>
 
@@ -1366,6 +1367,7 @@ static void quectel_post_sim(struct ofono_modem *modem)
 	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
+	ofono_radio_settings_create(modem, 0, "quectelmodem", data->aux);
 
 	if (data->model == QUECTEL_EC21 || data->model == QUECTEL_EC200)
 		ofono_ussd_create(modem, data->vendor, "atmodem", data->aux);
-- 
2.25.1


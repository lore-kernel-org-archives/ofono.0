Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925D19BCD
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="aPQ43Q/W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=0VXLhl5kjZLVAXWbDrpdgdzPwDnHFwJFig+4YA37Zws=; t=1697528127; x=1697618127; 
	b=aPQ43Q/WEGEfUky/OVz0xEms4CR1D+nQLKUI1nTqXtfajX0d9J98RHW54lQL9baszM+NlJ4gzbm
	c2U5/zsgdb/soWZxEAbKSlqBurWvsf7R3ej5wd/G8mVtZ8nqb7j7kGKbAaez51M54j+0W4l2+LdEc
	kuXAOq19khNrFXmQgRQ=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsebr-004oe4-19; Tue, 17 Oct 2023 10:35:24 +0300
From: MaxLyubimov <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 10/18] plugins: quectel: Add radio settings
Date: Tue, 17 Oct 2023 12:33:34 +0500
Message-Id: <20231017073342.673160-10-m.lyubimov@aqsi.ru>
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
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF12F77ADD25EC5C9658AC0226C7A531B7182A05F53808504030D97E60EA6FEB18BAEBF38A988C6B0C6822A2BD9C4D3F5D79A144BBC9420A82
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78E8764B5BC580342EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372A1456D053D20C618638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8671A7BE871C71F146F68278FE443C66F117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3733B5EC72352B9FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FCB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA96136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C309122B91796FF21F76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C224915519F706774CB6AE827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7C26B9191E2D567F0EC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A52C7B3DEF35EDF30DDC415D92B1A1BB0587106498244DF2DCF87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF5B8431B53E6C5EA324FF8CF3937B4064EF64B93501BC9331E968B06E881328ACA08A323FE4E4FE84EBFDF7752E1FC337BF91B530E3F3C2622E264D0D21DF290B40B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJAtnFbpIK44IA==
X-Mailru-Sender: 0E9E14D9EC491FBAA6F07D099F7E1BA95D038194B97FB727C64BA6A2DABABD93841C1B05491BCCE35D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
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


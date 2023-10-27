Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7205E14262
	for <ofono@lists.linux.dev>; Fri, 27 Oct 2023 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="PjbFxefm";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="mqtONyAL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=CWp5kP3K0tGDwRZYd4Ji2kgbP8Bf7MqKRQdA+ZwHjSM=;
	t=1698394609;x=1698484609; 
	b=PjbFxefmFA1h3wDQdjYBuiEQoPGU214PIwraaKC7F1Q6dW44+66JzR+kouH9RpP7jQqv72ALiruVAfaitQ/zCAW5r8xAAMJKRjvI/Chjfktf4GMtl8mYEKEJ1PKZrzYf+8PCF1zaxq/ETwzJ2+2vBBG+MXp++GsjNAocR9b+F9E=;
Received: from [10.12.4.28] (port=46640 helo=smtp52.i.mail.ru)
	by fallback22.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwHdf-007dCV-6Y
	for ofono@lists.linux.dev; Fri, 27 Oct 2023 10:52:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=CWp5kP3K0tGDwRZYd4Ji2kgbP8Bf7MqKRQdA+ZwHjSM=; t=1698393135; x=1698483135; 
	b=mqtONyALxy9SblWFcGObPCD73Do8t7q2ev6DshYVVqGk34660OqLr6q7GH2C0Y+v8eLYT3h3Prb
	5gnFUV9M53SCj9f1rRug0QDI2fOhc0Hq/lrnDj1adYFbdE5/wCgATTLgBKmH/1pziySc282Z2SXJ3
	owJIHLd4KuiRzVJNmjU=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwHdV-002Cdq-32; Fri, 27 Oct 2023 10:52:06 +0300
Message-ID: <8e90fa7e7ae4a3a80efc5daeff1f0fd470235432.camel@aqsi.ru>
Subject: Re: [PATCH 02/15] drivers: adding support for the SIMCom A7605E-H
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Fri, 27 Oct 2023 12:52:04 +0500
In-Reply-To: <bf40fdd6-e09a-4151-b5c8-24e5553c147f@gmail.com>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
	 <20231017104902.717947-2-m.lyubimov@aqsi.ru>
	 <bf40fdd6-e09a-4151-b5c8-24e5553c147f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E713055E3AFDE8D490C96FED60D03BDF75ADF00894C459B0CD1B9580779E858DA5B5697216F522C6A8F500DD6E6B2F2CD5C18F15FB00FF16E125F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AD2F2D6F6013FF7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7548C33FFD72831AFEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA147B440C827F4358F1489205B22628E2CC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC87BD21ED50D08CA4DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C5E3BF8C76DC23F74AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3CD664F6670E7357ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF4964A708C60C975A1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3704239268B1C12EC35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5ED90649B6A744E33E7FE9A95AC43AE249FBFE7CF7BD4C5EBF87CCE6106E1FC07E67D4AC08A07B9B0FE4D9CDE3FF759CFCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF77EC21E62CB894CEF4FC6A1EBA57EF73316ED4648BF06DE1DFBB89333C2DA13BBF7F25536427AFA11B371662AFD121F0338CA5DA5B2A7150CF7DC98AE925043740B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojKQBmf2D4qoQKOSxNWWdw8A==
X-Mailru-Sender: 0E9E14D9EC491FBA853B49B9F314792BB11B42714E5136C6794DFE096DD205CB327D77830F209D785D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B09DFC738A27773C0AADAB31483B3DEE79B0C4EB1A4ECE74049FFFDB7839CE9E2955125F65856E4FA9A4CC3007FF6AF153067A755F0F063BD202F339C066C7C7
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd/ps9sdOGr8iX41D3Jtv0cQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Good afternoon, Denis

On 18/10/2023 в 20:30 -0500, Denis Kenzior пишет:
> On 10/17/23 05:48, MaxLyubimov wrote:
> > The features of the SIMCom A7605E-H modem are taken into account in
> > the atmodem driver
> > ---
> >   drivers/atmodem/gprs.c               |  59 ++++++-
> >   drivers/atmodem/sim.c                |   7 +-
> >   drivers/simcommodem/radio-settings.c | 236
> > +++++++++++++++++++++++++++
> >   3 files changed, 298 insertions(+), 4 deletions(-)
> >   create mode 100644 drivers/simcommodem/radio-settings.c
> > 
> 
> This patch fails because you're trying to add a file that already
> exists 
> upstream (radio-settings.c)
> 

I checked, there is no drivers/simcommodem/radio-settings.c file in the
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/drivers
repository, how can I fix this problem?

Best regards,
Lyubimov Maxim



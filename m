Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BBFCA68
	for <ofono@lists.linux.dev>; Tue, 31 Oct 2023 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="NLbwCIU9";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="pIEZbFRP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=l2WzxYDtMX0vihlmdUdlseQI2T50ooQyfZZSkCGIS/Y=;
	t=1698729234;x=1698819234; 
	b=NLbwCIU9wfAclfkD84lzf8V9xbKfhiUWzD1rdyRJq9hp4H701+cNg9rCBaJ/N/mcUV1QmAkqxiD4SRYxZniAIJ1GHb07vsJa+QdKKT3MRUmCtPld4DEDrh7CRJtEXig5minRiPB5Z85vwzRnV9x8AFjao78+FkS9CJn4i5sajCA=;
Received: from [10.12.4.27] (port=58998 helo=smtp53.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qxh4Y-004Jla-PV
	for ofono@lists.linux.dev; Tue, 31 Oct 2023 08:13:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=l2WzxYDtMX0vihlmdUdlseQI2T50ooQyfZZSkCGIS/Y=; t=1698729230; x=1698819230; 
	b=pIEZbFRPA6u2cR/9KSX2gg0KykfrshusZeGspkuxWQqT+wn6ys+6gdmdgdZi5+ZIcKhSiZ3sEBI
	eDQ0U/jX+g8MYaKNamtO5CulBM2xgiieeJDoqxji5Bs0cd7DduznWvX7CClD4TnBrRbvpjx5I1JuD
	L0YuZcC+sLSoZF9CPQk=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qxh4J-004U9X-2j; Tue, 31 Oct 2023 08:13:41 +0300
Message-ID: <2e5311edd0a8f307352b925466f0778041b7a707.camel@aqsi.ru>
Subject: Re: Modem: Add Reboot and SwitchOff methods
From: Lyubimov Maxim <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Tue, 31 Oct 2023 10:13:02 +0500
In-Reply-To: <272f2080-8c0a-4016-b6a5-1e95cf3811cc@gmail.com>
References: <043f75988608c0ca35b862dea5c92c1e0c6f8f51.camel@aqsi.ru>
	 <272f2080-8c0a-4016-b6a5-1e95cf3811cc@gmail.com>
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
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E713083557E3423ADEC5AE5E3E16383004B8A00894C459B0CD1B933D5698EE1C1CD2702E7F6AD4D612CE7A6D3321589A09A72090598096E5E7227
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71BB7708D34E2BFDAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376A27C8034CCD05E58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E51DEA1404576B0D04E2FC9B1ABD18CB117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCECADA55FE5B58BB7A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B1EA93887B71B66F2BD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3BFD98ABA943BD70B302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB861051D4BA689FC2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FAE2BFB9A60527F4FA91E23F1B6B78B78B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5AF314260F399EB49B4BC98A9C9EBC384DCD281A92BBA7DA0F87CCE6106E1FC07E67D4AC08A07B9B0CF7CD7A0D5AA5F25CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34FACF503ACC83041B176FC098644309990460B1828535FA7DACCFFB447E6BBB490D5A24DE3BC10EA31D7E09C32AA3244C6AE1AE5DD86044A2E9C295EC253FFFBB1E098CBE561D63433A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojPJ6ruIekffK1GBt3tPTh/w==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070FFF1C1B2E5331745EF549268557588EED6BF2599B324A69DD5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4B09DFC738A27773C0AADAB31483B3DEEE72B1E78B151666E049FFFDB7839CE9E22A93F7FB77D71FC1CC9388B1F227F859E77490E08C4CA1ACA3940F63C6D39EE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd/ps9sdOGr8jUCAlgb8JpmQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Hi Denis

On 30/10/2023 в 09:34 -0500, Denis Kenzior wrote:
> Hi Maxim,
> 
> On 10/30/23 02:30, Lyubimov Maxim wrote:
> > Hi Denis
> > 
> > Some modems have special commands to reboot and shutdown, I think
> > it
> > would be useful to add support for these commands to the modem
> > management interface to be able to reboot or shutdown the modem,
> > because some modems cannot be turned off by other means.
> 
> Can you elaborate further?  What is the difference between Reboot and
> Shutdown? 
> When would one use one vs the other?

Reboot is used if the modem is not working properly, for example if it
was configured incorrectly and needs to be returned to its original
state. Modem shutdown is used when turning off the device to which it
is connected, to safely remove power from the modem so that it can shut
down all processes and save the data it needs to its memory.

> Note that Shutdown should already be covered by Modem.Powered =
> False.  Drivers 
> are free to implement this in a way they best see fit.  See for
> example the 
> really old calypso.c driver for the Neo Freerunner.  It writes to the
> GPIO port 
> to physically shut down the modem.

There are several problems. On different devices, the on or off signal
can be implemented differently, so it is difficult to take this into
account in the driver. Some devices may not have hardware turn-on
signals at all, therefore, after turning off the AT modem with a
command, it will be impossible to turn it on. I think that using the
Modem.Powered property the modem should be both turned on and off. If
the driver cannot turn on the modem after turning it off, then it
should, for example, not turn it off, but put it into a mode with
minimal functionality, from which it can then be released after issuing
a turn-on command. And using the SwitchOff method, you can simply turn
off the modem without the ability to turn it on when it is definitely
no longer needed, for example, before turning off the device.

Best regards,
Lyubimov Maxim



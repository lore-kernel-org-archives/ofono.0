Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468B2F41
	for <ofono@lists.linux.dev>; Fri, 27 Oct 2023 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="x2OUeg85";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="ykDaUrk5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=h3roLX/GO9usqt4zlYcJ4e0s70UnNqFqgKSg0+yMTYU=;
	t=1698401078;x=1698491078; 
	b=x2OUeg855PHpwV+7hZUMzX2HloFmstho9s6uG3EIC28L8bwbcfNEUhR1X+c1jL+vDVOr+7MELV0BqW9Kdt71f6/am7pEPxoiXPvEDZUX95IlJN88OaejWkp3Ju6veglijhQvoo+iXmhrOVfT9GXF/WihLlyO0yUH1zaytVPcWX8=;
Received: from [10.12.4.22] (port=58816 helo=smtp41.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwJPl-00Bg96-WC
	for ofono@lists.linux.dev; Fri, 27 Oct 2023 12:46:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=h3roLX/GO9usqt4zlYcJ4e0s70UnNqFqgKSg0+yMTYU=; t=1698399962; x=1698489962; 
	b=ykDaUrk5pgg5NtZ++6cM+FVbFGEUlopApgrXD0vYMhjLDmPFDE26rzMBiG6EmpZ6/yrplOyaX2m
	a0hK+Z5Mj6STpoJzS2Dw3Vyv9atwjIMTZZP6AUNhbzh0AE2zpZoa6HOR+5TvfAr8e1KSzVMxOgfG9
	dWyj1xg/uV73xMfa8ec=;
Received: by smtp41.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwJPd-00E1Kk-0V; Fri, 27 Oct 2023 12:45:53 +0300
Message-ID: <d9591456ec4294c216445b6b0b73d2b54d94c2e0.camel@aqsi.ru>
Subject: Re: [PATCH 14/15] gatchat: added command completion by timeout
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Fri, 27 Oct 2023 14:45:50 +0500
In-Reply-To: <4a003c7d-4cee-4111-8bed-2bb51e5f510b@gmail.com>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
	 <20231017104902.717947-14-m.lyubimov@aqsi.ru>
	 <4a003c7d-4cee-4111-8bed-2bb51e5f510b@gmail.com>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E7130633014CD31F9236DD005CCC74777830D00894C459B0CD1B93357753CFD530452F2F0F63EAB18884C6603168F7F82A8CF89BD80B6B4489A2D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F8E53417176C7207EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063781BF90BB6B3E56078638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85D88318199FD0EC27D38C1FA63B3FD9A117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC974A882099E279BDA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B1C5236E9430F51F07D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE35E3BF8C76DC23F742D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CD2DCF9CF1F528DBC2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F1FC58B5115ECA9A257739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5EB5E218CE196CDAB80790386C6AAFA7DD14640B0C5C926F4F87CCE6106E1FC07E67D4AC08A07B9B0457EE4B4996FC546CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34E318F287A436F24CC046D1FF5AC4CB70997AF509B1DBABB3137A5D7DA7F8E637C04A0F96F54829EB1D7E09C32AA3244CAAB7FC8DC965EE73ED0AE3E05C0F75A6F2F5F14F68F1805B3A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojKQBmf2D4qoQOGJCD6UxP4A==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070FBBC9483B7B90B1E22BA49B8EB551A420A45CECB847E7C5435D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B09DFC738A27773C0AADAB31483B3DEE66B7C3446E6DE20E049FFFDB7839CE9E2955125F65856E4F0E3B0E042142E8761096EE83EA4C065B473328487F9ADF40
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd/ps9sdOGr8hgk1+3olD1IQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok

On 18/10/2023 в 21:21 -0500, Denis Kenzior wrote:
> So I think you're going to need to give a bit more context for how
> this is 
> expected to work.  There are commands (on older modems) that can take
> minutes to 
> complete.  This is why multiplexers were invented.  Now this is
> probably quite 
> rare, but I imagine it can still happen.

This functionality was added because some modems sometimes do not
respond to the command. Therefore, there is an endless wait for a
response and blocking of other functions with a message that the action
is still in progress. It was experimentally verified that if the
command is repeated, the modem can immediately respond to it and there
will be no blocking. What do you suggest to do if the modem does not
respond to the command either after a minute, or after an hour, never?

> Also, what happens if the command times out?  You generate a
> synthetic CME 100 
> error, but what then?

The function that sent the command must take action based on its
operating logic, for example, repeat the command, or fail.

> Also, this change is full of coding style violations, please fix
> those before I 
> look further.

Ok

Best regards,
Lyubimov Maxim



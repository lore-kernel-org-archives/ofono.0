Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [95.163.41.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE8806
	for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="oqno2KjC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=PoiBPmB4fHXLow4ubQhNpT8urRWaJjxG98/72ni2fVg=; t=1698647676; x=1698737676; 
	b=oqno2KjCla6PhN7nByuJi2thdw/JUMrcVnjwZflivpRU4CqZ25+bozN7Diis7m1CEZB9Udxvz4/
	mZzDeQCM42VpqNp5GV352sIAjYGiF4ecFrLlSym6mhldHzLMqj6d4MRBqgcaxEq5uZty98TaSyDmc
	JV5QC4dgrZOd+tppp+4=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qxLr1-001Rqv-0g; Mon, 30 Oct 2023 09:34:28 +0300
Message-ID: <280acbd30ead25b673141806764ffa7b629ab27a.camel@aqsi.ru>
Subject: Re: [PATCH 15/15] ppp: message tracing
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Mon, 30 Oct 2023 11:34:23 +0500
In-Reply-To: <6226eae5-8091-46af-b6c4-36a0578f4b00@gmail.com>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
	 <20231017104902.717947-15-m.lyubimov@aqsi.ru>
	 <4a3b8f95-1c7a-4f37-9a99-8d1928d24635@gmail.com>
	 <6d2992cc5acf2e72f831a7dc30274afed4995424.camel@aqsi.ru>
	 <6226eae5-8091-46af-b6c4-36a0578f4b00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp40.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E7130F333D6F3C33D48C9F7A892AE3F7E098900894C459B0CD1B90EFB37E5E45BCBBCC13857E16CB6FDDD037BA9D742653AE55E5D4A160AC272F4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AA1605287C7F04D6EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B24541F05F0BFC9F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88FDDE69D31C117DBE5D29EBD3A63C334117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3A703B70628EAD7BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6089696B24BB1D19BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B68BFD6B1B042489AC3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC3A703B70628EAD7BE2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE493B89ED3C7A62817819EF166FBCB559E95C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5BB32FC0632E5F856AEF185A2A7D06C0AA7A26B0606B3661FF87CCE6106E1FC07E67D4AC08A07B9B01F9513A7CA91E555CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D340A58BF0C7EAC340F39967A5A3263B16F4D8E0180ABB8A55C85D15EB31D7E167953536B2460B7A86A1D7E09C32AA3244C181C14C9E739B835552B4C6A437B64017C0C08F7987826B93A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojlPsYOQq/FJDPmtpFMyPw3g==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070FAAFB797A6B76AEA1788658F1940389BD0E2E03FEF34853A55D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Hi, Denis

> > > Hmm, this is better off in drivers/atmodem/gprs-context.c since
> > > you
> > > have an
> > > OFONO_ prefix for the environment variable.
> > 
> > I had to call the g_at_ppp_set_recording function here, because if
> > you
> > call it before g_at_ppp_open, then the ppp->hdlc variable is not
> > defined and the function does nothing, and if you call it after
> > g_at_ppp_open, then there is a possibility of losing events in the
> > log,
> > because g_at_ppp_open calls functions
> 
> Okay, so that looks like an implementation problem in GAtPPP.  One
> possible fix 
> is to store the recording filename until g_at_hdlc_new* is called,
> and call 
> g_at_hdlc_set_recording at the right moment.

Can I fix this and redo this patch?

Best regards,
Lyubimov Maxim



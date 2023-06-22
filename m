Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863D3AA8D
	for <ofono@lists.linux.dev>; Thu, 22 Jun 2023 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tUL4PJDDMexav1pWYFElRGIGjvtgOdp5Njls0sH7vyc=;
	t=1687426888;x=1687516888; 
	b=DHk8szvQAEtAigEoIhDo0fukU5/aqU+yBU/5jyOQFMS0f9kpR8T8V8mq85l349sqv/23D7p+hGAf6SYI6nBfa53R6ddeAI2mSFwpR6BJABR/5NkW6RXhRnISCy9gZeCEjoz+FbznRyN8j3jxeeWLRKby8RHkZNsg4DVOmcc/MXY=;
Received: from [10.12.4.15] (port=37420 helo=smtp40.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qCGVy-004GDN-O6
	for ofono@lists.linux.dev; Thu, 22 Jun 2023 12:22:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tUL4PJDDMexav1pWYFElRGIGjvtgOdp5Njls0sH7vyc=;
	t=1687425726;x=1687515726; 
	b=f8BxRj5lH95TqS44R1aPG/Ouhe+QxNFW5Ett7j1XN43yCb/wbUCJb1T6ochulvf1xYp6b8Spsc4RuwODrTK0ivcn8GnqFn4IDIj1nISYCyhBuF0wnMJCqTxL7qY2r8acWa1HgyZVtPkEI51wKd2ilMn9P6EqKhrVGvIXQB+MQlo=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qCGVq-007Q9G-Oi; Thu, 22 Jun 2023 12:21:59 +0300
Message-ID: <1a2704c6ff3b28fb93e4987dbf47e37c27e6c057.camel@aqsi.ru>
Subject: Ofono: adding support for the SIMCom A7605E-H
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Cc: denis.kenzior@intel.com
Date: Thu, 22 Jun 2023 14:21:56 +0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC1DBB6C3EBD37189F6AA3DE0BD4C4F69B182A05F538085040BCB6F1EE994650059ABCD2758286FC30D7CB0DFEBAB64E8FD385170316907C3B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FBB2043146276655EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D5B197C6EC5B4BE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83AB8FC77AE72DC0ADB086C7010AB7FF0117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCB816BE3345416868389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8FE0D02E6309259D2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C797D05A5B6841149040F9FF01DFDA4A84AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C362D9D0CA8437EFEEBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE75148C4404C1B6DAA731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5647250850A4A65452C7AFB26574A707F9524B2B8DC8B637AF87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34F6CC1FD33669633694A3E5ACE10FEF458E39E17713A1E15AF47823CF3E702533B6CED94C3DCB17161D7E09C32AA3244CEC227E7D0E282DE4A7A69DEBBFC73C3E39C99C45E8D137E93A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXjDoX+xFnGPkI8UvYLjbGBm
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070F0C5FA9D89CC8B9E06F614DEF831D663EA3F879B00792AB235D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA5428313B15E14F8F384AD33F499B6107AFB647ED114AB003AC6D609943FEF4E620D5079581C8977552AB180B923A6C507E572B146F658FAF5A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdGZgddNfoakPS0QK3rEZX/w==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Hello Denis Kenzior

I'm working on adding SIMCom A7605E-H (A7602E-H) modem support to
ofono. By now, I have prepared a version of the modem driver that works
according to the manufacturer's recommendations. But there is a problem
related to the functioning of the PPP connection. After activating the
context in ofono, the PPP connection is established, and the /dev/ppp0
device appears on the system. But when I send a ping to an external
server, after a few replies (1-100), the replies from the server stop
coming.

The manufacturer provides instructions for the modem, which describes
the procedure for setting up a PPP connection through pppd. By
following this instruction, the connection is stable and ping responses
are not interrupted.

I checked if the previously sent commands to the modem from ofono
affect the stability of the connection. To do this, I launched ofono,
in which all the procedures for polling and configuring the modem were
carried out. The context in ofono was not active. Next, I started pppd
with a script written according to the manufacturer's recommendations,
so the context activation was performed using pppd from the place where
ofono would have done it. After that, the /dev/ppp0 device also
appeared in the system, but the ping responses from the server come
steadily. Therefore, we can conclude that the problem lies in the
implementation of the PPP protocol in ofono, which for some reason is
incompatible with the SIMCom A7605E-H modem.

How would you comment on this situation and in what direction would you
advise moving to solve this problem?

Best Regards,
Lyubimov Maxim



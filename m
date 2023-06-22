Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08D80C
	for <ofono@lists.linux.dev>; Thu, 22 Jun 2023 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tUL4PJDDMexav1pWYFElRGIGjvtgOdp5Njls0sH7vyc=;
	t=1687425876;x=1687515876; 
	b=X+hbHm5IzmpfZ4zQwjYhafNKRTeU07Z2UvrkWeGb+jggQoYDKiuudsEJJ/A/PrZ6lxhLfIST9LvbcyCOV41SJpOjk8d6I+EBFGDAbmJUak0njQ8khAuc8BdlIlU+CA9zd32cjp0Y56rH1z/6iWRYbCOc+k3bHrj/sFU/Xc5STtg=;
Received: from [10.12.4.3] (port=60730 helo=smtp17.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qCGYK-004JYE-SV
	for ofono@lists.linux.dev; Thu, 22 Jun 2023 12:24:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tUL4PJDDMexav1pWYFElRGIGjvtgOdp5Njls0sH7vyc=;
	t=1687425872;x=1687515872; 
	b=VQx0WZEYySFzH39bSdIVhwAJz4PV7QYHWHHUpl/pYLiAx26tpXxd6HOcWmWo6T2NmL7DXx89izt1P98TWpkhPO1r5JLNOx5/dkp+WuKiP0kA6f7t1jI7W/xBah0dbQ7RpQrfR8f8zLnK9zIyO0rPlM4Hjp3nRYLT2C7S4byEnxY=;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qCGYC-00BY9Z-CK
	for ofono@lists.linux.dev; Thu, 22 Jun 2023 12:24:24 +0300
Message-ID: <2af6ef8c3d5c9437da480e59d4012c81a0f66b6f.camel@aqsi.ru>
Subject: Ofono: adding support for the SIMCom A7605E-H
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Date: Thu, 22 Jun 2023 14:24:22 +0500
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC30BBECE192AD7C83A31A99510E8D027E182A05F53808504001C3C622CB2889759DFE1058FB9A18801D18136D379A2ECDDF02538562B28846
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FBB2043146276655EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D5B197C6EC5B4BE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D870B621DEDFC07A6FA75226837A94F46F117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCB816BE3345416868389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8FE0D02E6309259D2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C151DCBF0643CA2B4302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3431F14B464DA2F1CBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE76C76551EAF50E908731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5E17B18152DD46CAE429E82AF3E4017BBF03EA43FE6FD9DF7F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34F6CC1FD33669633694A3E5ACE10FEF458E39E17713A1E15AF47823CF3E702533B6CED94C3DCB17161D7E09C32AA3244CE9CA30384D90DD5C1DD2EBA4ABF7FCD855E75C8D0ED9F6EEBC4AF6B5DE6957CB5DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB41c+mu8Ac9OEU7zvegoWw==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070F7BC7F7BE9074E525FEEAC52F57F43785A00BF4DCB1108DEC5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA540BA86606027D8C67504D4B514AABB5FBB647ED114AB003AC9762ADE31F07C824D8DC541800C1808B1926018D1A608E97026B1EFB0DED6594
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdGZgddNfoakP5BoePhOXaFQ==
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



Received: from smtp56.i.mail.ru (smtp56.i.mail.ru [95.163.41.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4846AD
	for <ofono@lists.linux.dev>; Mon, 30 Oct 2023 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="I3VuQ/LO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=eXYwOP6Vz/HcextosyD0TOPpcrhvepZvySbbGu4Q3Hg=; t=1698649498; x=1698739498; 
	b=I3VuQ/LOvJaUv2c7mweqNfruAZVNuk3haOav4YA7fh3J5fX4wZYAHBVpus0faEfD5R40fvssA6U
	vDLFsUT4jqXCJroZKn5GSn3h2pUFI+FocTg7qP7OJfiVEPIxf8vHGKOC1RY/BjgkayjNdtNTMEoXS
	bY71pCBtm3oWXvlZi2s=;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qxMKO-00B4gn-1B; Mon, 30 Oct 2023 10:04:49 +0300
Message-ID: <681f57cc7909dcbd58b6fa273d11cd96904b5eb5.camel@aqsi.ru>
Subject: Re: [PATCH 14/15] gatchat: added command completion by timeout
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Mon, 30 Oct 2023 12:04:45 +0500
In-Reply-To: <d78baea0-813c-414d-bf8d-d9a06fbdb5fa@gmail.com>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
	 <20231017104902.717947-14-m.lyubimov@aqsi.ru>
	 <4a003c7d-4cee-4111-8bed-2bb51e5f510b@gmail.com>
	 <d9591456ec4294c216445b6b0b73d2b54d94c2e0.camel@aqsi.ru>
	 <d78baea0-813c-414d-bf8d-d9a06fbdb5fa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp56.i.mail.ru; auth=pass smtp.auth=m.lyubimov@aqsi.ru smtp.mailfrom=m.lyubimov@aqsi.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E713028A6B45E8800B8D808196D39FA30EE0600894C459B0CD1B989CE8CD474134E72061D90D9F9F7EF63C0A82397A3ABD1EF3D433D207E322D29
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A0175C48BD57B26BC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE721B3E54BB37EA0B4EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA575265265C9BC84E207E7E793E5EF444CC7F00164DA146DAFE8445B8C89999728AA50765F7900637DCE3DBD6F8E38AFD389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC817119E5299B287EEF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CF254576263B31EA9040F9FF01DFDA4A84AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3B1CCBFDB748CB1BDBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE97D2AE7161E217F1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C347EB90A91F51F428089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5B3889E71CD9E043D03A6A5E73C16A1C7E882F8738B50D074F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B35CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D346EDE9E12965E8CD5BB9C69064CA86590A10EBA2C7AF6DE94C82E76CF0C3CE0F74B2894A09E54D6AC1D7E09C32AA3244C2A478D84F363AEEFEDB0911BD67037A4795D98D676DD64D03A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojlPsYOQq/FJBfuj1wxCFFzA==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070FFDCEB27E6DF0A16D7625611360404B057B550B4BA35CC43C5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

Hi, Denis

> > > So I think you're going to need to give a bit more context for
> > > how
> > > this is
> > > expected to work.  There are commands (on older modems) that can
> > > take
> > > minutes to
> > > complete.  This is why multiplexers were invented.  Now this is
> > > probably quite
> > > rare, but I imagine it can still happen.
> > 
> > This functionality was added because some modems sometimes do not
> > respond to the command. Therefore, there is an endless wait for a
> > response and blocking of other functions with a message that the
> > action
> 
> Ok, but which modems?  Do you have an OFONO_AT_DEBUG log trace you
> can share?

Similar behavior is observed on simcom modems. There are no logs yet,
but it clearly shows that there is no response to the command.

> Anyhow, at the very least you need to make this an opt-in
> feature.  As I pointed 
> out, opting in *all* modem drivers into this functionality will break
> some of them.

I can suggest adding a property to the modem driver data that will
enable this function for it.

> > is still in progress. It was experimentally verified that if the
> > command is repeated, the modem can immediately respond to it and
> > there
> > will be no blocking. What do you suggest to do if the modem does
> > not
> > respond to the command either after a minute, or after an hour,
> > never?
> 
> Call the vendor and have them fix their firmware? :)  But seriously,
> how many 
> commands are we talking about?  If it is one, then handle it
> specifically for 
> that command.  If it is a dozen, create a utility function.

Multiple commands that are sent over an interface shared with a PPP
connection. I have a suspicion that when switching from data
transmission to command processing, the modem does not process AT
commands through this interface. But the time frame for this switch is
not clear.

> I'm not convinced adding this functionality directly to GAtChat is
> the right 
> approach.  There is no such thing as 'AT command timeout' in V.250
> specification 
> or any other standard.  AT command cancellation as a concept exists,
> but it only 
> works sometimes and only for some commands, and isn't what you're
> doing here 
> from what I can tell.
> 
> What you're describing is vendor specific behavior and has to be
> treated as such.

How to properly handle a lack of response to a command? Should I add a
property to the modem driver to enable this feature in GAtChat? Or
should we separately process the lack of response for those commands
for which such modem behavior was observed?

Best regards,
Lyubimov Maxim



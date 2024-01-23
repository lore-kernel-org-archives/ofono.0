Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68D5EE9E
	for <ofono@lists.linux.dev>; Tue, 23 Jan 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017385; cv=none; b=MGRD1YnLFrjHB6ikNXp8kYJlCDGBOus8PPbXuzLTc0TpqoM8+5jSN1Gg0+HbBDxl2ByaJkyE3DeyvnKehc/rbEqf/EBPm56d0wXLAqI2pQ2j5lLqZMbCeGg8THoMcIjvc1VipF2rsuHuxEfyylkp1eibiq8XPFq/v9O5ik2TpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017385; c=relaxed/simple;
	bh=ljXoBBEI4ZLbDDJJV+XrWdNO/f2RalQCALMxdPezZuQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LU4iADiziWFucBZrbSnacVtnRicfevJg7hXwuYDnAcCHNCxebAqLnE64nH2nMPW3aE0b+fmgx9eMDZohubSTAb908lW6VRLD/YYsFqR0p0yak1TVXawaPoFZnVBNR116yVq4mmOMW4bSmwbHbcDKqza6/EaR4BqMRHioXA7PrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru; spf=pass smtp.mailfrom=aqsi.ru; dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b=Dz/75A3l; dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b=zeJ5b18B; arc=none smtp.client-ip=79.137.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="Dz/75A3l";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="zeJ5b18B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=bC6Pz2PP3AhgfAQ8Sm2ygAildyzDudMo87PD6ovpOR4=;
	t=1706017379;x=1706107379; 
	b=Dz/75A3l2GYP81EXj1DVoD0utU6RiyheSHGNuXRNfnw00/xZp42hDfeQwvE7qqwC4Brp7fUW7yt+0/Ng8GedUqMtGBBbCgknCkxRF2ErCc0ygacn3nQfZeo5GSB98td/8IiZbV5f0hgCIi9r46q5aIE0fmjeAjvloLQTm4riq4s=;
Received: from [10.12.4.27] (port=48258 helo=smtp53.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1rSH3D-002U0A-2k
	for ofono@lists.linux.dev; Tue, 23 Jan 2024 16:42:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=bC6Pz2PP3AhgfAQ8Sm2ygAildyzDudMo87PD6ovpOR4=; t=1706017371; x=1706107371; 
	b=zeJ5b18BzRZRbNJ9idXTcoSqxj5ygJEM0ioOCpfMZySUErYnmhSP+Dlwb2J7PBVQNY+bKgPpDLp
	NMfIfuNtVpuF0IWyVNPnaKx0jcScY5SX9l8as1vBIvPOVjubJ6VSFBlevcYliIE8J/HPSfaNDLoB8
	BOhxGzNAIObRdIDTSpE=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1rSH34-0006RW-16; Tue, 23 Jan 2024 16:42:42 +0300
Message-ID: <b8a2a89f56af360d3a74906ffd61b5ed0af00aa2.camel@aqsi.ru>
Subject: Re: [PATCH] gatchat: fix unref
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Tue, 23 Jan 2024 18:42:39 +0500
In-Reply-To: <c66954ea-81b8-41bd-b261-aade6edd48c3@gmail.com>
References: <20240119111017.1407534-1-m.lyubimov@aqsi.ru>
	 <c66954ea-81b8-41bd-b261-aade6edd48c3@gmail.com>
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD936B5060B5AFFD53133AA9E8BBBDC99136D2E64E3DD6D6B8D182A05F538085040ECFAA27BB6F2ED216722AF3D5733E127962EA3A33B7F2F9E01708587A242FE99
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CE4525FFB91B9BBCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D7F1BE85E7B0CA818638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8047FDE66F1366E4F5AB087DADFFCC9CF117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCECADA55FE5B58BB7A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD1828451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B18F49F126DDB898E8D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3F254576263B31EA99735652A29929C6CC4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB861051D4BA689FC2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F10D407B19AF7F75042539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5CC192697FF504C5656893C237B886CEAD759798B220883C4F87CCE6106E1FC07E67D4AC08A07B9B02D01283D1ACF37BACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34F1ADD4D8CD3C81CE439F314804588D6BE148254D71A6E1F3A3AD90C4E276225EC9619A8D42C4842F1D7E09C32AA3244C29777A811AB3E5450A7DBCA2CB159CACCE0B41342B755BCD3A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojGSQVxX8i/5WekaYvUKFi7w==
X-Mailru-Sender: 0E9E14D9EC491FBA110092B5D9DC829B78C82C07DD22B761738B325B7FD1DF8A7652F063092A458A5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 6242723A09DB00B45562A35114C4D62A428494A6AB631861212E0950520E67B6049FFFDB7839CE9E935078DE41EB476B30C0ECF0C2F87C9FC9C3A9D1D550EF43BA64C288B5A7F05B
X-7FA49CB5: 0D63561A33F958A54646462FFA02A224915C74661F1A29780D53A0AE071AF91A8941B15DA834481FA18204E546F3947C093C2F12201C912AF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006376B023E84F73EF47C389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3346FD2FB2ADF2DD735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojGSQVxX8i/5VrYaECUwxxAQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Hi Denis,

On 19/01/2024 в 11:19 -0600, Denis Kenzior пишет:
> 
> The original intent with the re-entrancy guards was to stop
> processing input 
> once g_at_chat_unref has been called.  In theory, if all chats have
> been cleaned 
> up via g_at_chat_unref, then the calls to:
> 	at_chat_cancel_group(chat->parent, chat->group);
> 	g_at_chat_unregister_all(chat);
> 
> ...should unregister all notifications and commands.  So I think what
> you 
> propose here is okay...  But I wonder if a more explicit stop of
> processing 
> would be better.  Maybe:
>   - Do not invoke chat_cleanup if in_read_handler is TRUE in
> at_chat_unref()
>   - Invoke chat_cleanup in addition to g_free at the end of
> new_bytes?
> 

Okay, whatever you say

Best regards,
Lyubimov Maxim



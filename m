Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792303FB24
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="a/P1Hw+3";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="m0xfFH4O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Qk6QwTnvuXncjPR9xBGTTZiz/3e3P4ckaeXIT9rWOiA=;
	t=1697537398;x=1697627398; 
	b=a/P1Hw+3+dzR/+/p9K+SNozNVi4dEImahqTZCRPMa2y6G6SZ6aDmt/Z+8TpVbSxTEMDC9OHtAtL5IwBX6ukwm0jPOX1zgRiMqZU/Fxhi/O4j2+wtANMBiEmwljR36nxDO8jOu9pSNnHw4iixOE5/x5PaJvtJ2S/0XmtBqa5vMaA=;
Received: from [10.12.4.15] (port=44110 helo=smtp40.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsgWI-003XZ9-2L
	for ofono@lists.linux.dev; Tue, 17 Oct 2023 12:37:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Qk6QwTnvuXncjPR9xBGTTZiz/3e3P4ckaeXIT9rWOiA=; t=1697535466; x=1697625466; 
	b=m0xfFH4OgN2/hZ/J9Tar6wFE0iVW1TvDWb05dqCLnNk+xrwFbIZGumfR4XQitp9NiCt8ur9j+kG
	oANd5BTdQzUUqLMJBEhWrDPDSvskY3XRYVDiivmMb7rpmmDyOPxiVj1VN4lJ6eIqx5Fosfvrb7PcS
	iShBdJTAmohQ8fe4jok=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qsgW9-004648-1T
	for ofono@lists.linux.dev; Tue, 17 Oct 2023 12:37:38 +0300
Message-ID: <f0963b5d68b253014e977d04f09d918716384f81.camel@aqsi.ru>
Subject: Re: [PATCH 18/18] ppp: message tracing
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Date: Tue, 17 Oct 2023 14:37:35 +0500
In-Reply-To: <20231017073342.673160-18-m.lyubimov@aqsi.ru>
References: <20231017073342.673160-1-m.lyubimov@aqsi.ru>
	 <20231017073342.673160-18-m.lyubimov@aqsi.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D41D6A7814E6FCC63F182A05F538085040B228FD722A4A0CE27ABE6330AEE63CC8A1A55C54835761560DF4A0C1950A84E1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B44982FA5E78411EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370F98874192B1BA168638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A6BD77AE30D0972CD98E3F904406360F117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3733B5EC72352B9FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FCB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B1B01F8B705E65F4D2D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE35E3BF8C76DC23F74C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C65B78C30F681404D2E808ACE2090B5E1725E5C173C3A84C3ED8438A78DFE0A9E089D37D7C0E48F6C8AA50765F7900637868FDC38802DDEABEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5E1AB7BDCF386ADB97E7B6870624BAD197D98463E09CF8E31F87CCE6106E1FC07E67D4AC08A07B9B064E7220B7C550592CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD200B2F88C3C981F6B3B662100BEEDF3C817D8E5B28F8F3ED3A438BE0FBBF0D7E80DAFFC47B24EFFEBFDF7752E1FC337359FC377484E3A2300914E9795758F7DCAACD699CDC6F98202C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJCXpD+MXcWMyw==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746235216094318B8A9AC97B2F374C1D2E4D8649DE294F770995D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DEDBBC46D76EB2520ED4F58DABF9B695DC31409B8D5784D9049FFFDB7839CE9E80FBBB2CB63C9CB530070923654E8DE591A46848C1DEB98F0B687F8DC7B63664
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdVi+mls5yutqOIfbWdj1WRA==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Good afternoon, I apologize, the previous 18 patches need to be
recalled, they were sent by mistake and do not take into account some
fixes, I will resend the corrected patches

Best regards,
Lyubimov Maxim

В Вт, 17/10/2023 в 12:33 +0500, MaxLyubimov пишет:
> Added OFONO_PPP_RECORDING_PATH environment variable handling to
> enable PPP message tracing
> ---
>  gatchat/gatppp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> index 259e6d5c..a655b35c 100644
> --- a/gatchat/gatppp.c
> +++ b/gatchat/gatppp.c
> @@ -561,10 +561,16 @@ gboolean g_at_ppp_listen(GAtPPP *ppp, GAtIO
> *io)
>  /* Administrative Open */
>  gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
>  {
> +	char* recording_path;
> +
>  	ppp->hdlc = g_at_hdlc_new_from_io(io);
>  	if (ppp->hdlc == NULL)
>  		return FALSE;
>  
> +	recording_path = getenv("OFONO_PPP_RECORDING_PATH");
> +	if (recording_path)
> +		g_at_ppp_set_recording(ppp, recording_path);
> +
>  	ppp->suspended = FALSE;
>  	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
>  	g_at_hdlc_set_suspend_function(ppp->hdlc,


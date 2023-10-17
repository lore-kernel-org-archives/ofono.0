Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803A41746
	for <ofono@lists.linux.dev>; Tue, 17 Oct 2023 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="Xohh8x2x";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="ymexQAez"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Qk6QwTnvuXncjPR9xBGTTZiz/3e3P4ckaeXIT9rWOiA=;
	t=1697543167;x=1697633167; 
	b=Xohh8x2xvVU+3jB/O83ecQAFGv8DmOeoWsrNR4gjik3MFkkkWHuq2hnpC2slqMtk4rxf0aquG2z0FyyYnubGt5I2fbpaotuCMwAo/ugtAKVZfIv5EIA3Vxvrw+kB7J89lfc0zzaWtJkVMMloj07TgmHJLs7sA8M3mLQc6VrYjJE=;
Received: from [10.12.4.20] (port=41600 helo=smtp44.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshkx-00BKEp-Ib
	for ofono@lists.linux.dev; Tue, 17 Oct 2023 13:57:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Qk6QwTnvuXncjPR9xBGTTZiz/3e3P4ckaeXIT9rWOiA=; t=1697540219; x=1697630219; 
	b=ymexQAezLe7vL2qIrDnX/+t9vWUnNHLRYyuW3zmv+HeXYhSRsBs+BSUqbC57bA00jBvUNUSim4f
	2nfVmZs2+7JljKraKkCOvEcb3t4j32OIkI4dfEeyRRQ+8swYWB8cU3mnNrRU8WEd+mcrUAZ2QGDCF
	2De348Wc3MjDx04myC4=;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qshko-000b6h-0M
	for ofono@lists.linux.dev; Tue, 17 Oct 2023 13:56:50 +0300
Message-ID: <68a8477fb86418906be79eb5f74a6a3d3ed1debc.camel@aqsi.ru>
Subject: Re: [PATCH 18/18] ppp: message tracing
From: Lyubimov Maxim <m.lyubimov@aqsi.ru>
To: ofono@lists.linux.dev
Date: Tue, 17 Oct 2023 15:56:48 +0500
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF067259BE5129BC25732DC641AEA930A1182A05F538085040B8D77F5BB973E680112E7A4F150FA6E43C3787C765B9E75479F67EFB8663274D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B44982FA5E78411EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370F98874192B1BA168638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8044B19B4AFE1B921D115E6D5C5829042117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3733B5EC72352B9FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FCB629EEF1311BF91D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B13DBBCB839D0549ACD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3F254576263B31EA9040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C5DBE5CE84B47B0E41DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE7535BECA8A3508734731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5CD1F0F617E327B897385B6CE857B44B6EAF0B08A1BD6E2FEF87CCE6106E1FC07E67D4AC08A07B9B064E7220B7C550592CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD200B2F88C3C981F6B3B662100BEEDF3C817D8E5B28F8F3ED3A438BE0FBBF0D7E80DAFFC47B24EFFEBFDF7752E1FC337E87342D5D952447A14820A23EAA016AFCAACD699CDC6F98202C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojfbpVM+RcTJAOOCAFg6U89Q==
X-Mailru-Sender: 0E9E14D9EC491FBAD2A03FC26A0EF746863B3EFA150D0E597C612D0B95A35833876E38531A9214E95D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4DEDBBC46D76EB2520ED4F58DABF9B69510FDFA31A9459BA5049FFFDB7839CE9E80FBBB2CB63C9CB56E30EDB14FB391EDAAA48BA9A255FD7F174EE3BD60732A3F
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdVi+mls5yutpzX1Sd3pQWZA==
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


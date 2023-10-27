Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E0156C9
	for <ofono@lists.linux.dev>; Fri, 27 Oct 2023 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="yP2cQeR0";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="01j4LOfM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=CjgIHVTFCSl9c5Mx4kP5GOhAbymKoaqA0va5pNu7Vss=;
	t=1698402537;x=1698492537; 
	b=yP2cQeR0rn9NYqjYVjbM+37WFv7raeDKulKeTAXNZGRWwNOUwdFlyAZA4bGG/58TWQs+6m7jg1+doyTopC8FIHoagtY2a1SKrRN6zv2AqIxhznp73J/tfo/Tr6eO49QxN5ybXY9hyq7roarFAP1/S/qWXKLJuKjjAGkpJNM38rI=;
Received: from [10.12.4.31] (port=59936 helo=smtp56.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwJf9-00Dmvs-J8
	for ofono@lists.linux.dev; Fri, 27 Oct 2023 13:01:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=CjgIHVTFCSl9c5Mx4kP5GOhAbymKoaqA0va5pNu7Vss=; t=1698400915; x=1698490915; 
	b=01j4LOfMmQTzTD6HuIUDrXRvZYFbFq4lf0pL1Seoi2wQwXpH1PAcu5USnn0RIg8FMkDB6iTRxlt
	QecN/jykrsDTsl2tSZGvZHdfNoztCGG9Sj+IouuSqgfpH5p0uLz0QTnS20gUliN1LpoV3IyyQ78YO
	nlMVWnAzX1YHvHVuS/g=;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwJez-0031hS-0d; Fri, 27 Oct 2023 13:01:45 +0300
Message-ID: <6d2992cc5acf2e72f831a7dc30274afed4995424.camel@aqsi.ru>
Subject: Re: [PATCH 15/15] ppp: message tracing
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Fri, 27 Oct 2023 15:01:42 +0500
In-Reply-To: <4a3b8f95-1c7a-4f37-9a99-8d1928d24635@gmail.com>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
	 <20231017104902.717947-15-m.lyubimov@aqsi.ru>
	 <4a3b8f95-1c7a-4f37-9a99-8d1928d24635@gmail.com>
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
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E7130633014CD31F9236DD005CCC74777830D00894C459B0CD1B9D4F4CDA2D2D10C9DDBC99B2AA8339E874AF53EBDBA55009DAEBB3C0239580454
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70186A8DAAA7CBDB1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637826327602763C04B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D818931000881223412BC97A5C6CDFF058117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC974A882099E279BDA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18BDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE26055571C92BF10FB1CA5D0BF4193578D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE32D01283D1ACF37BA6E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CD2DCF9CF1F528DBC2E808ACE2090B5E1725E5C173C3A84C3ED8438A78DFE0A9E089D37D7C0E48F6C8AA50765F7900637967A675A37A195C7EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5235EE3656AD1503688FFD8C303B60C02889A7EA54F62AB37F87CCE6106E1FC07E67D4AC08A07B9B0735DFC8FA7AC1207CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC4F83DC2DA09CC2FEDD3E69246509792A3A34D754C24786891D9FAEBA41DE0FAF31E0254ADC75A061B371662AFD121F0F595E6053CFD7EEE0DCBA2719C49521440B08DDBC5CE87D002C26D483E81D6BEF55150C44C58A03AE08F1021D1C6A886BF305B2E6CBEE040
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojf8RueeX2DcsjUcPm+st+cg==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070F49AFD47D9F05E5D68A1ED05C03FB895A57F1433D693C104B5D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B09DFC738A27773C0AADAB31483B3DEE22F560A0BB1AD42D049FFFDB7839CE9E2955125F65856E4F52F2E2064A885CC5A0326DF8CA8F7CD7C8C27D22FF0B473E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd/ps9sdOGr8il7KwpHofXuw==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Good afternoon, Denis

On 18/10/2023 в 21:22 -0500, Denis Kenzior wrote:
> On 10/17/23 05:49, MaxLyubimov wrote:
> > Added OFONO_PPP_RECORDING_PATH environment variable handling to
> > enable PPP message tracing
> > ---
> >   gatchat/gatppp.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> > index 259e6d5c..a655b35c 100644
> > --- a/gatchat/gatppp.c
> > +++ b/gatchat/gatppp.c
> > @@ -561,10 +561,16 @@ gboolean g_at_ppp_listen(GAtPPP *ppp, GAtIO
> > *io)
> >   /* Administrative Open */
> >   gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
> >   {
> > +	char* recording_path;
> > +
> >   	ppp->hdlc = g_at_hdlc_new_from_io(io);
> >   	if (ppp->hdlc == NULL)
> >   		return FALSE;
> >   
> > +	recording_path = getenv("OFONO_PPP_RECORDING_PATH");
> > +	if (recording_path)
> > +		g_at_ppp_set_recording(ppp, recording_path);
> > +
> 
> Hmm, this is better off in drivers/atmodem/gprs-context.c since you
> have an 
> OFONO_ prefix for the environment variable.

I had to call the g_at_ppp_set_recording function here, because if you
call it before g_at_ppp_open, then the ppp->hdlc variable is not
defined and the function does nothing, and if you call it after
g_at_ppp_open, then there is a possibility of losing events in the log,
because g_at_ppp_open calls functions

pppcp_signal_up(ppp->lcp);
pppcp_signal_open(ppp->lcp);
ppp_enter_phase(ppp, PPP_PHASE_ESTABLISHMENT);

What prefix should I choose for this environment variable?

Best regards,
Lyubimov Maxim



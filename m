Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326D15AC4
	for <ofono@lists.linux.dev>; Fri, 27 Oct 2023 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aqsi.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="dzg62ig9";
	dkim=pass (1024-bit key) header.d=aqsi.ru header.i=@aqsi.ru header.b="E2aKk8dQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=aWZxrg35TeYTnCxjBtsPggHUeOrSpZSa/UomUSfpFc8=;
	t=1698398005;x=1698488005; 
	b=dzg62ig9P8UcYC1MT6/LYwsk8qAq801+IQqahTwwWEIJtYOIVHzpjXqB4/MQpGEsqOnxniMJ2w5+z9OzxVZF1q77aMFxQv1IAZe+ZRVCeWyfCyUGUwriVik2sv6oNGYsjxwrVMkVbU7A5wEsGqLptPpgPM68jTgRNMhtsJly2Ww=;
Received: from [10.12.4.15] (port=40620 helo=smtp40.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwIip-005ksW-9T
	for ofono@lists.linux.dev; Fri, 27 Oct 2023 12:01:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aqsi.ru;
	s=mailru; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=aWZxrg35TeYTnCxjBtsPggHUeOrSpZSa/UomUSfpFc8=; t=1698397299; x=1698487299; 
	b=E2aKk8dQ/otz3vpAGKMTlJW2Iu45afiDZ3Mvn9QeeRJYEq3q0etE6cO1+ElEi3KgPU8R76OYW7e
	beFsFb6FR5FCVv3aERf8wZYoEzFOgrZgMFf1HnuRi74MEeQZprr20TAXGEMk9f6s23eGfYHupqN2R
	h5ulwfFrT6rjcQPx3gU=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <m.lyubimov@aqsi.ru>)
	id 1qwIif-009xIV-2C; Fri, 27 Oct 2023 12:01:30 +0300
Message-ID: <497f810bce97564712e05c2633a45fe244d93481.camel@aqsi.ru>
Subject: Re: [PATCH 03/15] plugins: adding support for the SIMCom A7605E-H
From: =?koi8-r?Q?=EC=C0=C2=C9=CD=CF=D7_?= =?koi8-r?Q?=ED=C1=CB=D3=C9=CD?=
	 <m.lyubimov@aqsi.ru>
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Date: Fri, 27 Oct 2023 14:01:26 +0500
In-Reply-To: <2d194620-ed30-4763-aced-ca89b450132c@gmail.com>
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
	 <20231017104902.717947-3-m.lyubimov@aqsi.ru>
	 <2d194620-ed30-4763-aced-ca89b450132c@gmail.com>
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
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E713028A6B45E8800B8D808196D39FA30EE0600894C459B0CD1B95759ECF79C931C89A1F83CB6833650A041A31F45EF06C344D1FFACA8F48D2A96
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE788A2BECDB72C1542EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379E90269B204C5E5D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FFED88221BFD928843D09CB3B74E7984117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC6FC43C45D3E35E8FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE26055571C92BF10F45B9AC499A3C791CD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE30A9EC8C3488E7643C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CD2DCF9CF1F528DBC2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F9E2C8583869C85776D8C47C27EEC5E9FB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A501A17A937FCFB7BB0F99C11B4FBD89F28AB6CE151B797D12F87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA588CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3463DBE2ADA183F62F859D321F466737CEF429BAA77F37CC535BE451522E541308AC45B24070B282BC1D7E09C32AA3244C592F69B24F0944DA128FFD87600C315D95A9E0DC41E9A4CF3A1A83191EB2B8F05DA084F8E80FEBD38EDF88D74BAC437670101D478F77020B37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojKQBmf2D4qoRSJyI6PSA87A==
X-Mailru-Sender: 8F0A18E209ABDF42A59E14250D05070F34FAF5E7863004C385B0F237B40C94758C74419948F709395D68521865CF3C5293AC9912533B2342953ADA4C1418A8160CF35AF5341388420FBD6B69799305375FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B09DFC738A27773C0AADAB31483B3DEE8F0D78E3A106B26A049FFFDB7839CE9E2955125F65856E4F9F92BAEBC19EE888716BEBFED45516E82EB4F3BD62DF7DDC
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd/ps9sdOGr8jlHHmY9sqEmQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok



On 18/10/2023 в 20:42 -0500, Denis Kenzior wrote:
> On 10/17/23 05:48, MaxLyubimov wrote:
> > The udevng plugin has been modified to detect the SIMCom A7605E-H
> > modem and the simcom_a76xx plugin has been added to work with it
> > ---
> >   plugins/simcom_a76xx.c | 323
> > +++++++++++++++++++++++++++++++++++++++++
> >   plugins/udevng.c       |  55 +++++++
> 
> Please see HACKING, 'Submitting patches' section, item 3.

I deliberately divided the patch into several parts so that they
affected only one directory, does this patch only affect the plugins
directory or did I understand something wrong?

> >   2 files changed, 378 insertions(+)
> >   create mode 100644 plugins/simcom_a76xx.c
> > 
> > diff --git a/plugins/simcom_a76xx.c b/plugins/simcom_a76xx.c
> > new file mode 100644
> > index 00000000..059773b5
> > --- /dev/null
> > +++ b/plugins/simcom_a76xx.c
> > @@ -0,0 +1,323 @@
> > +/*
> > + *
> > + *  oFono - Open Source Telephony
> > + *
> > + *  Copyright (C) 2008-2011  Intel Corporation. All rights
> > reserved.
> > + *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
> > + *  Copyright 2018 Purism SPC
> 
> Copyrights seem suspect?

I slightly modified the file plugins/sim7100.c, I left the copyright
unchanged

> > + *
> > + *  This program is free software; you can redistribute it and/or
> > modify
> > + *  it under the terms of the GNU General Public License version 2
> > as
> > + *  published by the Free Software Foundation.
> > + *
> > + *  This program is distributed in the hope that it will be
> > useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public
> > License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> > MA  02110-1301  USA
> > + *
> > + */
> > +
> > +/*
> > + * This file was originally copied from g1.c and
> > + * modified by Bob Ham <bob.ham@puri.sm>
> > + */
> > +
> 
> In fact this looks 95% the same to plugins/simcom7100.c.  Can we
> unify the two?

Simcom modems of the SIM7x00 and A76xx series are built on different
chips, Qualcomm and ASR, respectively, so their functionality is very
different. I may try to combine these plugins, so the commands are
generally compatible. But I don’t have a SIM7x00 series modem, so I
won’t be able to check the correctness of my modification. There is
also a question about the name of the plugin, SIM7100 is the name of a
series of modems, as well as A76xx, how to combine them in the name of
one plugin?

> Also, you still have lines > 80 chars here.

I will fix it

> <snip>
> 
> > +#ifdef HAVE_CONFIG_H> diff --git a/plugins/udevng.c
> > b/plugins/udevng.c
> > index f6580aba..7fccf670 100644
> > --- a/plugins/udevng.c
> > +++ b/plugins/udevng.c
> > @@ -1554,6 +1554,59 @@ static gboolean setup_sim7x00(struct
> > modem_info *modem)
> >   	return TRUE;
> >   }
> >   
> > +static gboolean setup_simcom_a76xx(struct modem_info *modem)
> > +{
> > +	const char *diag = NULL, *gps = NULL;
> > +	const char *mdm = NULL, *ppp = NULL;
> > +	GSList *list;
> > +
> > +	DBG("%s", modem->syspath);
> > +
> > +	for (list = modem->devices; list; list = list->next) {
> > +		struct device_info *info = list->data;
> > +		const char *subsystem =
> > +				udev_device_get_subsystem(info-
> > >udev_device);
> > +
> > +		DBG("%s %s %s %s %s %s", info->devnode, info-
> > >interface,
> > +						info->number, info-
> > >label,
> > +						info->sysattr,
> > subsystem);
> > +
> > +		/*
> > +		 * SIMCom a76xx serial port layout:
> > +		 * 2: DIAG
> > +		 * 3: NMEA
> > +		 * 4: AT
> > +		 * 5: AT/PPP
> > +		 */
> > +		if (g_strcmp0(subsystem, "tty") == 0) {
> > +			if (g_strcmp0(info->interface, "255/0/0") == 0)
> > {
> > +				if (g_strcmp0(info->number, "02") == 0)
> > +					diag = info->devnode;
> > +				else if (g_strcmp0(info->number, "03")
> > == 0)
> > +					gps = info->devnode;
> > +				else if (g_strcmp0(info->number, "04")
> > == 0)
> > +					mdm = info->devnode;
> > +				else if (g_strcmp0(info->number, "05")
> > == 0)
> > +					ppp = info->devnode;
> 
> Again, this block seems rather similar to what is in
> setup_simcom.  Just the 
> interface numbers are different.  Please unify the two.

I divided the code to make it more readable, since setup_sim7x00
configures qmi, which is not supported in simcom a76xx, and the
setup_simcom function, as far as I understand, is not used because
there is no modem driver named simcom. Which of these setup_sim7x00 or
setup_simcom functions should I use to add a simcom a76xx?

Best regards,
Lyubimov Maxim



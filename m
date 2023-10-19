Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01F38C
	for <ofono@lists.linux.dev>; Thu, 19 Oct 2023 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeZaieaP"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6c49f781855so4902274a34.3
        for <ofono@lists.linux.dev>; Wed, 18 Oct 2023 18:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697679734; x=1698284534; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4deDNf97bF0Dik6JvjSGO6llOzn2ef2zTdIvLSLTB4=;
        b=FeZaieaPLzpyrKIYkSOfh+FIA8go9g2GpyZbJFLA7sphfHXgZAr65xF9wEnEl2Cf7g
         pOpfz6NHruvakNIICKSXeDgMGa4KatIZXTd01P1jSi3MsCX6sO5bBXEyRfXxOKnWTi8y
         Oe3P58PPJ7un1RLGZmsFiY9PKgZxU0Xfppsww8NU5QYago1RSms2IHPi14jjJGGsRycX
         UGCvWOYp+aoymOnNa4gLM3aBJ2CpwwnYPYHO3+1qfXfCuYz8HOZMGLvMDL1rY5J90R0N
         qq2Fes5HtPCavxGJ2YCvFFni5umK83yFqd2DoZVWucBionB/qrMVMa2IJE79h17/44UY
         5rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697679734; x=1698284534;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4deDNf97bF0Dik6JvjSGO6llOzn2ef2zTdIvLSLTB4=;
        b=DROcoERQtxvaNPcIePd3DicrBhwrLE0Cd7xtvwGjLjSlQXL5m7VvqICX0P5/mwLaJX
         +ORoycJ5cJf0Hs64Cm9WA91i6eFEt9yGH/0q7XOAOmlp4y8IismSeq2SZv1BJkeKXCNy
         BjxiY9vcL3KruhRtdRk5FxwNnmR7DqxpOICCVSjWbmBDlrRUXUDlA3IkfTqXQ94TGMCL
         jI/ZeZ5EX2OUdE0Phmha7bwyMwCBEyO5Zc6jwPBgfoFVIoo8vOnjU35pjEH6hcPRod+T
         vGrJ5VHKvl7y0jG37B7wAhRK3S2wtlKsB89OriuT8fW4+gFKoxrr7kzvU6K1sd2LaYb4
         5HCg==
X-Gm-Message-State: AOJu0Yzx+U7Iq8wYmqdNj0HIr7aCN+J9YAG6v1UocvzoF5pzD/zcaBxx
	NbhoWKEJ4PzNCaobAzc+5PxIYWpZxBI=
X-Google-Smtp-Source: AGHT+IEabfM7xJ3dVV/YVf7RXvOLhsm24lMBfSQWQiaWKC/pmu2T9bVdO9QK+AUUKmSUZaO4joskGA==
X-Received: by 2002:a05:6830:905:b0:6bf:2476:a97e with SMTP id v5-20020a056830090500b006bf2476a97emr1120300ott.5.1697679734171;
        Wed, 18 Oct 2023 18:42:14 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a26-20020a9d6e9a000000b006bee51de9f6sm857743otr.18.2023.10.18.18.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 18:42:13 -0700 (PDT)
Message-ID: <2d194620-ed30-4763-aced-ca89b450132c@gmail.com>
Date: Wed, 18 Oct 2023 20:42:12 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] plugins: adding support for the SIMCom A7605E-H
Content-Language: en-US
To: MaxLyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20231017104902.717947-1-m.lyubimov@aqsi.ru>
 <20231017104902.717947-3-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231017104902.717947-3-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 10/17/23 05:48, MaxLyubimov wrote:
> The udevng plugin has been modified to detect the SIMCom A7605E-H modem and the simcom_a76xx plugin has been added to work with it
> ---
>   plugins/simcom_a76xx.c | 323 +++++++++++++++++++++++++++++++++++++++++
>   plugins/udevng.c       |  55 +++++++

Please see HACKING, 'Submitting patches' section, item 3.

>   2 files changed, 378 insertions(+)
>   create mode 100644 plugins/simcom_a76xx.c
> 
> diff --git a/plugins/simcom_a76xx.c b/plugins/simcom_a76xx.c
> new file mode 100644
> index 00000000..059773b5
> --- /dev/null
> +++ b/plugins/simcom_a76xx.c
> @@ -0,0 +1,323 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
> + *  Copyright 2018 Purism SPC

Copyrights seem suspect?

> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +/*
> + * This file was originally copied from g1.c and
> + * modified by Bob Ham <bob.ham@puri.sm>
> + */
> +

In fact this looks 95% the same to plugins/simcom7100.c.  Can we unify the two?

Also, you still have lines > 80 chars here.

<snip>

> +#ifdef HAVE_CONFIG_H> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index f6580aba..7fccf670 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1554,6 +1554,59 @@ static gboolean setup_sim7x00(struct modem_info *modem)
>   	return TRUE;
>   }
>   
> +static gboolean setup_simcom_a76xx(struct modem_info *modem)
> +{
> +	const char *diag = NULL, *gps = NULL;
> +	const char *mdm = NULL, *ppp = NULL;
> +	GSList *list;
> +
> +	DBG("%s", modem->syspath);
> +
> +	for (list = modem->devices; list; list = list->next) {
> +		struct device_info *info = list->data;
> +		const char *subsystem =
> +				udev_device_get_subsystem(info->udev_device);
> +
> +		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
> +						info->number, info->label,
> +						info->sysattr, subsystem);
> +
> +		/*
> +		 * SIMCom a76xx serial port layout:
> +		 * 2: DIAG
> +		 * 3: NMEA
> +		 * 4: AT
> +		 * 5: AT/PPP
> +		 */
> +		if (g_strcmp0(subsystem, "tty") == 0) {
> +			if (g_strcmp0(info->interface, "255/0/0") == 0) {
> +				if (g_strcmp0(info->number, "02") == 0)
> +					diag = info->devnode;
> +				else if (g_strcmp0(info->number, "03") == 0)
> +					gps = info->devnode;
> +				else if (g_strcmp0(info->number, "04") == 0)
> +					mdm = info->devnode;
> +				else if (g_strcmp0(info->number, "05") == 0)
> +					ppp = info->devnode;

Again, this block seems rather similar to what is in setup_simcom.  Just the 
interface numbers are different.  Please unify the two.

Regards,
-Denis

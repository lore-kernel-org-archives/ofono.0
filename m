Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8C15E9D
	for <ofono@lists.linux.dev>; Mon, 20 Nov 2023 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I70DuEnt"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5869914484fso2576486eaf.0
        for <ofono@lists.linux.dev>; Mon, 20 Nov 2023 07:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700492848; x=1701097648; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bb9Q9RVzwG3YZGWGGOVvAC/Z2aNXFs4TKNg8J9dpbp0=;
        b=I70DuEnttWlfq8XMcFBOpIU2ku2EceX6KjxBN6PZf748S0aSR//2u5Nqu61Cl98G7J
         5ZfNH0btV//BwUPSgGYacLa/6bFTzJ7tDFPeF6YTziZbOGmzxbv1ubbks2HqqXNhSmkH
         6BQu/FdK8T3fGnsVR85eXjrK/jbrp27GzlksgsUH4h1+xmY5hDf/29Uqv8/m6iap0/q/
         4/G1nUiKK1+zRL2hV2wg+Pfg8Hyi8WNd34QFdqdMsp8k5rGMXliWuD8fe/GiHYHiiP4J
         GHzV4f2jO64smUqgOXVWiAYf5I7KazYfw4qOnUJmAWF0zXD61BorE/XjDYArt+efENt4
         VR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700492848; x=1701097648;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bb9Q9RVzwG3YZGWGGOVvAC/Z2aNXFs4TKNg8J9dpbp0=;
        b=g9woPZG5U4/ZcugVuiHqygggkYwWSXksa1VXatFRjeVW8KcMGmrCKo8CkwsGN1smjG
         BSFogIeWXakZny9DMegjaMELc126svimFlPIlqI4ctQOe5OGpHlE81XOqSX939oHCWpQ
         hh3ipD8wGHdOL4I9r/DWtxFPOoZGDPMBkzif2FWxI0aLB7nsYT/8MgGSiVcceXGlMKi0
         YCBe01jZs0er2K/pnJe2dIpUcdb62D/KGLj39bRsXCJdvpDJiCBVaqLheiHeftTvlHw0
         u/YaODZfhedlL98/DeDGt+YbGwtKJaeYaxj8GJRyaeUM1FX6aKonMWwWAKtwS9ziVSFw
         er9g==
X-Gm-Message-State: AOJu0Yzao/6Z9Db5pr3pCnbAr12vXJRVmTk6gB+SfMABKsTgMBtGsLIe
	1Y2qmOS4NJ9afSnZQsQY8XzukIiWjtk=
X-Google-Smtp-Source: AGHT+IHg14hiYnQ4goqqNziE3YgMuAPcvDwA/Bh6cT1dt38BLLtLF3DHo0dvqMmRKmRbUyoBXz+fdw==
X-Received: by 2002:a05:6820:1c91:b0:589:d6c7:8573 with SMTP id ct17-20020a0568201c9100b00589d6c78573mr8861069oob.3.1700492848299;
        Mon, 20 Nov 2023 07:07:28 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s25-20020a4ae559000000b0058a010374e6sm138147oot.39.2023.11.20.07.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:07:27 -0800 (PST)
Message-ID: <c5ef782f-69fc-476e-96b7-e1814516d43d@gmail.com>
Date: Mon, 20 Nov 2023 09:07:26 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isimodem: parse extra details from REG_STATUS_IND
Content-Language: en-US
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>, ofono@lists.linux.dev
References: <20231118122948.418378-1-absicsz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231118122948.418378-1-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

On 11/18/23 06:29, Sicelo A. Mhlongo wrote:
> Extract additional operator information available in REG_STATUS_IND messages.
> These include mnc, mnc, and different variations of operator name.
> 
> Additionally, in case NET_OPER_NAME_READ_RESP is an error result, which happens
> with some operators, report the extracted information to core instead of
> bailing out.
> ---
>   drivers/isimodem/debug.c                |  1 +
>   drivers/isimodem/network-registration.c | 73 ++++++++++++++++++++++++-
>   drivers/isimodem/network.h              |  1 +
>   3 files changed, 74 insertions(+), 1 deletion(-)
> 

I do get a compiler warning here:

drivers/isimodem/network-registration.c:537:3: error: misleading indentation; 
statement is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
                 strncpy(op.name, nd->nitz_name, OFONO_MAX_OPERATOR_NAME_LENGTH);
                 ^
drivers/isimodem/network-registration.c:532:2: note: previous statement is here
         if (!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP) &&
         ^

A few nits:

> @@ -193,6 +195,12 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
>   	struct netreg_data *nd = ofono_netreg_get_data(netreg);
>   	GIsiSubBlockIter iter;
>   
> +	uint8_t len = 0;
> +	uint8_t type = 0;
> +	char *abbrev = NULL;
> +	char *an = NULL;
> +	char *fn = NULL;
> +

You set these to NULL here, but ...

>   	if (netreg == NULL || nd == NULL)
>   		return;
>   
> @@ -209,16 +217,69 @@ static void reg_status_ind_cb(const GIsiMessage *msg, void *data)
>   
>   			if (!parse_common_info(&iter, &nd->reg))
>   				return;
> +
> +			/* Parse abbreviated operator name */
> +			if (!g_isi_sb_iter_get_byte(&iter, &len, 7))
> +				return;
> +
> +			len *= 2;
> +
> +			if (!g_isi_sb_iter_get_alpha_tag(&iter, &abbrev, len, 8))
> +				return;

Is the intent really to ignore the whole message if this attribute can't be parsed?

>   			break;
>   
>   		case NET_GSM_REG_INFO:
>   
>   			if (!parse_gsm_info(&iter, &nd->gsm))
>   				return;
> +
> +			/* Parse mcc and mnc */
> +			if (!g_isi_sb_iter_get_oper_code(&iter, nd->mcc,
> +								nd->mnc, 8))
> +				return;
> +			break;
> +
> +		case NET_REG_STATUS_IND_OPER_NAME:
> +
> +			if (!g_isi_sb_iter_get_byte(&iter, &type, 2))
> +				return;
> +
> +			if (!g_isi_sb_iter_get_byte(&iter, &len, 5))
> +				return;
> +
> +			/* Name is UCS-2 encoded */
> +			len *= 2;
> +
> +			switch (type) {
> +			case 2:
> +				/*
> +				 * Alternate full name, which is similar to
> +				 * long name, but may have less whitespace
> +				 */
> +				g_isi_sb_iter_get_alpha_tag(&iter, &an, len, 6);
> +				break;
> +			case 3:
> +				/* Full name */
> +				g_isi_sb_iter_get_alpha_tag(&iter, &fn, len, 6);
> +				break;

But you don't check the error returns of these two calls

> +			}
>   			break;
>   		}
>   	}
>   
> +	if (fn[0] != '\0')
> +		strncpy(nd->nitz_name, fn, OFONO_MAX_OPERATOR_NAME_LENGTH);
> +	else if (an[0] != '\0')
> +		strncpy(nd->nitz_name, an, OFONO_MAX_OPERATOR_NAME_LENGTH);

So how do you know fn/an aren't NULL?

> +	else if (abbrev[0] != '\0')
> +		strncpy(nd->nitz_name, abbrev, OFONO_MAX_OPERATOR_NAME_LENGTH);

Use g_strlcpy instead of strncpy since it takes care of setting the terminating 
NULL.

> +
> +	nd->nitz_name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
> +
> +	g_free(an);
> +	g_free(fn);
> +	g_free(abbrev);
> +
>   	ofono_netreg_status_notify(netreg, isi_status_to_at_status(&nd->reg),
>   					nd->gsm.lac, nd->gsm.ci,
>   					isi_to_at_tech(&nd->rat, &nd->gsm));
> @@ -458,6 +519,8 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
>   {
>   	struct isi_cb_data *cbd = data;
>   	ofono_netreg_operator_cb_t cb = cbd->cb;
> +	struct ofono_netreg *netreg = cbd->user;
> +	struct netreg_data *nd = ofono_netreg_get_data(netreg);
>   	struct ofono_network_operator op;
>   
>   	GIsiSubBlockIter iter;
> @@ -468,7 +531,14 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
>   
>   	if (!check_response_status(msg, NET_OLD_OPER_NAME_READ_RESP) &&
>   			!check_response_status(msg, NET_OPER_NAME_READ_RESP))
> -		goto error;
> +		if (nd->nitz_name[0] == '\0')
> +			goto error;
> +
> +		strncpy(op.name, nd->nitz_name, OFONO_MAX_OPERATOR_NAME_LENGTH);
> +		op.name[OFONO_MAX_OPERATOR_NAME_LENGTH] = '\0';
> +		strncpy(op.mcc, nd->mcc, OFONO_MAX_MCC_LENGTH);
> +		strncpy(op.mnc, nd->mnc, OFONO_MAX_MNC_LENGTH);

ditto here, g_strlcpy.

> +		goto success;
>   
>   	for (g_isi_sb_iter_init(&iter, msg, 6);
>   			g_isi_sb_iter_is_valid(&iter);
> @@ -500,6 +570,7 @@ static void name_get_resp_cb(const GIsiMessage *msg, void *data)
>   		}
>   	}
>   
> +success:
>   	CALLBACK_WITH_SUCCESS(cb, &op, cbd->data);
>   	return;
>   

Regards,
-Denis


Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FE197A7E
	for <ofono@lists.linux.dev>; Wed,  9 Oct 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487627; cv=none; b=WSijp8rlJP87dhAZtKxcgwVsAVY90Xi2LRNme6dLoRjkBlwPDbfktsagL2x41Cdw+GF0QfuNJU0A47aAtWKxS85ioK/zY00tgjX5mSUE687FBboR5lL937g0THrekjFh/Iq7mdBfBrc7k8oLIPGfbs4zuBQe1xCWjHGY8MY0ffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487627; c=relaxed/simple;
	bh=DERreDqNGWZ+Wrm/Vaecb2+GWWoiB0ak4jhwvgyUndM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E/IME41jZ1wCDlQmvX/rI9fEqj/dkyEHYoxzTlsUu3P24wctXjgwl283jYhiE4ldrexwbJMDk5HzDrJfY9B9I50KeGCf+4Ocx4keB35/DcB/LwJLQ7jYTgfQjWI/QCtBJClTNShzcwPjQKgJFjJEFaaFdoiZjyvObmGtvKrIBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApkUTL/c; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApkUTL/c"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-715716974baso1361480a34.1
        for <ofono@lists.linux.dev>; Wed, 09 Oct 2024 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728487625; x=1729092425; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ox9nhcDjmufSDP+2Yi2OvFprO2vZi/mv0KmFimT2plU=;
        b=ApkUTL/c6DWvRkmqWBO9YelWaoHbU7cDWKtkjlQxCOiXnQtNp9wFJRbJV6fcivvcgH
         GCzbOHQNPbyOJvdQYjOtRdV6IpKb73Eezwi9VEeP7ShWCvSE/LEk0xWklZsikHqxjeMA
         aMiwByHCFhTxF04m6Rx2D6DbTMRO8gNXd5GFD3DQ0PpEEbQuUBgxpVrFxy+R/Z5z6jjx
         b3HhotCYHDyGBFIDsn1v2rTD1ZGHKsZ4d6zm+Ug3KnlPjJ8nL3Oks/ZnxyYjoNVz4oKo
         AJf4hAfjCRrHyeA805zi96rcAq211zDSKlAjqTdye8ysUxy+rl2wEhG26KHoq1GXXSQE
         SfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487625; x=1729092425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox9nhcDjmufSDP+2Yi2OvFprO2vZi/mv0KmFimT2plU=;
        b=nXOLyqOntAWSIMxMbrlGVuoKfH+gfKSoO/VBYURVNHWusZFM9jwN8Gf1SvS9+sBHVt
         u3AOw0u0JulQlAKz8xAub4Fx5ivYIntOmdJX4h30zoWdNXw843JoQ9AYpSfSWcatJidZ
         8ul+q7m57ofCRdcMhyjUDINZYzqIliWI8ErZzuI4tYzQYNFpclXiSIGWBLZqUGl0ZRbt
         3hZzG8bX6Dtuwj+NKzBKCpF6ErjhTL1DkprIePh3/dFKX4kgBaOUbmqXCQ2Kk8wharvu
         GrX0SEh4hMzb7HtZZveu3CzOtvAq3z/Hs2Dc9oNHPoZCMsaHFOLrtjtXQSOcCkAp8BrV
         3b3w==
X-Forwarded-Encrypted: i=1; AJvYcCVAakMI40d6Tlh9sdBGVQ0xEUvkp1QeV82hmg76HVvzGkX6DlgzVznUwKYKTGSNguUEAe3+KA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg4cOhiXnDSIPviZb+8gUDlwKY5rOX3H1sS57D34Y93x18+GNj
	wS1Z1ST8ISw/DRJUqyCK5geQDxCeTllqAat2ewZv4127ExoBd5HjQDzjZQ==
X-Google-Smtp-Source: AGHT+IF8U6tCoIOsvXTHmpknhDekTgv42MrOjvrjEUAlCvIfvchlpNwrYJmB6UXfVfBoquTj07sCTQ==
X-Received: by 2002:a05:6830:43a3:b0:713:c883:88d3 with SMTP id 46e09a7af769-716a41dc3b1mr2586539a34.15.1728487625320;
        Wed, 09 Oct 2024 08:27:05 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5e7d7148f40sm2399420eaf.24.2024.10.09.08.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:27:05 -0700 (PDT)
Message-ID: <8fbd4cf7-ef82-4a44-8cbb-76ee26cf0591@gmail.com>
Date: Wed, 9 Oct 2024 10:27:03 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: simcommodem: query modem for available rat
 modes
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20241008091038.1567406-1-sean@geanix.com>
 <20241008091038.1567406-2-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241008091038.1567406-2-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 10/8/24 4:10 AM, Sean Nyekjaer wrote:
> ---
> Should we default to gsm, umts + lte if the call fails?
> 
>   drivers/simcommodem/radio-settings.c | 53 +++++++++++++++++++++++++---
>   1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
> index 2a9dbaa2..2bb0d148 100644
> --- a/drivers/simcommodem/radio-settings.c
> +++ b/drivers/simcommodem/radio-settings.c
> @@ -97,6 +97,46 @@ error:
>   	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>   }
>   
> +static void cnmp_rat_support_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_radio_settings_rat_mode_query_cb_t cb = cbd->cb;
> +	struct ofono_error error;
> +	int index;
> +	GAtResultIter iter;
> +	unsigned int available_rats = 0;
> +
> +	DBG("ok %d", ok);
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		goto error;
> +	}

No {} if not needed please

> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+CNMP:")) {
> +		if (!g_at_result_iter_open_list(&iter))
> +			break;

doc/coding-style.txt item M1

> +		while (1) {
> +			if (!g_at_result_iter_next_number(&iter, &index))
> +				break;
> +			available_rats |= r_mode_to_radio_access_mode(index);

as above

> +
> +		}
> +	}
> +
> +	DBG("available_rats %d", available_rats);
> +
> +	cb(&error, available_rats, cbd->data);
> +
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +}
> +
>   static void simcom_query_rat_mode(struct ofono_radio_settings *rs,
>   				ofono_radio_settings_rat_mode_query_cb_t cb,
>   				void *data)
> @@ -169,11 +209,16 @@ static void simcom_query_available_rats(struct ofono_radio_settings *rs,
>   			ofono_radio_settings_available_rats_query_cb_t cb,
>   			void *data)
>   {
> -	unsigned int available_rats = OFONO_RADIO_ACCESS_MODE_GSM
> -				| OFONO_RADIO_ACCESS_MODE_UMTS
> -				| OFONO_RADIO_ACCESS_MODE_LTE;
> +	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +
> +	DBG("");
>   
> -	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
> +	if (g_at_chat_send(rsd->chat, "AT+CNMP=?", cnmp_prefix,
> +				cnmp_rat_support_cb, cbd, g_free) == 0) {
> +		CALLBACK_WITH_FAILURE(cb, -1, data);
> +		g_free(cbd);
> +	}
>   }
>   
>   static void cnmp_support_cb(gboolean ok, GAtResult *result, gpointer user_data)


Regards,
-Denis

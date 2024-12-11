Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5181C07C4
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894014; cv=none; b=pIWtO8IvGSb49grD8/4o8gDwFoAWXQVKOzkZqFgbysOrsa7sUTO8CmPTX4akvDTHsrPIwCnNE/0rbT2OscazeRVaTmEKkwvXKnJWdwjli1jlidP5bHGcLw3S1uKx5BIXBouX8scDGeKSF8tseq5Mt0fvxaH9eh5mqyTeSKw2NJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894014; c=relaxed/simple;
	bh=MX1GK3PgBlF0nIG8JF3xjXuXg1U5Zo0BZP0tvg/tmbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X29geoftocYpkR7/Vao8xcTyK+enTwNMc3YqgPXodo+MOk9EBFn8s6sDjmXYRrRgMyiFeNmpm+CVJItUWlUbJNcNilnlFt7Ji68qia/AU6UR9iyUbcBnQs+jJ4VFp36Ej7a3RrLXX5JxHw4lSI45HJfzn5y8eLcRYkOhcaNyzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgdmUaCY; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgdmUaCY"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29e842cb9b4so1952371fac.2
        for <ofono@lists.linux.dev>; Tue, 10 Dec 2024 21:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733894012; x=1734498812; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUXDsAL58aGPyIXPS8LRVhYTSZBwCSll5FdfgHECFD8=;
        b=FgdmUaCYcvUWBt4oAct3+IFwol5zwVyJFhL3HtqXnXbu7DL6IdE21cTB/JSOxXBLTd
         npKixHwwBi7NR5I93kH7IllTkOGV2GGAFnhueWRZR2221NhCTL19lcm0JcRvsXkx1sLc
         2eZdxOy5nINFJoSpN6xKl1U2AZLtL+qULrWk0eAVIPtAy2vIhuI4W6Pe969DSmaO3QWh
         mYO/6wm8FO8I+a36jwM5PFhsCAr3YlrmYS8584urmCFo9jl4+5aIV5nd1hm/VMaGU/QM
         k/J/dSpUR4AyKqo/wJQ901uxpsxBzNXD949sjNb0LPiuzny4ox6L06cG/h8IX9B8FoAY
         fE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894012; x=1734498812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUXDsAL58aGPyIXPS8LRVhYTSZBwCSll5FdfgHECFD8=;
        b=o0HYpt8EUocTkiCVpcmMf8Pexh5JhGv9ApoMUNXokDFErPfrv8O4GiJdmEUNxQoQX1
         GYdSdxXRoiKlupspiUZusTm4v5qtG9kpgBnWpEcwR4/vnn5xwxvgnNYHJD0Q3M5ZFS9J
         XaMdnkyjHqBv8VyhrxgfZEvrBbPuA86Pf/XCNdcZZ8Fgmsfic8L+IsbwZgcte3nrmAKX
         5772CN8GE9+j0aW/26WkME7FtPImwwwGOXW3eyf4Y8je4c8pUw11nigbZLH/G6shYARC
         inWoHtndIbOW7NcBYMGeaAGSrjuQVlABQBioATU0FrxWnsnTmEQbc7A5NMU0WwEeaH19
         sbvg==
X-Forwarded-Encrypted: i=1; AJvYcCWClFV9SlXkoFmR+OgaWoSygGzVFwA7NOWj8J/W/q/RHD3rOMdn0efL8QepozrmpxB+tDg6xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAIfobpvLaAdeNpWGGs63qMbEVB2EiBZVC+mvjm1uMgQQNfE0F
	yxjC8mTW035uICqAJDi7I+ShlIeMJMXKmKgZrhsW/y1WCNYqai0i
X-Gm-Gg: ASbGncuwHh3NxaJ5HxgyLzQOC4CqHIWuR2QMt/AFBlS2qphkQxhxUM+Oon6oYJ0ohii
	JYUhTHZe2nNsz7QtJVvlENG9n9/l/qMEGSzSBYbYWhilFAw0e/Ud8bnYg7joSJ1is4DWD4iGrbd
	9+HgMIybCgc19L9qxOQI5LG0cX7oXxKHQE8Oqp8suGSWpuU1KULkpGy2HHA9RauskGgy6CQck0z
	ma6jRXvsVj+I5ntIGZvGOUQ/UqvpXCNScpm8KnmLc4nK8Vr+rcprNKSdZl0ZcLAEtUkyT9x+WhF
	Z797UsDA6hB8ZmR/EWA=
X-Google-Smtp-Source: AGHT+IF/RZd6oE9GzPTI6MjUwWAE27+38fAgm6gyBeCwSva1a50+Toz7NrzT91YGmjfYpogzC/CTFg==
X-Received: by 2002:a05:6870:ec8d:b0:29e:5897:e9d1 with SMTP id 586e51a60fabf-2a012fab91amr780829fac.39.1733894011685;
        Tue, 10 Dec 2024 21:13:31 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-29fd371f34csm1681820fac.19.2024.12.10.21.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 21:13:31 -0800 (PST)
Message-ID: <acedcbad-dd01-4423-9fb7-3c90081ca5a7@gmail.com>
Date: Tue, 10 Dec 2024 23:13:29 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: radio-settings: Do not unconditionally try to enable
 unsupported modes
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20241207172050.191314-1-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241207172050.191314-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 12/7/24 11:20 AM, Ivaylo Dimitrov wrote:
> At least the modem in Motorola Droid 4 errors out if anything else but GSM
> and UMTS bits are set when selecting preferred mode. That happens if 'any'
> mode is set.
> 
> Fix that by querying supported modes and passing only those for 'any' mode.
> ---
>   drivers/qmimodem/radio-settings.c | 97 +++++++++++++++++++++++++++++--
>   drivers/qmimodem/util.h           | 19 +++---
>   2 files changed, 104 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
> index cf0b747e..b62a87d0 100644
> --- a/drivers/qmimodem/radio-settings.c
> +++ b/drivers/qmimodem/radio-settings.c

<snip>

> @@ -136,14 +142,91 @@ static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
>   	l_free(cbd);
>   }
>   
> +static void get_rat_mode_any_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct rat_mode_any_data *data = user_data;
> +	struct cb_data *cbd = &data->cbd;
> +	struct ofono_radio_settings *rs = cbd->user;
> +	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
> +	const struct qmi_dms_device_caps *caps;
> +	uint16_t len;
> +	uint8_t i;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL))
> +		goto error;
> +
> +	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
> +	if (!caps)
> +		goto error;
> +
> +	for (i = 0; i < caps->radio_if_count; i++) {
> +		switch (caps->radio_if[i]) {
> +		case QMI_DMS_RADIO_IF_GSM:
> +			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_GSM;
> +			break;
> +		case QMI_DMS_RADIO_IF_UMTS:
> +			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_UMTS;
> +			break;
> +		case QMI_DMS_RADIO_IF_LTE:
> +			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_LTE;
> +			break;
> +		}
> +	}

This looks like copy-paste of get_caps_cb.  Lets avoid that by invoking 
QMI_DMS_GET_CAPS during probe().  See below.

> +
> +error:
> +	/* last resort */
> +	if (rsd->rat_mode_any == 0)
> +		rsd->rat_mode_any = QMI_NAS_RAT_MODE_PREF_ANY;
> +
> +	_set_rat_mode(rs, data->mode, cbd->cb, cbd->data);
> +}
> +
> +static bool get_rat_mode_any(struct ofono_radio_settings *rs, unsigned int mode,
> +			ofono_radio_settings_rat_mode_set_cb_t cb,
> +			void *user_data)
> +{
> +	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
> +	struct rat_mode_any_data *data = l_new(struct rat_mode_any_data, 1);
> +	struct cb_data *cbd = cb_data_init(&data->cbd, cb, user_data);
> +
> +	if (!rsd->dms)
> +		goto error;
> +
> +	cbd->user = rs;
> +	data->mode = mode;
> +
> +	if (qmi_service_send(rsd->dms, QMI_DMS_GET_CAPS, NULL,
> +					get_rat_mode_any_cb, data, l_free) > 0)
> +		return true;
> +
> +error:
> +	l_free(data);
> +	rsd->rat_mode_any = QMI_NAS_RAT_MODE_PREF_ANY;
> +	return false;
> +}
> +
> +static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
> +			ofono_radio_settings_rat_mode_set_cb_t cb,
> +			void *user_data)
> +{
> +	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
> +
> +	if (rsd->rat_mode_any || !get_rat_mode_any(rs, mode, cb, user_data))

So your intent here is to query the radio capabilities first if they haven't 
been queried before?  If so, then the typical pattern is to do this during 
probe(), before calling ofono_radio_settings_register().  See qmimodem/lte.c for 
an example.

> +		_set_rat_mode(rs, mode, cb, user_data);
> +}
> +
>   static void get_caps_cb(struct qmi_result *result, void *user_data)
>   {
>   	struct cb_data *cbd = user_data;
> +	struct ofono_radio_settings *rs = cbd->user;
> +	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
>   	ofono_radio_settings_available_rats_query_cb_t cb = cbd->cb;
>   	const struct qmi_dms_device_caps *caps;
> -	unsigned int available_rats;
>   	uint16_t len;
>   	uint8_t i;
> +	unsigned int available_rats;

Why is 'available_rats' being moved?

>   
>   	DBG("");
>   
> @@ -155,16 +238,20 @@ static void get_caps_cb(struct qmi_result *result, void *user_data)
>   		goto error;
>   
>   	available_rats = 0;
> +
>   	for (i = 0; i < caps->radio_if_count; i++) {
>   		switch (caps->radio_if[i]) {
>   		case QMI_DMS_RADIO_IF_GSM:
>   			available_rats |= OFONO_RADIO_ACCESS_MODE_GSM;
> +			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_GSM;
>   			break;
>   		case QMI_DMS_RADIO_IF_UMTS:
>   			available_rats |= OFONO_RADIO_ACCESS_MODE_UMTS;
> +			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_UMTS;
>   			break;
>   		case QMI_DMS_RADIO_IF_LTE:
>   			available_rats |= OFONO_RADIO_ACCESS_MODE_LTE;
> +			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_LTE;
>   			break;
>   		}
>   	}

Wouldn't it be easier to simply do
rsd->rat_mode_any = available_rats?

> diff --git a/drivers/qmimodem/util.h b/drivers/qmimodem/util.h
> index 58bf4f98..14d4d865 100644
> --- a/drivers/qmimodem/util.h
> +++ b/drivers/qmimodem/util.h
> @@ -14,17 +14,20 @@ struct cb_data {
>   	int ref;
>   };
>   
> -static inline struct cb_data *cb_data_new(void *cb, void *data)
> +static inline struct cb_data *cb_data_init(struct cb_data *cbd, void *cb,
> +						void *data)
>   {
> -	struct cb_data *ret;
> +	cbd->cb = cb;
> +	cbd->data = data;
> +	cbd->user = NULL;
> +	cbd->ref = 1;
>   
> -	ret = l_new(struct cb_data, 1);
> -	ret->cb = cb;
> -	ret->data = data;
> -	ret->user = NULL;
> -	ret->ref = 1;
> +	return cbd;
> +}
>   
> -	return ret;
> +static inline struct cb_data *cb_data_new(void *cb, void *data)
> +{
> +	return cb_data_init(l_new(struct cb_data, 1), cb, data);
>   }
>   
>   static inline struct cb_data *cb_data_ref(struct cb_data *cbd)

You likely don't need any of this...

Regards,
-Denis

Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E181BE852
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948883; cv=none; b=kfa7zUcWMuLD3q3N1kbhLhGXjYHGM2NQ3OXSRrCR+Ivvgw3pJP/BVQ2G5p6T99dHOAj6WgNDdoP0IPxrcWMSjiNK9PBqa9VmCD0G3r4YdMTMsnJiwJxBktpDhR6trb9KAxo2gHZWc/8ebI6bkgyrih9MWpy9pcHHevF9Fi0kMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948883; c=relaxed/simple;
	bh=rAfhxGVkUklig/gdo74J4uvFSAveBJPz8GqBlEljRV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZeVMFL/32U2jTP8qYKecK1F/nhWKuBXev/457HTpCMYtbb7fkaFd0RxM5J3Zzh3+5sHFli+RbIcoDvXbVDmoCfgmIpqIG+FblwdL7mUiDEb44XklhKh7/+ReHdQsyEpEpnNvS8I6qlpSMjXI2WsBdm10KkGrA+mTIDePqc/8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgPzhy9G; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgPzhy9G"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee354637b4so2646325eaf.3
        for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 08:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731948881; x=1732553681; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8SeyxVUxV4qVGRqS7KKbPqXpZMi8J0RiezzF3qpcgI=;
        b=ZgPzhy9G9OkYp3xAxkENmpZjdz3GtRYRoxnsvbKe9F+rteNqCP5JRxluibBvmGae+B
         xJwB3FLz2Qs5Sq1THjvE+NTny3JtvuoGKX/8GL59r0OrlchoVHJgYZ6auA0KPGpXZl4a
         Y6/yA9BnWnfPEwtCs0ePLWyacPYgn7pOXtBfjs0mmYierzzgjI9aa2z/XEawgegigUSo
         LyhAXowJApQ7MeW5vJtEnJmVDFIzXHYf9UhtOy9vvcgs1AqPX83H42ABL4zsFneQlEXn
         MiDqArRi9wvEJX8j/+wVIxYs4hB3MKdch4h/vE7LuDLglryRLB9D/KbjRNBKpZ++s8af
         yXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948881; x=1732553681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8SeyxVUxV4qVGRqS7KKbPqXpZMi8J0RiezzF3qpcgI=;
        b=iHd6uSvuNIZnD5o0mIEAL7u0mDTjLO+aQMFB2JGj5yHT4xXnI7K3DBLexwj7jnS6hs
         Ns90RP3hRzsLF8BHrbSjFgTQ9A5N2KFhlP9IDJIifOw718aEO66m3E7z2KGnyQKZT0Rj
         9jH28amhYkWxRcBG5qEcj72ooLVW6Mzm7IyCGpzDNK/DB5YNWX4yZRnDV4WmCcLEOCZ+
         8uW/hDjSu4DTxJEI2tFdWOO353SnjlzrQOMPVlKI8T2j5yPI/9o8qCXtKuAW7/+4+KHo
         VfN2C1Ky2YQDMFJgNe/MhGz01nbnWIgMO3llwa2AJoMwdrlQBzEDtEDxaN3SYaNyoqXH
         fv9w==
X-Forwarded-Encrypted: i=1; AJvYcCVUvOeiQjSxhVGzWAZbWBO/7LHGehB4ioxceZxibBXez6wk8ifXmdx3d3x69X4o3rWlbxx50Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzKS5JTdgd4/BrrZpCULyCwgCho2Aitn1PhSI3gRaWwF//711t
	7WKqvO01O060ZYVT5qxmHMSdNZQpJxFa5PB+l9PwW0O2u6reZ4HC0+LDew==
X-Google-Smtp-Source: AGHT+IFzWIL2FrRPFPt+D/at+pbOTTkxm6ujNPRMpt+R63giG3k/BvVza/SjpnvKUZ6c2zF1v/vETQ==
X-Received: by 2002:a05:6820:1e82:b0:5eb:c6ba:796d with SMTP id 006d021491bc7-5eeab2bc8eamr9858678eaf.1.1731948880676;
        Mon, 18 Nov 2024 08:54:40 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm2894927eaf.39.2024.11.18.08.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:54:40 -0800 (PST)
Message-ID: <fb513766-cec4-48c0-977a-a4457b6021cf@gmail.com>
Date: Mon, 18 Nov 2024 10:54:38 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: sim: implement lock(LockPin method)
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 11/17/24 6:03 AM, Ivaylo Dimitrov wrote:
> ---
>   drivers/qmimodem/sim.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/uim.h |  1 +
>   2 files changed, 71 insertions(+)

Looks like this patch is on top of the query_facility_lock.  Please send these 
as a series in the future, otherwise the CI gets confused.

> 
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index b1d8f22..65c0fa6 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -844,6 +844,75 @@ static void qmi_query_locked(struct ofono_sim *sim,
>   	l_free(cbd);
>   }
>   
> +static void qmi_lock(struct ofono_sim *sim,
> +		enum ofono_sim_password_type passwd_type,
> +		int enable, const char *passwd,
> +		ofono_sim_lock_unlock_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data = ofono_sim_get_data(sim);
> +	struct cb_data *cbd = cb_data_new(cb, user_data);
> +	int passwd_len;
> +	uint16_t info_len;
> +	uint8_t pin_id;
> +	struct qmi_param *param;
> +	uint8_t session[2];
> +	struct {
> +		uint8_t id;
> +		uint8_t enabled;
> +		uint8_t length;
> +		uint8_t pin[0];
> +	} __attribute__((__packed__)) *info;
> +
> +	DBG("");
> +
> +	switch (passwd_type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +		pin_id = 0x01;
> +		break;
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +		pin_id = 0x02;
> +		break;
> +	default:
> +		goto error;
> +	}
> +
> +	if (!passwd)
> +		goto error;
> +
> +	passwd_len = strlen(passwd);
> +
> +	if (passwd_len <= 0 || passwd_len > 0xFF)

strlen returns a size_t, so checking < 0 doesn't really make sense.  Also, the 
core already performs validation of the pin using 'is_valid_pin'.  So I'm not 
really sure any of this validation is needed?

> +		goto error;
> +
> +	param = qmi_param_new();
> +
> +	/* info */
> +	info_len = sizeof(*info) + passwd_len;
> +	info = alloca(info_len);
> +	info->id = pin_id;
> +	info->enabled = enable ? 0x01 : 0x00;
> +	info->length = (uint8_t) passwd_len;
> +	memcpy(info->pin, passwd, passwd_len);
> +
> +	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, info_len, info);
> +
> +	/* session */
> +	session[0] = 0x6; /* card on slot 1 */
> +	session[1] = 0x0;

Hmm, can we get some #defines for these magic numbers? Or static const variable 
declaration?

> +	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO,
> +					sizeof(session), session);
> +
> +	if (qmi_service_send(data->uim, QMI_UIM_ENABLE_PIN, param,
> +					pin_send_cb, cbd, cb_data_unref) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +	l_free(cbd);
> +}
> +
>   static void get_card_status_cb(struct qmi_result *result, void *user_data)
>   {
>   	struct ofono_sim *sim = user_data;
> @@ -987,6 +1056,7 @@ static const struct ofono_sim_driver driver = {
>   	.query_pin_retries	= qmi_query_pin_retries,
>   	.send_passwd		= qmi_pin_send,
>   	.query_facility_lock	= qmi_query_locked,
> +	.lock			= qmi_lock,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)
> diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
> index 439e25b..602ec0f 100644
> --- a/drivers/qmimodem/uim.h
> +++ b/drivers/qmimodem/uim.h
> @@ -11,6 +11,7 @@
>   #define QMI_UIM_WRITE_RECORD		35	/* Write a record */
>   #define QMI_UIM_GET_FILE_ATTRIBUTES	36	/* Get file attributes */
>   
> +#define QMI_UIM_ENABLE_PIN		37	/* Set PIN protection */
>   #define QMI_UIM_VERIFY_PIN		38	/* Verify PIN */
>   
>   #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */

Otherwise, LGTM.

Regards,
-Denis

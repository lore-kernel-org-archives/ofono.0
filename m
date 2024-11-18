Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A21B21A0
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948214; cv=none; b=Fk0j84tnVhQiRY5eP2ivw3aRr0NV3XE8MgMTTb+KhMX2Wi3o8x2188z2xccEd24uZciNX9rs9Liicw5CMQNWnstzV9z2sRWq5xEPnb6Yh/jkWynQgRG3Dn5Yo6RGzMGhLKTsGMkPbpwXT3ISUqAFVxp6THBt9hzriU9fiype90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948214; c=relaxed/simple;
	bh=O/1A1+BOsL+PGcAVZj4kayEniyjsWB/sQMACfXJ2TUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ4cQTHatzAwdI9E6HTqVXM5dzl85oMbf/CuVoHYad0Ht2MUDaCAvFKkOWi4vsMOyHzixZ1wwzuzojEzF5LRY6VzHYwojXKxpKj4qQNBYOOf7s85V7c73lbh5QwyzSFRk8quE9bm3H7FBs/BuhNWSCZPtl1erSd7yanaKY+6Ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPNtePnz; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPNtePnz"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-296085d59caso35313fac.0
        for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731948212; x=1732553012; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0LJc4Tr74i7FtNi6kA9fFDWChN2hJa1btLgCIaJH58=;
        b=gPNtePnz2kiw5lw4oArOCqj3AIMD4Ds4IGttdleIBc863J2rtPx6Zru3mL5NHrgB8O
         S89OKwP/QuWH9PV1Bcn/gOUU6WPPxr9q8hvhBucTwmQRqoPqj+KnSP+fI3PcpROtPH0p
         1CfqxU1FtS23IsdH8xxty7elGWinNTKTOIpn9nANs/hEGnjELI77hvw8uv4g/0rpEPRp
         U1iiiqhW1hLh1La5M0d9oKqMJReH2Uj6HPtpfaR9FueC1prVnqeBfluJlnqZ1ntEPdv7
         3FzknPGSmzq7DuxVddCithYiPrY9HHq0iV0ZVVEWS1MxdrRxFDF/3AJA84qrJ6ivC1IP
         hZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948212; x=1732553012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0LJc4Tr74i7FtNi6kA9fFDWChN2hJa1btLgCIaJH58=;
        b=Ye+jX9L+CpbFNtlME+DFdE2ON1trxzP5xT7jjXF1UsFQohyrrIG5ACSK/FiEJu9dGd
         vzVfEza8dDi0k1LgnBf8YyXtXOkYNfjjDJ+koTI0bSP78MXbYc/RW1UDjF1EVdnykdJ/
         Hy/5YWas+1ugv9Y1/z2FKYi5rTxDLSe6bJqyUPy0mOIAb5nNNE+TZgTAQ8t+9bSc7tUN
         TmyqH0qHwhgBxSBBy8/1QXDTWSr7K2pKEgPY8iXVU4vCwH6sXuozw6JLth4PYVTacPRY
         2Zp1BKy5j4dtClaDl8s1904lDpPGFKQ85heAYcF7Fagr5smCW7XFA0Vio9bAIuQHm49e
         zlWw==
X-Forwarded-Encrypted: i=1; AJvYcCXp118f2I52ReYIcy+LcCOW+N98+Pidh/Nd/tF7WPa2cNyqSssxVzA5uowDVHX8Iqx7IS4szQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfzIerASox/SXNmEotXRZWzMSaMNThk59uh4ZFKeEixGtb+bUM
	AtoIfFeVk0emnDJuzEtTaLW9qEEEvfXOngsRJl7/Jr/1YTHGSJIY
X-Google-Smtp-Source: AGHT+IHimekgDMiXexirjnqMq2hsSB/GMY/x35B5V1g2LqVb59PAtXRTPc5gjH6Z2xDi81HGncjLYw==
X-Received: by 2002:a05:6871:780f:b0:277:c216:5273 with SMTP id 586e51a60fabf-2962dddbc5amr10366570fac.18.1731948212262;
        Mon, 18 Nov 2024 08:43:32 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71a77e3d11csm2852686a34.0.2024.11.18.08.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:43:31 -0800 (PST)
Message-ID: <908f9eab-6dbb-429c-b35f-f81cdda2088c@gmail.com>
Date: Mon, 18 Nov 2024 10:43:30 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: sim: Implement query_facility_lock(LockedPins
 property)
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1731841478-10479-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1731841478-10479-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 11/17/24 5:04 AM, Ivaylo Dimitrov wrote:
> ---
>   drivers/qmimodem/sim.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
> 
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index 1fffae2..b1d8f22 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -41,6 +41,8 @@ struct sim_status {
>   	uint8_t app_type;
>   	uint8_t passwd_state;
>   	int retries[OFONO_SIM_PASSWORD_INVALID];
> +	uint8_t pin1_state;
> +	uint8_t pin2_state;
>   };
>   
>   struct sim_data {
> @@ -52,6 +54,20 @@ struct sim_data {
>   	struct l_timeout *retry_timer;
>   };
>   
> +struct query_locked_data {
> +	enum ofono_sim_password_type passwd_type;
> +};

Why is this structure needed?  Can't you simply stuff this into cb_data::user 
using L_UINT_TO_PTR and L_PTR_TO_UINT?

> +
> +static inline void cb_user_data_unref(void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +
> +	if (cbd->ref == 1 && cbd->user)
> +		l_free(cbd->user);
> +
> +	cb_data_unref(user_data);
> +}
> +

That way this could also be dropped

>   static int create_fileid_data(uint8_t app_type, int fileid,
>   					const unsigned char *path,
>   					unsigned int path_len,
> @@ -486,6 +502,9 @@ static bool get_card_status(const struct qmi_uim_slot_info *slot,
>   		break;
>   	}
>   
> +	sim_stat->pin1_state = info2->pin1_state;
> +	sim_stat->pin2_state = info2->pin2_state;
> +
>   	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PIN] = info2->pin1_retries;
>   	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PUK] = info2->puk1_retries;
>   
> @@ -752,6 +771,79 @@ error:
>   	l_free(cbd);
>   }
>   
> +static void query_locked_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_query_facility_lock_cb_t cb = cbd->cb;
> +	struct query_locked_data *qld = cbd->user;
> +	struct sim_status sim_stat;
> +	uint8_t pin_state;
> +	gboolean status;
> +
> +	DBG("");
> +
> +	if (handle_get_card_status_result(result, &sim_stat) !=
> +					GET_CARD_STATUS_RESULT_OK) {
> +		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +		return;
> +	}
> +
> +	if (qld->passwd_type == OFONO_SIM_PASSWORD_SIM_PIN)
> +		pin_state = sim_stat.pin1_state;
> +	else
> +		pin_state = sim_stat.pin2_state;
> +
> +	switch (pin_state) {
> +	case 1: /* Enabled and not verified */
> +	case 2: /* Enabled and verified */
> +		status = TRUE;
> +		break;
> +	case 0: /* Unknown */
> +	case 3: /* Disabled */
> +	case 4: /* Blocked */
> +	case 5: /* Permanently blocked */
> +	default:
> +		status = FALSE;
> +		break;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
> +}
> +
> +static void qmi_query_locked(struct ofono_sim *sim,
> +			enum ofono_sim_password_type passwd_type,
> +			ofono_query_facility_lock_cb_t cb, void *user_data)
> +{
> +	struct sim_data *data = ofono_sim_get_data(sim);
> +	struct cb_data *cbd = cb_data_new(cb, user_data);
> +	struct query_locked_data *qld;
> +
> +	DBG("");
> +
> +	switch (passwd_type) {
> +	case OFONO_SIM_PASSWORD_SIM_PIN:
> +	case OFONO_SIM_PASSWORD_SIM_PIN2:
> +		break;
> +	default:
> +		CALLBACK_WITH_CME_ERROR(cb, 4, -1, cbd->data);
> +		l_free(cbd);
> +		return;
> +	}
> +
> +	qld = l_new(struct query_locked_data, 1);
> +	qld->passwd_type = passwd_type;
> +	cbd->user = qld;
> +
> +	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
> +			query_locked_cb, cbd, cb_user_data_unref) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +
> +	l_free(qld);
> +	l_free(cbd);
> +}
> +
>   static void get_card_status_cb(struct qmi_result *result, void *user_data)
>   {
>   	struct ofono_sim *sim = user_data;
> @@ -894,6 +986,7 @@ static const struct ofono_sim_driver driver = {
>   	.query_passwd_state	= qmi_query_passwd_state,
>   	.query_pin_retries	= qmi_query_pin_retries,
>   	.send_passwd		= qmi_pin_send,
> +	.query_facility_lock	= qmi_query_locked,
>   };
>   
>   OFONO_ATOM_DRIVER_BUILTIN(sim, qmimodem, &driver)

Rest LGTM.

Regards,
-Denis

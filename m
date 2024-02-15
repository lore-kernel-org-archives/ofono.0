Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC4139560
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029981; cv=none; b=T9KKGDCMQtcYTgJceCev/tcDrnlYK5V1So/Jc/lsjUK0IdRolRkNeDqgAaa65LXw7/ez2MUDMERxx9jHlfcDVr+wP6JI/D0iuf25x2WqPQqOzTTtZDduP4D6Yf+6V6EJx0RSQRc2AKiKz97ETjXX5x6QFN3V2DTn9nL3Ij81kLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029981; c=relaxed/simple;
	bh=vpbqZYkeIInFWAmZlmwAUugHPK/ucBiB/CxGfzCec2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNNhkCJ1C8XVSe7WL7oxa5ezYSovHobmB/jm4kmWWnHty40zsQmVWMkNBNfkE0y85Wxq4L/szFAYasigCGqeHKLXA3p/0NYWwzvpqLnfRr/i+w205zy6SXP4/bkypXxrx7ZvDkzvWvfO9S4sH/O9HLNDTLz9p8wuBlyySDew3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2o6W4LE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2o6W4LE"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c031a077d5so245b6e.0
        for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029979; x=1708634779; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdMiRcrGehtUKG9nw2XNiWN0cpj9bikhQLOf1+697CA=;
        b=U2o6W4LEePUcgxgzZ+2oJFzQpEmH8QTKI7ZbCzHvjkwE0+UetxOFywuNWwnRA3Mtc/
         idUWHFryOBs+GBtDF08IDD92nR1TkkwzCHUVQvwwJ46Y1dFPyZ7R7XOe12+ocUFwRpkf
         QT87j/bGg3a97SVHly7Y4SI17IGvo7vNT5T1r+Pl8q5HkmBtYrJQxodq+bG/25ZGV8aF
         w7zxYJiripIUSeWnI2C+4quxkYbL4kM+Q6HwQaqkZZrUawSd0XTXJ7nLc5ZBMyVwY+f1
         PJ696zkhiq4x0n9Vlf1MqvMoYiWA3IpklJNsIkp7JNn2tj51xvdm+Iea7rx2hwdM6ogX
         gWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029979; x=1708634779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdMiRcrGehtUKG9nw2XNiWN0cpj9bikhQLOf1+697CA=;
        b=m0NcntT9hl/3aZGGRAopNCFQP0hl68sHatNd97bkMLySJFXx8Gnv4Ra3SpPF9jjTa5
         Q3DuaGF6Sy211dYPsWgxIuDpl6a+kbNVAzzt7VMXC8BhLpsOp7JUHA1qt+/5LhoYBzre
         N5MZNY9N349Nou+OQLXkt3GOrcvmQDsXKksQO60klwXqCQzeeEOVRShDN2K2OnCugX56
         OL/yQPsAzSTDUU/7AYZswiY8OzdIeCYnB5/Jdo61eXBJaPbw25FWGBU6oFvOjoktkdXB
         pjaB3URjrUJsd6YV5DAz6vZh/eb1ANSla5SulLDmF/0+mKM9b8Y0bg9ElIhhXLwGBn2C
         pVyg==
X-Forwarded-Encrypted: i=1; AJvYcCUxHp8HygN8ZQjuact+jKXCyznYaJ6s15FArU5mVZbFZUeGvsjW/2h6Cah/4wkCv2txEDAQ36lmWTHV69oYRI4ne7G8hxs=
X-Gm-Message-State: AOJu0Yw3JK2p3oJR1hOCqNf+iDeAOYqlMhzY/7nXgT9QtTC/3oz6op+T
	5BYPAeIICiK7YpsxUjJ9AmYRdwimw+ELXNk/XK1xNAucb9RdC/dV
X-Google-Smtp-Source: AGHT+IHFoT3woIxYUEPYhpJeYdNVfz3Y8EruLzoTxN5aP1l7C2t8Zd6DtqukerX/Fx8uhEmF+fhYcw==
X-Received: by 2002:a05:6808:10cb:b0:3c0:368a:35bd with SMTP id s11-20020a05680810cb00b003c0368a35bdmr3436079ois.29.1708029978787;
        Thu, 15 Feb 2024 12:46:18 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ec26-20020a056808639a00b003c1393395fesm213066oib.47.2024.02.15.12.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 12:46:18 -0800 (PST)
Message-ID: <7dc5103a-ec8b-47c7-9ddf-2be524701d20@gmail.com>
Date: Thu, 15 Feb 2024 14:46:17 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qmimodem: implement call-forwarding driver
Content-Language: en-US
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1707981467-2955-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1707981467-2955-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 2/15/24 01:17, Ivaylo Dimitrov wrote:
> ---
>   Makefile.am                        |   3 +-
>   drivers/qmimodem/call-forwarding.c | 352 +++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/voice.h           |   1 +

I fixed up a small whitespace warning flagged by CI:
0002-qmimodem-implement-call-forwarding-driver.patch:394: WARNING: please, no 
space before tabs

>   plugins/gobi.c                     |   3 +
>   4 files changed, 358 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/qmimodem/call-forwarding.c
> 

<snip>

> +
> +struct call_forwarding_info_ext {
> +	uint8_t active;
> +	uint8_t cls;
> +	uint8_t time;
> +	uint8_t pind;
> +	uint8_t sind;
> +	uint8_t type;
> +	uint8_t plan;
> +	uint8_t len;
> +	uint8_t number[0];

Also, changed this to number[] due to:

0002-qmimodem-implement-call-forwarding-driver.patch:80: ERROR: Use C99 flexible 
arrays - see 
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

> +};
> +

<snip>

> +static void query_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	ofono_call_forwarding_query_cb_t cb = cbd->cb;
> +	const uint8_t *p;
> +	uint8_t num;
> +	uint16_t length;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL))
> +		goto error;
> +
> +	/*
> +	 * we want extended info, because of the number type.
> +	 * FIXME - shall we fallback to 0x10 if there is no extended info?
> +	 */
> +	p = qmi_result_get(result, 0x16, &length);
> +	if (p) {
> +		struct ofono_call_forwarding_condition *list;
> +		const uint8_t *end = p + length;
> +		int i;
> +
> +		num = *p++;

Can length be 0?  If so, feel free to send a fix :)

> +
> +		list = g_new0(struct ofono_call_forwarding_condition, num);
> +
> +		for (i = 0; i < num; i++) {
> +			struct call_forwarding_info_ext *info = (void *)p;
> +			int type;
> +
> +			/* do not try to access beyond buffer end */
> +			if (p + sizeof(*info) > end ||
> +					p + sizeof(*info) + info->len > end) {
> +				g_free(list);
> +				goto error;
> +			}
> +
> +			if (info->type == 1)
> +				type = OFONO_NUMBER_TYPE_INTERNATIONAL;
> +			else
> +				type = OFONO_NUMBER_TYPE_UNKNOWN;
> +
> +			set_fwd_cond(&list[i], info->active, info->cls,
> +					info->time, type, info->number,
> +					info->len);
> +			p += sizeof(*info) + info->len;
> +		}
> +
> +		CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
> +		g_free(list);
> +		return;
> +	}
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
> +}
> +

Applied, thanks.

Regards,
-Denis


Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4E25B2F0
	for <ofono@lists.linux.dev>; Wed, 25 Jun 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859069; cv=none; b=lv+YpNm8WO0JiMjUS+u5lv0F1L9i2B2XcL4Jakk1n/2HScomfO5+yLRyc3l64Uj4I3G5nwWCQMkV0xJvmEJfZYpnXY7EGMu1QlVyGkKhePZPl8/i83Y+m7ngSChDpBnjmudrzy/R9+js6ldf5gs1rtOdAvwTFfzvOWtD3KYWzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859069; c=relaxed/simple;
	bh=Z5fkIp8LNha9/rzBCMi5tOAe49AjPPDOVOppbqIAKH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y1CHuyCS9DMoznzLtS3YEx0ABW+vjJC6+8+s3ARCQh3hM4NgSRknFY+76omF0ADDFwnA2qnWl30fL3W9JND6MJ3AtVQM4hr198s8a9B521qwpFcXaY4dHGGldE5BgqP9pfH875LBcxIno3W5FczMAXS32Pf7ekPpEw/6kcJAEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXXUervV; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXUervV"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e9071e3706so3660633fac.0
        for <ofono@lists.linux.dev>; Wed, 25 Jun 2025 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859067; x=1751463867; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCwjoQHErnHiSbl0WOpqFPw1kdfXaOoAThIStX2NgFU=;
        b=GXXUervV9oJqJKaNgtUO2vlaaKfi+Ule+RHa7AKHeltmPhA80dZ+4hnjXJ6McH8HIM
         wl/mIrCHOnRMpoUukyyqd0bnp9JyI5FctLlu3e/+7bS4CSJBxCkwouISxWo26u9nRF3b
         SPN3SD8Hi6/ohTb3BPLqAnNU4Agst4pg5aqk6Qbxp2uUgW+nCREITcyV11pSkjWOciiN
         VRr09i/R2B4GI914sLeZ4HOKkAr0rj2+292rbc+mJwBaVHPKVqayftxom+Oi7drzuktU
         dGj7GTOvTJrlgdDQVvOWJcdhO7h37iRaYGEfVL2ZZBbJeH7xKYs+aKRjVi+rZCgasCd3
         qygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859067; x=1751463867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCwjoQHErnHiSbl0WOpqFPw1kdfXaOoAThIStX2NgFU=;
        b=jkHDQMY3HjCdEQK4y2Gbfi+rlcVn5VyKxta/QzkQ36YF29OYCk0/W6e3bOT6Lfo3u5
         u/mIEjXocp2uOdBKf5nVXfgUzHh4mqNTFFG8CpGeTsleFgtYeX+/dC/0RycmquWFeKVt
         BSS3yXf6KzvTJT8SteRcyAsjrPdcnOPSj45sL13R1lT3n6LHDNmO4a5A2q1AQNuK2/HL
         zP/jJkGGIkp6LGDduKCgxZyudeMLVx6Zw1TWWgm0VHKUOTvafltfzRQImhqO04ZLt0mK
         /rIADCcdhZhbKbLKuqI6FozRYz7MqtwhjKS02wmK8QEKi5VDpwJNs3BZE4cQXdwb2/LT
         YI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdZwL8nVerycdJioDDSXcbbk+xxcUE/4gAumr9P2OvueCCipEW6qV4f1okZmTTNBCp+82TJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNwwPRy5OGPdqby0DlCFVC7nFEdStP1GHQVRnLI9TcImyB43V1
	GqsNBf6Ww178NeCc0hx2L8vWK8zyskKM+bXU43PiJ92oEZwGheHNhi4kGiKNxg==
X-Gm-Gg: ASbGncvurBzeory7UzGmWNml58ac3BA9Ky3LIYl2cYwR2IKmPTB9dgYfXBsuM8qBaz6
	whEKfI2c3cPUWeaXX2tzDlW9Kw7ctE42Xh8BBUTGJoIXJyFaoBPLA5VtA3Y8Zo29EUFZDhU+EzK
	eShGoN4X44ug6Msp75f8ZT5cb3OJcdjGFpJM89JxDEMW+kgzQmLuoFkvMMThDpJVc5Ktk6A5pec
	O+rgnfZ2u7W8XlXzLoe+WRkw+7ZGGJRanlzZaTmBEgNVx2bZNB0BD05LhkDtYcjGsMpYVLqKCQc
	U+DD6/EAj/xrZaqgK45IcYUFWflj7bFda1x/NHC3kD0y4KkuJOYC6szxi9iKqJe9eKpNlvDke7V
	T2CMkhhot41jzbHIhq3FIuiJdPGSXGw/JlJHYZA==
X-Google-Smtp-Source: AGHT+IFXYvoY6zhDSO5HQtdGyzjEDOrjM4oM9G6RC2PmUcZjeKpysDtTnvf2DwD9dG5od4krWtrqOw==
X-Received: by 2002:a05:6870:af88:b0:2c2:c92a:5789 with SMTP id 586e51a60fabf-2efb21346b8mr2352247fac.5.1750859067085;
        Wed, 25 Jun 2025 06:44:27 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2ee66559db2sm2539871fac.11.2025.06.25.06.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:44:26 -0700 (PDT)
Message-ID: <11534cc4-8f69-4b67-bd89-0dff7ea9388a@gmail.com>
Date: Wed, 25 Jun 2025 08:44:24 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sim7100: query until AT channel is ready
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250617092656.1530528-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250617092656.1530528-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 6/17/25 4:26 AM, Sean Nyekjaer wrote:
> It's seen that the AT channel contains unknown data upon power on.
> Query the modem until it answers with OK. Create a timer to re-issue
> the AT command at regular intervals until the modem answers OK.
> 
> plugins/sim7100.c:sim7100_enable()
> plugins/sim7100.c:open_device() devkey=AT
> src/modem.c:get_modem_property() modem 0x261f20 property AT
> plugins/sim7100.c:open_device() devkey=PPP
> src/modem.c:get_modem_property() modem 0x261f20 property PPP
> AT: > AT\r
> AT: < \r\r*A
> PPP: < \r\r*A
> AT: < AT\r
> plugins/sim7100.c:init_timeout_cb() 0x261f20
> AT: > AT\r
> AT: < AT\r
> AT: < \r\nOK\r\n
> AT: > ATE0Q0V1\r
> AT: < ATE0Q0V1\r\r\nOK\r\n
> AT: > AT+CGMM\r
> AT: < \r\nA7672E-FASE\r\n\r\nOK\r\n
> plugins/sim7100.c:cgmm_cb() modem model: A7672E-FASE
> plugins/sim7100.c:cgmm_cb() before CFUN
> AT: > AT+CFUN=4\r
> AT: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> PPP: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
> AT: < \r\nOK\r\n
> plugins/sim7100.c:cfun_set_on_cb()
> src/modem.c:modem_change_state() old state: 0, new state: 1
> ---
> Changes since v1:
>   - removed double empty line
>   - Remove timeout in remove()
>   - Simplified open_device()
> 
>   plugins/sim7100.c | 64 ++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 55 insertions(+), 9 deletions(-)
> 

<snip>

Looks good.  Just one thing to fixup I think:

> +static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
> +{
> +	struct ofono_modem *modem = user_data;
> +	struct sim7100_data *data = ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	if (data->init_count++ >= 30) {
> +		ofono_error("failed to init modem after 30 attempts");
> +		close_serial(modem);

When you hit this condition, you should delete / NULL the timeout and tell oFono 
core that the power up failed.  Something like:

l_timeout_remove();
data->init_timeout = NULL;
ofono_modem_set_powered(modem, FALSE);

Otherwise, when you try to power up the modem again, .enable() will be called 
again, and you will leak the timeout.

> +		return;
> +	}
> +
> +	g_at_chat_retry(data->at, data->init_cmd);
> +	l_timeout_modify_ms(timeout, 500);
> +}
> +
>   static int open_device(struct ofono_modem *modem, char *devkey, GAtChat **chat)
>   {
>   	DBG("devkey=%s", devkey);

Regards,
-Denis

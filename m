Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E111FCC74
	for <ofono@lists.linux.dev>; Wed,  9 Oct 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488857; cv=none; b=Lj79D3Z+CCPgzViB+s+p1Q5PorJYXpqWbWMNmWlZcV37ucuGAH5qkbvRm8ECiWVgDhWBx7AfVwBxzB33phIDe9VQyHSsZo8FUgjvHlQAKrHp5npGks2A2rghe1u+f5H0rLZFBsBIvC4IiOeHI/P57xYDIQ0ucwmHqFsx3VJnHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488857; c=relaxed/simple;
	bh=PIT5PVFy9oytCpseP1SayLuwjS0UJJz+AcPlQkMc1C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HKn8n7Nh85RC734ERIh0L/7MiJCC9EAbYlNzD4meiCAv/+ZXckmw8+kf3UM7CSFyi/zLxW6a+nsgA+8XuBqBvZ7URep7id65BNvAvgathSFsMewKyjKWdmim84ZXJOWIHJoHhDQLan9Z0tJMDZapqj6b93AZb+NRA2t8Ol6DNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7vnB0yS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7vnB0yS"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e9876999a9so535081eaf.3
        for <ofono@lists.linux.dev>; Wed, 09 Oct 2024 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488855; x=1729093655; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfwGjYYPceDTPBp6WEzAnnrvdyh+jOzKbqk6S2PvhKo=;
        b=H7vnB0ySfYfF6Yu1W7PbSwffDKH8KWnY2A6RDoA+rhd9YwTJ2ttyGt75ge+m7MYViR
         f2h7pvwuNfiLir65eeTX528HVRcr5MxzgkhWHe/aBPhUA4rGS+JF9ugWwL8UgSvxzxPq
         w+xcWpyT+yxY3Xwo/cu/2FaAQcEYEI7G+/6aP6pRs6Z0qRXKrYg/DhS9WDBp7WHa1Hyg
         LTo0qCVgaJL7kjbZlmXq0alDDFp68mJrjUJ+JkmYdq/gzCwItamIYuwwXFbmJAXdD6VD
         7a+hu+rwhA+NfEVPS9GXzkGRt0S8KRrh2HjC0J8aP3wZnKLxhknxlj90OVEaQJxPFYhT
         v40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488855; x=1729093655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfwGjYYPceDTPBp6WEzAnnrvdyh+jOzKbqk6S2PvhKo=;
        b=dqpTC6dFJQYQq3EZyhN3JROdF7ycfK868vFR78c+h7qLisRRQzeAsSffmaDgvL9LEa
         9SLJGqZNovD7D0TNZP2JtnWlNVTm5c/CPw66C8WpztXDQPoikLcjdrMei7ibXsdxL8yW
         Z3QV5ysAqwQ4vi6Wl1U8ELXGy4GR3zFsNC5TBkQ7eisxPQBUwGn5XNI27M6E8nj5d53K
         ZPzl4OutOteWiYlSYSpvl6ar6smtsRN0F11XQRCyLDIzLspA4c7fxBNpfy2KSfjECraq
         LjGhXLzDKAH+BPV9Rm36BxnpZrUw3x2loCGDf3mMgpHhe8XduqeUpvTOt6h2lCqE97P1
         bTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+5ksR5fuiHeN7qESlwW0UoLWJugyXKwwHCnZaVCEU2uU9gsOQS5HBOl0eJZio1esfnOYPbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoeQ52AZzSdc9lVuAezacGeu7uiAYDxS5bMNL/eA2W2BtnfbBL
	tNEEEw7zalyabCsQHsFrMokRSkSRHYjG3DEm0+Lsa7xjpD3u9OJQ
X-Google-Smtp-Source: AGHT+IEVoRYcruBuIjO5qJhBC7zgGxGXTM2lxbVKxYZ4CPOC8Z1mCtMBhHOkLyCDH1yVBhL8qNm7HA==
X-Received: by 2002:a05:6871:890:b0:270:205a:4070 with SMTP id 586e51a60fabf-288342bc7eamr2114350fac.14.1728488854801;
        Wed, 09 Oct 2024 08:47:34 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-28825d0777asm843956fac.45.2024.10.09.08.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:47:34 -0700 (PDT)
Message-ID: <51d4c953-000f-47e5-8179-63c10e5e708d@gmail.com>
Date: Wed, 9 Oct 2024 10:47:33 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] atmodem: let +COPS: report access technology
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20241008091009.1567305-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241008091009.1567305-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 10/8/24 4:10 AM, Sean Nyekjaer wrote:
> When using the SIMCom A7672E-FASE in gsm mode, gsm is never reported as
> access technology. Fix this by letting +COPS: report it.
> ---
> For EUTRAN networks at_creg_cb() is setting the correct technology.
> But as I read it, CREG doesn't differentiate between GSM and UMTS.
> Can we fix this by using the technology from +COPS: ?
> 
>   drivers/atmodem/network-registration.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
> index 46b8512a..ccd01234 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -353,6 +353,9 @@ static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   	op.status = 2;
>   	op.tech = tech;
>   
> +	/* Set current access technology */
> +	nd->tech = tech;
> +

Maybe behind a vendor check with an explanation?  COPS isn't really meant to be 
used for this as it can contain the cell capabilities rather than the actual 
registration technology.

>   	DBG("cops_cb: %s, %s %s %d", name, nd->mcc, nd->mnc, tech);
>   
>   	cb(&error, &op, cbd->data);

Regards,
-Denis

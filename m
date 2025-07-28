Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6E846C
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713586; cv=none; b=mlLRA19/2x4/2NyAiUG7yAFCi+FvoAmuU0nD/5H56pJOSvwG62AnCjD9LxDne5sCeKhAK2LG/t6w2Af4ee72dvjsOt+9jhFdkQ3vqcElKjBn9WJxv4qdjqwLS3207VYygi4F0byHlHP26waRZ42z04+eKXc1Bo2ArlGbB4zTSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713586; c=relaxed/simple;
	bh=esmjgmwTKhxM9Hcv7c6Y7XGDvNX/f+sXC62xDKgjWmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViiFq9NFvPREG4vrUIhDwI2/0sEJws9bi06Ls6nMHImwIw/YH5/8G67wIxg7XgBeK3GM+533d4mg9T69d5fbkn6jvP8CxualsI9p7Mig699kZEJt42GhZaf6rAwbFwrwz1AIeu1AmaWNZ1fl/o0pChakvtpWUWF//2dp9QF6v5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr1FwQX9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr1FwQX9"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30008553e7eso1976042fac.2
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753713583; x=1754318383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oR/k2RwG32t29RN8dDOZ2UgqtN5MMO+BM7eYmOrXEiw=;
        b=Nr1FwQX9k9UL0xX92xQkkb6pmczaxwjj2D5aHDdVf0Q2WLN8IMU469xUPvUYBVuPEY
         r3a6zUYkHe0qo82QMqspfUxVmu+yzWngCcO9x8/bJI/Dy/QXKs26NtBzLrSGihUPLKgC
         +CzW5n61AO6MI+VEdIVoYFWzRsgtlBiLqYnihAQFtHHUxWxMZwOEZyZALjjpBEK9xbaY
         Xahr4UmvvFTodYVFAraJgrCR2nZanG2M6YnsjKLrh4B0yHEhgRx3UnwZyTvzQYovqy6x
         HiYyxaowjWIuP1dptkRphRXh94H5gZtIXoJtPVgBpjOCPFSTp8hKHAo9WcQaRk6I1v8i
         0XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713583; x=1754318383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oR/k2RwG32t29RN8dDOZ2UgqtN5MMO+BM7eYmOrXEiw=;
        b=wbOKa+PklFem2Byzd+A+Ua/HswN+iKPXDmFjDlCwTJpQgkdJZvPzKYTtwrSfY6Iy8p
         RO+4ErXnsNNAafHMoBq5JGrWQsY78/trEqpKyTn7ewcIve9mvuAmP5IgiCirYSIRxqEg
         8mFdv3o3IrlzrzBKZ/rqitrSBUAOmy23ipYxK0k1L8a86B9iX4AfmzFlIuSj/euGp/Bp
         wN5p/gnCJQblzrzwmCNlUVw4ma1a3riT1NRPjMr5RHOvR1dx0wxMx5H2V4z4PZGFkLmM
         0QdmS9f232BnHFS06ZsB52+Q/XV5dOhgYIBrn0TSkY3KL07BEKCvqncQ4zP1J1TQnbi3
         gLag==
X-Forwarded-Encrypted: i=1; AJvYcCUk2v1PayUZr7JzAsTDIGBmEhGbP5njs2eraZ4BjT3DFnaIMBEWjttZS9U7jerA2jqraVt1tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YweFJsWq4Tkc5uqKOneJjvTNpZsUjehhPbR+U7ZyCMTYkh2EeoT
	9RuA+4EXMrDVNdxltkQaAoVVX7fEJvGGKUGX4H/iBNBEGMcrEa80bk2s
X-Gm-Gg: ASbGnctMtJPyDPPnlu5u+5+3LlyR4ptODeWo9fMtwCek8Kvn5N3ZZ4a/hJuPmCrtsOM
	4c4k07Gj88t0eFvkv/xKe4TeF1GSd+fw6ICamhFqtYoTAbpc8kiSdO3SAlDH3i+rxvIg73mef0f
	L24hPH035e0uyn/zAJnzM3iXizEkZ0OLHKR4bOGJFX0TLrnzL0P0i4Vk0x9KMWUZT+DcwYqXR89
	8wWA/KPT6Uo87SoZEJC2Zqioy3lddMv9YBvG5sqIeYSv/dgDtqQvwf6BZUNbtVhVZZcCzm4+Cmd
	CsOxBVc1NlYiQKuaz0IpDZoXWSSWfkgAiAExfV+MWNA2nUjhI39ATboaJtd5RlDjQIYmKrMCOo4
	RCGNX6oPxSWjbyXLQP7v1bb5MDLO20MV4KKuLibzL8g+gVWBHVkxkwfNQdAexlxkUVY8XBOWBtg
	E=
X-Google-Smtp-Source: AGHT+IE08s162Ucjja/Xzetv/vdgKlB5RtTbc7x1gdEXt4huJQzgPsCiRZOEACzY2emkkHZLza2DcQ==
X-Received: by 2002:a05:6870:249c:b0:2d4:e29d:5297 with SMTP id 586e51a60fabf-30701fa9619mr7490873fac.29.1753713582833;
        Mon, 28 Jul 2025 07:39:42 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-307132ade3csm1672555fac.17.2025.07.28.07.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:39:42 -0700 (PDT)
Message-ID: <63de4b6f-9af8-4bfb-b97e-8d5c7d53e53a@gmail.com>
Date: Mon, 28 Jul 2025 09:39:41 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when
 disabling modem
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
 <20250725121954.650668-2-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250725121954.650668-2-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivo,

On 7/25/25 7:19 AM, Ivaylo Dimitrov wrote:
> We don't want modem to auto wake-up when
> ---
>   plugins/gobi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 52ead377..027c4dba 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -442,7 +442,7 @@ static void get_oper_mode_cb(struct qmi_result *result, void *user_data)
>   	switch (data->oper_mode) {
>   	case QMI_DMS_OPER_MODE_ONLINE:
>   		param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> -					QMI_DMS_OPER_MODE_LOW_POWER);
> +					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);

Not so sure about this.  In the past we've had problems with some QMI modems 
either not honoring this mode, or turning off entirely (my memory is fuzzy 
here).   Perhaps we can make this an attribute as well and let hardware 
detection logic set the low power mode to use?  Similar to how you handle LTE 
capability in patch 5?

>   		if (!param) {
>   			shutdown_device(modem);
>   			return;
> @@ -922,7 +922,7 @@ static int gobi_disable(struct ofono_modem *modem)
>   		goto out;
>   
>   	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
> -					QMI_DMS_OPER_MODE_LOW_POWER);
> +					QMI_DMS_OPER_MODE_PERSIST_LOW_POWER);
>   	if (!param)
>   		return -ENOMEM;
>   

Regards,
-Denis

Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1B1E1C19
	for <ofono@lists.linux.dev>; Wed,  9 Oct 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487257; cv=none; b=oFdWEG/LBIYK0G6Th8SJYSmYmXQnMrZLTAITBDnsFf1uIsN3NCFj6rvGnywbieDM9LhwGxMraVf01Ghg7lYh2xWIdBF657smtoOCe3kWf96j+3bJZ6iVp8ZQ1ZvOR1ynA+BzJ37B88gq2eqfDMVXwsb1GJbTBbw/gPvxD/TV5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487257; c=relaxed/simple;
	bh=mot0fVBRoJpdAKz+VxHXQkEzO3OQr4AqzM/5a0Hi9jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QKzkMGu7+ACYFa9fbvsyQDKPISuQmD3HP4+xPl/xKrNiFn0K8ZUme0DIQevmRsmv5WY679kHIwQJ4nD1XnS9KMlY3EnoDezKn3LSR2yEdQNd+9qiCYrPROW5fT+V/ZH3/6NCOvfAGeTJLZIdwNycCxC0J1iAyV15lXd36wD1yBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEFdvSVW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEFdvSVW"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e411aff454so475281b6e.1
        for <ofono@lists.linux.dev>; Wed, 09 Oct 2024 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728487255; x=1729092055; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8pbFXwfjfcZQULs/GLCfvPWB1q/CYhVQ29f6psnuos=;
        b=hEFdvSVWsxrMZ+gKraS8Rt9SRTPHSoTMYYY/6UIAKvlHQiLyZ+qSIsdgFvPXOc45Gw
         g+IDXZWcZRGlKHEFagD33rRNvjP95V8PR/J0wLqEl4eO4Ruke/EMEEYSzm8W4WPxQFsd
         6Fe5wiUU/O80bJm4Qva+NFry+jk449b2exGNzwEwQ6mWdasrFuxKa/mtvd4IJPkE7Q7O
         pcGXlHYeQctRIfiOn3fuz7nmE2Srjq0OmJAWOBvmJfMCkDpHi8Wn/pQTv+O4rk0etsoo
         Qic0kLPv6BX2PmaufIhiobBbZWpKKOMBKs2gsAYcTgQz4zFxOl30B1CZKTdec30pPwBw
         aq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487255; x=1729092055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8pbFXwfjfcZQULs/GLCfvPWB1q/CYhVQ29f6psnuos=;
        b=aP9Q21+Sm0Nqc2pd9gkkKh1pnVOhO5gkJm0+B5tP5uGzvdF9bu04OyZQL4w2E0nNOh
         BY6TxUiJYSE0lPSUz7IROkQtpzRLGQa6ZyBGJMEdV4ZZ16khp00T0Un3pZSSt6L4idiF
         T4ThwN0wgTlAooU1ilH+++pUAEjelk7lRwWh8hyr3fVycZJKBJnyRKNTjv7fx/fiDxTn
         h/gHDtsJ0LbjqO4anAjbLiZXWUh6nGjtjYGJbVYwOeblhIJYqSDWCZ/TqvIKdnXN3kLs
         rna2HXXVey0M4GDKKj7d2CNTuQYqjiLF9HoH3/Yr2HxVLJ88m8vSWeThnTBoW5fl9oa+
         u2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVFpaXOZxr5kd68n1RX3E7zaR3W1bak53OpLcFpFb06Xaxm39xvr9aKJulW6QCX+Q1NPjWQhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeOcMmMcqZ0uX5B1YkZJyQxhbeOimnLpwV+QCvsa20cfNPwWkp
	hPmpguMF2IGRNNjxp1EDNRQccMBD5v4w7WH10uIxm8pvFvm2EY2bnawWjA==
X-Google-Smtp-Source: AGHT+IFHSlsoMfmQRbGUV8n9Tf3+KUfCjMV6Ldw/LBiSjRrx0D8aL+6DS2+TtAi6CR58bHIXb++W0g==
X-Received: by 2002:a05:6870:d107:b0:270:130f:cee8 with SMTP id 586e51a60fabf-28834386cdfmr2250334fac.6.1728487255351;
        Wed, 09 Oct 2024 08:20:55 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2883c2de252sm284578fac.53.2024.10.09.08.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:20:54 -0700 (PDT)
Message-ID: <e907f07a-fbf2-4c34-acb4-b0c92a2815b9@gmail.com>
Date: Wed, 9 Oct 2024 10:20:53 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers: simcommodem: create rat to radio_access_mode
 function
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20241008091038.1567406-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241008091038.1567406-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 10/8/24 4:10 AM, Sean Nyekjaer wrote:
> This is done in preparation for querying available rat modes
> ---
>   drivers/simcommodem/radio-settings.c | 44 +++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 17 deletions(-)
> 

CI complains about this set:

Build Failed:
drivers/simcommodem/radio-settings.c:36:5: error: no previous declaration for 
'r_mode_to_radio_access_mode' [-Werror=missing-declarations]
36 | int r_mode_to_radio_access_mode(int r_mode)
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/simcommodem/radio-settings.c: In function 'cnmp_query_cb':
drivers/simcommodem/radio-settings.c:89:18: error: comparison of unsigned 
expression in '< 0' is always false [-Werror=type-limits]
89 | if (mode < 0)
| ^
cc1: all warnings being treated as errors
make[1]: *** [Makefile:4073: drivers/simcommodem/radio-settings.o] Error 1
make[1]: Target 'all-am' not remade because of errors.
make: *** [Makefile:2383: all] Error 2

> diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
> index 0feba960..2a9dbaa2 100644
> --- a/drivers/simcommodem/radio-settings.c
> +++ b/drivers/simcommodem/radio-settings.c
> @@ -33,6 +33,30 @@ struct radio_settings_data {
>   	GAtChat *chat;
>   };
>   
> +int r_mode_to_radio_access_mode(int r_mode)

Naming might need some work.  Maybe cnmp_mode_to_radio_access_mode?

> +{
> +	int mode;
> +
> +	switch (r_mode) {
> +	case 2:
> +		mode = OFONO_RADIO_ACCESS_MODE_ANY;
> +		break;
> +	case 13:
> +		mode = OFONO_RADIO_ACCESS_MODE_GSM;
> +		break;
> +	case 14:
> +		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
> +		break;
> +	case 38:
> +		mode = OFONO_RADIO_ACCESS_MODE_LTE;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	return mode;
> +}
> +
>   static void cnmp_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   {
>   	struct cb_data *cbd = user_data;
> @@ -61,23 +85,9 @@ static void cnmp_query_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   
>   	DBG("r_mode %d", r_mode);
>   
> -	switch (r_mode) {
> -	case 2:
> -		mode = OFONO_RADIO_ACCESS_MODE_ANY;
> -		break;
> -	case 13:
> -		mode = OFONO_RADIO_ACCESS_MODE_GSM;
> -		break;
> -	case 14:
> -		mode = OFONO_RADIO_ACCESS_MODE_UMTS;
> -		break;
> -	case 38:
> -		mode = OFONO_RADIO_ACCESS_MODE_LTE;
> -		break;
> -	default:
> -		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> -		return;
> -	}
> +	mode = r_mode_to_radio_access_mode(r_mode);
> +	if (mode < 0)
> +		goto error;
>   
>   	cb(&error, mode, cbd->data);
>   

Regards,
-Denis

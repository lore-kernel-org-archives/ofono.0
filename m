Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8A1F9F7C
	for <ofono@lists.linux.dev>; Mon,  5 May 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461246; cv=none; b=Awl1HMh8fZlv08wsDolOeXuyhuh12loo6/HbqRcnBC9yqyNeEWsH78IQFhiXd3ulaKW7yqLkmQR/HkFMwgdPoMHVcSm3dc+uH2qU2hBykOPWOwVZ4bAagHbTFLWn/+GwYuqG9DTsGrNnzVffZDz9VOg8XzC0MIWghdQnAwSFAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461246; c=relaxed/simple;
	bh=6bc23EkDBrOkK3+0ygBiCAasCgBjU5Ut/iNiwa8YMhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f2G9ENoOHXERhE6KL8Avd/H5bkx4EThzvk4Q32NYFinNujdqb7kHvAECWieWPmMtM5hrQgNyWtvsE+5QEzP8SdywaRNUGDlQJObNkUsK/x4MiO/5wJfmFucM53nYOLl6XVDpMKDm3Qy7T4dL+o5Wv+43zEXCmUvHJ1NZuUXgs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoI/Ftfm; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoI/Ftfm"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6060a70ba80so2393012eaf.2
        for <ofono@lists.linux.dev>; Mon, 05 May 2025 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746461244; x=1747066044; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/bAiJddqEeW/QlwY1ntrfUpETrfvNPLsBrpj9QucqU=;
        b=JoI/FtfmaHJpc/HGqz95q6EmP1emdli6MbYYcOTMOG4bxMkab2r0MDRA1Fi1yOLofX
         EbXT6eueU8Dw1V03JukLdqYpZgy+pJIX6kM9NtDroTHLQY37JnvUmvtg48ssc5qvj4jI
         SXtU94VlbsQlqM7mEtET2gkctH6ZnDwx9jmjgBKsFdsVYYhaB396Q4eOIiVsAg/VWN3j
         Xsicrs7EDqTUyFZTYkWZDU5AHXvoCbNqh0BKp8WOkhT16B+U/KokM1gKMCAbgqIsI7CQ
         gJ+fH3cn8X/lrXNZLlP0JfoD+EB1YZEBqT+RkexvFUKoCNydWuyb9iQaVQz9mrHM6IRF
         /JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746461244; x=1747066044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/bAiJddqEeW/QlwY1ntrfUpETrfvNPLsBrpj9QucqU=;
        b=jbLQU+QNWEVi9OJVfOnCOsFQ+Nv/CswVRUACB/CdEtK3iFZSiVI7mthkmPR1XVp/5F
         Z98UWjX4LZvv/klRSdNIddnoCJH2ZZVIr3+qCzvsrxDi2vMRhq1qDCkAfCGH+BTEDTC5
         ZWUuOnfYTeELMb03CMYnbSmLB64Q59nQhXoyln/o+HjT/X/krB37egR0vr5a5duuDdm9
         m5teVKSMXjhB5Xe6nByGbIo4QP9Y6ZXMumGG0tevMs1H8nQlL23xKoYeF6Ghz82+F+nb
         kmsWUA1MIZQWLB0VGdMjvPicaulXxxRWOhLJ9pAmxl7xd7VIxAvsflNh8XQJ+ic2IT4j
         gJYA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDdiU4ukS/mnrMDIf2qrPV8aT9EnfcTooPfEiZ/nBQRSRFLWaXhUzw+kfF8CA7x7BjBISRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQWga9EsmIuEU/T4EQHv8G7aIwp1jRClSdthOThHsY0ehPzvAa
	9xey6nCn5rV6J7wvOchZuSvpvlbU62Ck2IPB7U9fngByoAEPEfVX4b9XVA==
X-Gm-Gg: ASbGnctVlOiabe0+aflAOVDPl3v7Z9WS2N3nVrhHUi3hI33vTpcKzsUXpN5r3Iv65t/
	VyYlzxBCrKjEi2PMIDVUfEuuqtCTsngiULDoMrqUwGOQlzJbvk5klPP+B911EKYgnYw2T215NcX
	fM7uWFDF/r3oV8pjyIAr6gQM+4wQXxSng46+agfFDHU2y3vQD6mrav5bJbNDohQAJ8u0mINWtaq
	YPwp3w2KYLfQOhEZ3HMZZAD6uPz2OZKzsE1z89I7nLUbbNNNTdCg257yQB7fcT0mtuqbzNLYDpS
	GO8NHxlTTPWm2KpHEJED7Eh7nSXP21ZfH7SqtAB3eCf4GXd/W4juiXPl6nizTXzpv69oQnQFchl
	L6Rx/Xw==
X-Google-Smtp-Source: AGHT+IEIhJ1GEbHWY01kRsg17oHO/01OkpDcfRfaYnXMCll0aawUkccOcb2AwQwHQfbHZZ1jKPoE/w==
X-Received: by 2002:a05:6820:208:b0:606:894b:fd23 with SMTP id 006d021491bc7-608002d2d3bmr5233874eaf.4.1746461244406;
        Mon, 05 May 2025 09:07:24 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-731d31a251esm1580985a34.10.2025.05.05.09.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 09:07:23 -0700 (PDT)
Message-ID: <01fc54f4-a031-4050-ac20-620bb879debb@gmail.com>
Date: Mon, 5 May 2025 11:07:23 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mbim: fetch MBIM version on init
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>,
 ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-4-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250504191931.7078-4-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 5/4/25 2:19 PM, Muhammad Asif wrote:
> ---
>   plugins/mbim.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/plugins/mbim.c b/plugins/mbim.c
> index e1d33f47..3a1942da 100644
> --- a/plugins/mbim.c
> +++ b/plugins/mbim.c
> @@ -287,6 +287,8 @@ static int mbim_enable(struct ofono_modem *modem)
>   					mbim_device_closed, modem, NULL);
>   	mbim_device_set_debug(md->device, mbim_debug, "MBIM:", NULL);
>   
> +	mbim_device_get_version(md->device);
> +

I think you need to invoke this after mbim_device_ready() has been invoked.

>   	return -EINPROGRESS;
>   }
>   

Regards,
-Denis

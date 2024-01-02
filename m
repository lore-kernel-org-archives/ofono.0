Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C415495
	for <ofono@lists.linux.dev>; Tue,  2 Jan 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdI5WWAk"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2053f5e97b2so1370262fac.3
        for <ofono@lists.linux.dev>; Tue, 02 Jan 2024 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704215968; x=1704820768; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExUKSO8hi3/uKZLJ+SBcq96S+e5gl8wvRUh9FFQiCyQ=;
        b=IdI5WWAk0LJPmX70Q+qtMDfD1hZvsjH1V0j9Ja8E3Hp0lfK/CXV2/Z7zuyHdU5uhTm
         aBQ+BAe9ImdkI/EKW5yfX8QCJSjyEpuFnMze3NwnvuP+1s6o2aO615LGqJnJcCCIEZur
         gdJE/5TNurR/9jjJsRg6v+MTf7at2tnliC8CN9qVIX6IqkQRNiGob3118ZZ8leYReHJv
         mak8JfLuBxGgR8IKX/kvRxoxFbLZdfK2x1YAxCf1JO8E2R70aI5leSyuja8+VX5U5r5F
         EjXUEZZCvWkGG2LNBQpteisPf/7BqomeSupCcywpQQCnLUTrHNr9GRHgJKyyCUIC4fZU
         HFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215968; x=1704820768;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExUKSO8hi3/uKZLJ+SBcq96S+e5gl8wvRUh9FFQiCyQ=;
        b=oiuPylOcUGFM0swUhGd3BK4JVfcHdM8j2TNkIMAmSoOLyHE+sdqWfiUq3U5F39qM8e
         c55SdH9Wd+2Gd1Szr5vQNikt5u12rZD00kzrrXv2lRGFrZtNUiH/50V+TYNxKi++ZU2o
         O+/O+ctCHJ/s/V+B6Mefj+U6o8YZb10RWgJjaoPeTulHy7O9aa2mKMge99DE1VWEa3BC
         aCcJ9b2DwfoDoqAZxIhGSZQ33aCMw27pELnaEWMeXSvT3GfK1xNnx+oEFc9+FEvTb1ka
         uqbrP1n//Vtb5S9Pkd+fVkfjFMhsXdDTy8PxtcfdTr3JP+R3wAkFNs13OZIj6lgVl3xk
         oVcg==
X-Gm-Message-State: AOJu0YyrseOpWWkgD4AfLm4hxkuy8xN6ce77bDXDYjE5W0MGwn/wGsCH
	GVkcp9cInhfF3GSQ3fcyZkaSt2tDos0=
X-Google-Smtp-Source: AGHT+IE+Pu+CnA58kcwLMG+tRmQLD6HGYFyKAamZPLg4o6JLP/cf8si0Gynbj19jX2HVLy3rqE7l7w==
X-Received: by 2002:a05:6870:1f15:b0:204:5c6a:4e18 with SMTP id pd21-20020a0568701f1500b002045c6a4e18mr20969860oab.2.1704215968164;
        Tue, 02 Jan 2024 09:19:28 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id ti10-20020a056871890a00b0020316ca60a6sm5689927oab.1.2024.01.02.09.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:19:27 -0800 (PST)
Message-ID: <349e7ecb-fd29-4fda-84dd-712e10f8b0d8@gmail.com>
Date: Tue, 2 Jan 2024 11:19:27 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] smsutil: Validate the length of the address field
Content-Language: en-US
To: Denis Grigorev <d.grigorev@omp.ru>, ofono@lists.linux.dev
References: <20231228095152.68478-1-d.grigorev@omp.ru>
 <20231229103004.78670-1-d.grigorev@omp.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231229103004.78670-1-d.grigorev@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 12/29/23 04:30, Denis Grigorev wrote:
> This addresses CVE-2023-4233.
> ---
>   v1 -> v2: Validate Address-Length instead of comparing with mem size.
>   v2 -> v3: Remove extra space
> 
>   src/smsutil.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 

Applied, thanks.

Regards,
-Denis


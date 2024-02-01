Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391275F489
	for <ofono@lists.linux.dev>; Thu,  1 Feb 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799499; cv=none; b=morl05jtfap9QdOPQq4WNBo+OL820WzOxi57DExCzO4AoLO6oiXxnpqE68qrhYukDuGiBlFWG+rOSnrubKWqszgO+bw454J1GHXGnlBMuXPc78kr0mwxT1mkRMUj4j2j2pCcVo9NSvUems0/y93rg7WXrA4lODkS7f6dydk+YS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799499; c=relaxed/simple;
	bh=RbRbsE5VHTnw+eErmzffprssyezGnugGjiKPrxJQDq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOI220WaVAW2RwdAiKF1ytbirhOLflHZEl6WPU9uWt/wniCL8Qz0ceF3QYszvEL7s6tVQ7nLH+lm4dsJR5kKTlJCeCd5hXUtWjZH/MTXkuayZsOQPUVEnHk+AU+tvMU6Ki/4pRmUhuvx9nfajp6NDDqsVS8/Ip5oRgwo7jOYzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AncMmEE+; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AncMmEE+"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59a146e8c85so536897eaf.0
        for <ofono@lists.linux.dev>; Thu, 01 Feb 2024 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706799497; x=1707404297; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7ri/JZHGXirBrwJXw1x6mBUiLGvuB1ssTX9PwfKNM4=;
        b=AncMmEE+RcsrTA6Cx6FkEzWcvHIEHWYhNCxLMNU52JbP+rPbByKLgkwt+zVPDB9tBb
         5gBitSkuBhIgSeXVyZxH8Ltml6NYCpEg4j4zEuUM9CBXuxukaw9wwLBa0wJEGLIuTumq
         1mGl3zXP2xG5cFh91ziAcPDOUlEepU7FravHw//Zcjpv/iGWXifkuvjqfsyd+qOvKdJG
         ndQz9dULnjw8QTnGLAjuupf3peHonLxQn+9FnreCt5phSWopM8yJHISWd1c/LyHwlBuL
         GIwuzXQK/USLBIdpkwsD+kjWNK/hL3UgI+jKv8I1kg017fiDXtBSsDMUA2ID7ZYes6k1
         +h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799497; x=1707404297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7ri/JZHGXirBrwJXw1x6mBUiLGvuB1ssTX9PwfKNM4=;
        b=B+0BteBvSi/v08aGeqLyAZLGWI30BHKgcj3/+Rvh8nI9KzeKfzjnVNGfH75Ndyek9V
         WToVWLS+7yGgJYkbtNLRZkjjAMpSlRBt7LUrhYBHqf/Maiiu+DmD61u1OvmAWrfPkl/K
         NjofBxG8sf9bY/QSTVBX/7rwD1BY/wLUXwre0jMN4vnQUDzVx2mthO9XUIuFmPXxm1vD
         GTD2JKQJLfgeP8weXELOK+ePmeWJ3GZ9NI+X13kWbnk9rSWoBvAArE+rL5JarO3r3e9I
         JLuwAbImOmfhAUtxm5KFdTyK3PBJ3uyw0RfgVN01Lmp9tKyxK6St0ymRItjd3Bl+uU3P
         Ugiw==
X-Gm-Message-State: AOJu0YzxItpIamP2UI8UOe/Ntq1LdNAE4rovD5F7dBuZKR+b2IaGCIw0
	n6BCR7wa6/gX6MhY2JgB8za9rcsbi/Y/mm5cujibLqC9INDjnBdelqmTVLIv
X-Google-Smtp-Source: AGHT+IFx3kJQdFwTRpy41ZQcJpuFJ570V7nVJqkia/3jhAB8zuFQ5EtUwLX+fTrvMoRoDhAs8geo7A==
X-Received: by 2002:a4a:d089:0:b0:599:f5fb:65d2 with SMTP id i9-20020a4ad089000000b00599f5fb65d2mr4999589oor.5.1706799497266;
        Thu, 01 Feb 2024 06:58:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXv+YMCeOfU0dGw/t33Zih9x6vvOjPTB8mJfq3Ju6I2qGoDgj08jbpUvOOs4Hkjc97dF1xBX5M+pZLoFkHZvd0abtD+90=
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l14-20020a4ae2ce000000b0059a096ee494sm2346629oot.47.2024.02.01.06.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:58:16 -0800 (PST)
Message-ID: <3ccd1cd5-de86-437f-a3fc-942bf04c484a@gmail.com>
Date: Thu, 1 Feb 2024 08:58:15 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udevng: Add support for Quectel EG96 modem
Content-Language: en-US
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
Cc: martin@geanix.com
References: <20240131135728.3100070-1-sean@geanix.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240131135728.3100070-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 1/31/24 07:57, Sean Nyekjaer wrote:
> ---
>   plugins/udevng.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Applied, thanks.

Regards,
-Denis


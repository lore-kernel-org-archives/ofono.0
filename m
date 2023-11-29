Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6E374FA
	for <ofono@lists.linux.dev>; Wed, 29 Nov 2023 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfeCGeSa"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b843b61d8aso3939329b6e.0
        for <ofono@lists.linux.dev>; Wed, 29 Nov 2023 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701271543; x=1701876343; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUEgj9DJRsikYEIb3yHpG2W3Nj2pGgLMahZYeK46cQA=;
        b=jfeCGeSa9Ax4wBJt0IUDDz59NuaDx3hJjwfWJ22Wxwi3WIvC18BgpBV/+yo56SyVxQ
         TIla6unprYZ9ct85LSZLJNjCiiQ+c8H4nN9xEi/qG+UJF6vdiObogPAdNLLgMEURQmbK
         E+MyoxUlIeNA114k9J5wP5avMzSLryWlKdHfDsFI5BhhdlQH7H8oJdWBPeZBIVO0Luhv
         gahlsBHhb+ymie+mbi88RgRXKEeCOmFRN5tSUlqtlOKz2SAr9anZl/E49pM/c0hbl8hr
         bwoUYKOJPocivyGHDBHJ0uUPlWTyDM959bbt9wKALXJL+3IqSna8pSX0xxcm03YlaQff
         b0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271543; x=1701876343;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUEgj9DJRsikYEIb3yHpG2W3Nj2pGgLMahZYeK46cQA=;
        b=fxPLpUMNnHwdOKOT0tNDa7eU/hOQAUc+/QpQ4tlMMWxk6rCyxSASfZelAtL6yKModa
         5oTrjKU2fvQAv3f93TD7c9i2LJnx0M9oWt6qy1axfSDCiOJryShEk5a/Zrw08gkUxi6D
         gLFZrNpBaLgn8of3ETmTRC9J7zhQEU8w8ES0CcEY6ICv+WO5JUIEojUXAJQ9Jy9ltvxe
         yIFS073CgCRWWDjpaoWZKiELH5EyusGsalpgY4n1W8IDT6crfzis4du3LL+YGvv7VOAF
         e61cMNdye0qWZh6u/5kzL6vmfFsT/XTfG051nQ52IcRWFxYzGvSOiAeupYS2sVS86ntJ
         SsNw==
X-Gm-Message-State: AOJu0YxUijIgny3uckurYarSLAUwyn9cfXRZKFRuTbIVqvx7HUp2/Zzz
	02q+s4OSNzfekg4IRobzj1Y=
X-Google-Smtp-Source: AGHT+IG8B4yYMTAd5BdS3y9W09VYSWIHNmRpdOL9q9K8OOfT9dr6w5yDChckD2EpuuqZTZDg76lhag==
X-Received: by 2002:a05:6808:4098:b0:3a7:1962:d7ff with SMTP id db24-20020a056808409800b003a71962d7ffmr17022624oib.57.1701271542910;
        Wed, 29 Nov 2023 07:25:42 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w9-20020a056808140900b003b892a45d32sm414671oiv.4.2023.11.29.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:25:42 -0800 (PST)
Message-ID: <ce48bfb2-3b8d-4e61-bd07-8c066b62368a@gmail.com>
Date: Wed, 29 Nov 2023 09:25:41 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isimodem: radio-settings: fix typo
Content-Language: en-US
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>, ofono@lists.linux.dev
References: <20231129094403.401316-1-absicsz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231129094403.401316-1-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

On 11/29/23 03:43, Sicelo A. Mhlongo wrote:
> Fixes: 469ae3ba ("radio-settings: Port drivers to use
> OFONO_ATOM_DRIVER_BUILTIN")
> ---
>   drivers/isimodem/radio-settings.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Ah nice catch.  Applied, thanks.

Regards,
-Denis

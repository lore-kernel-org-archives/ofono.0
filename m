Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5503A29E
	for <ofono@lists.linux.dev>; Thu, 23 Nov 2023 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ5c7mrZ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f5d34235dbso467325fac.0
        for <ofono@lists.linux.dev>; Thu, 23 Nov 2023 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700753619; x=1701358419; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPDs6nrb1ugN2gmkUs4DNnHsVf4WmDGG7LgSjkTzSlk=;
        b=IZ5c7mrZmCECJxxVAXaO0+t7AQSR0K9zak1Kjk6OobJwy3esqAguCaTEaXZ7PtKUaf
         S1pFsViUUOTtBukE4SZ8Eq2vVGgZghtRx4XB6w68zVmZ8ZAWvFvhLMVVL2PIDvoprLsc
         kQVZzINMA6ej4KCQMZDn2Zb5n4PgxtCL8IxPRoTemU0TD75y7G0LUQtI5s8VqTXayzUS
         9ZM+1LKpt783V1XofEK7UotO1RvbKqjJH34uZc6sYUdJihh0ydpI/Mld4EQcREOsvO8r
         /2ao06+6TfQT1pnphQWtDabyGjXY/VBouMB8gXX1tYf/jlZKDIGOYHwskeDpF5+Yo3qL
         Z7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753619; x=1701358419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPDs6nrb1ugN2gmkUs4DNnHsVf4WmDGG7LgSjkTzSlk=;
        b=sxRcSnRQNYGrXu1zChKCncq4VmTdNbPCybCJeA02yLkRXer2R+uPRw1Z9cZmokwvFc
         vO/84wJidnO3ziTPEU20MjNqIm1ulL+qhIudEWpgSKS9ErUwtD9ocgHM0r9s3zUVtjzl
         p5iNBJP7blG/8geR7zZjkHUXtwJyJn1YI7/67XEcayzV9Ylnu4t3TsOrSPaeDQ+VVa7V
         HT2ldS9O0tDXSmdLiM/E3Y7xU0Kam/dU0R0GHf8JyHR0/y8lj08/atTGTWbQGOlGI+Po
         lohOYSfB0BhKN98g36FAtQEHgoUyNg+rQS0xEFOkB8Mj9SDuUE2k1l9fuz6sry3Wjqy5
         ZSIg==
X-Gm-Message-State: AOJu0Ywvstd9ZNPfc/w5qjuwly4qmw4s6+iOQqfd6p0hvgdUORP1OO6c
	P/DV6rWP8Ibssfq6i9fuTas=
X-Google-Smtp-Source: AGHT+IHe1ZWQcP5H+9Zbc1C3SQ+LWFlwwxA8Ot18hMWtQm0RZ1JKYlFgb2e+d1Pp3RtCBZr0yELexw==
X-Received: by 2002:a05:6870:3c8a:b0:1f5:c70c:aa78 with SMTP id gl10-20020a0568703c8a00b001f5c70caa78mr1585162oab.24.1700753619074;
        Thu, 23 Nov 2023 07:33:39 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w5-20020a9d6745000000b006d653b68fdesm208756otm.55.2023.11.23.07.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:33:38 -0800 (PST)
Message-ID: <20e913ef-c357-4a37-8936-9f5b98862755@gmail.com>
Date: Thu, 23 Nov 2023 09:33:37 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isimodem: parse extra details from REG_STATUS_IND
Content-Language: en-US
To: Sicelo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev
References: <20231118122948.418378-1-absicsz@gmail.com>
 <c5ef782f-69fc-476e-96b7-e1814516d43d@gmail.com>
 <ZV5AERD8NNEXvkKg@tp440p.steeds.sam>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZV5AERD8NNEXvkKg@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

> 
>>> +				g_isi_sb_iter_get_alpha_tag(&iter, &an, len, 6);
>>> +				break;
>>> +			case 3:
>>> +				/* Full name */
>>> +				g_isi_sb_iter_get_alpha_tag(&iter, &fn, len, 6);
>>> +				break;
>>
>> But you don't check the error returns of these two calls
> 
> I left out the checking here because in both cases, we are breaking at
> the next statement, regardless of the success or failure of the calls. I
> will see if I can implement checking.

You break out of the outer switch, but you still don't know whether obtaining 
the alpha tag succeeded or not.  So fn/an (or both) can still be NULL.

> 
>>> +	if (fn[0] != '\0')
>>> +		strncpy(nd->nitz_name, fn, OFONO_MAX_OPERATOR_NAME_LENGTH);
>>> +	else if (an[0] != '\0')
>>> +		strncpy(nd->nitz_name, an, OFONO_MAX_OPERATOR_NAME_LENGTH);
>>
>> So how do you know fn/an aren't NULL?
> 
> Please excuse my confusion here - I thought the `if` conditions do check
> whether an or fn are NULL. I will appreciate assistance or suggestion

No, you're checking that fn/an are not equal to an empty string, not that fn/an 
are NULL.

You want something like:
if (fn && fn[0] != '\0')
	...

> for an alternative way to ensure this, since I definitely do not want to
> copy over garbage into nd->nitz_name at this point in the code.
> 

Same thing for abbrev.  You're checking whether or not abbrev is an empty string 
"", but the whole TLV might be absent and g_isi_sb_iter_get_alpha_tag would 
never be executed.

>> Use g_strlcpy instead of strncpy since it takes care of setting the
>> terminating NULL.
> 
> I will do this in v2. While going through some older commits, I also
> found use of l_strlcpy. Should I prefer g_strlcpy in this instance?

They're equivalent, you can use either.  g_strlcpy is the GLib version. 
l_strlcpy is the ell version.  oFono will slowly be migrating away from GLib to 
use ell.

Since you're already using l_utf8_from_ucs2be inside gisi/*, you might as well 
use the ell version.

Regards,
-Denis

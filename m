Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350281CA94
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731904741; cv=none; b=sPw23HrNiOhHHyBGqAhv1pw9PF/FQL00Nk1TeavBXw8QwHkS4iEkchvxwbX8f9PjtuzKXFsYscgMXxrhUiJrYCwE4kvalq0DbyRfEjFPHsDS41J7ulvePafSG6AMWeRMefZIMCHrgKZMMKzouJTsc6TB401Mj3mKwaWjvdqJexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731904741; c=relaxed/simple;
	bh=4tZgyPmY5l/qb2ie6mw83nO4gWHFWFoboezUPZ+c7JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biPHgJd/nSzxdEkxd/gNnbnaq7KA/B5xOncGvk/jE1Ao0jQ77zwLb2Bsr3jE2IlPKAsukmnLXtzi3/76P9sDRLFJNxOHq/GTdnh7Kt/mVQlAA7ezJkAG8fS94CVD7JH3jKQvu88tplAaZtqdjX7gGC5n8uY9Q8xYZ4yRB/jwFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FopGqXcc; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FopGqXcc"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2965e10da1bso389250fac.0
        for <ofono@lists.linux.dev>; Sun, 17 Nov 2024 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731904739; x=1732509539; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nhRcHxfhd6ZnEXx3NUSG3/hpZ4i19EIpRS/HToKUiE=;
        b=FopGqXccB/0eJjCZhOVLSUXPk9a2fALOc4lhmAzYCnnVDTDowlz3+YILI2XBUUrzun
         9R9vOW3REDcw+V2xbP+6/rDyzFN6revnWn90ZZOsGCTZEyu8UCkp1glpQhkxBAczKjK5
         2e3CKUAkU8qnLOGs2T+e1jWoa9f9VFcLeNRBhThoO5kXlYW4kkH4AC+vHPxkK7LYDEWR
         XWwElnu/dJ1M/pO3g7vIL1YUlviF+9tNoLfwICOXrVHJlPjg9HgplbcQYm5wZ2iY7CTO
         pdFjwyiDE7w2PHK7+XnRmZxAeZ6C1j/ixZRWjff6C9O0xnb2CHiuSBVrzYEywMW57d5F
         tbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731904739; x=1732509539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nhRcHxfhd6ZnEXx3NUSG3/hpZ4i19EIpRS/HToKUiE=;
        b=BpSGjK+rBzBTMsRd3AdN/2hx8L0LhN0UX3GlFt9fUazoQGE5Ddpcbsoeo2NYZ7uWBn
         O4F8Vreo9Z23uNPqSM+uNenFlnDcD08LFiUaMdhn4iS4GWlu4zZV9CnFjkQpDOBFLSw/
         4fdhkkmQYuP/yv2Ya6PAomW477rfky6mzlrEHPXz86/H3i4XSdG5/Ax2/piDnN+I37xo
         RkucW/U10RXBmVTmcYcIrBDKLKiZSLWH9Fa/m6EjsYchCYjUeOOcpQ+HXwF+MgyNrjVC
         CV39vJ2LybaJTl6hx6lJWJvKSUNcT6Tvcq9xf09nZ9i8qBuisMJRaz/1lbFYX/gLZ7NM
         fWqA==
X-Gm-Message-State: AOJu0YwHNZNDyDKoUOUocaQt5h9rBwFIiXWNPeFMULnd7oUnkI7n8+aH
	gTE3kxCrxmnkCc/uo58+Fiiu9aNjZyi3LIBA6DKw7o71Cu9ptPZVT0M+mw==
X-Google-Smtp-Source: AGHT+IEHyX+dfTjr5bfTUNzNXz7r4OZmNUqV77pEu4qQqSiGiM1qNIhe5dTAFpJ/PP2xkMEniPdCtg==
X-Received: by 2002:a05:6871:740d:b0:270:64ed:c125 with SMTP id 586e51a60fabf-2962dd2a926mr8546921fac.16.1731904739019;
        Sun, 17 Nov 2024 20:38:59 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-29651945ee6sm2287463fac.29.2024.11.17.20.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 20:38:58 -0800 (PST)
Message-ID: <d6f68a2e-a524-46d9-ab98-0a5ef66f0186@gmail.com>
Date: Sun, 17 Nov 2024 22:38:57 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] rmnet: Add skeleton
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ofono@lists.linux.dev
References: <20241115220053.49613-1-denkenz@gmail.com>
 <65EE9630-2CA2-43D9-AD37-316BF08A725E@holtmann.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <65EE9630-2CA2-43D9-AD37-316BF08A725E@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

 >
> does this make really sense? Putting this into drivers/qmimodem/rmnet.c is not possible?
> 

I switched most of the atom drivers to use the OFONO_ATOM_DRIVER_BUILTIN macro. 
The drivers that performed static initialization during 'plugin_init' using 
OFONO_PLUGIN_DEFINE went *poof*, including qmimodem.  Only individual atom 
drivers remain.  There is one straggler, namely drivers/stemodem/stemodem.c. 
That one does something somewhat similar in drivers/stemodem/caif_rtnl.c.

Similarly, for modem drivers, OFONO_MODEM_DRIVER_BUILTIN was introduced.  This 
leaves only a few users of OFONO_PLUGIN_DEFINE.  Longer term I'd like to get rid 
of the whole plugin concept.  However, it still leaves the open question of what 
to do with code that requires plugin_init / plugin_exit style static 
initialization.  Easiest way is to convert such users to core modules, like I do 
with rmnet here, but I'm open to suggestions.

> We might actually need a generic abstraction for del_interface / add_interface and allow for drivers to register their implementation for it, but that is a different story.

Yes, true.  This will surely come up with MBIM.

On another note, I was thinking of eventually moving transport implementations 
into src/ or transport/ to allow easier mixing, e.g. running QMI over MBIM, or 
AT commands over QMI, etc.

Regards,
-Denis

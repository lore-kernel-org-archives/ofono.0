Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FB158DD3
	for <ofono@lists.linux.dev>; Fri, 31 May 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170748; cv=none; b=MgFs9lUkmWWDntbzypMPnqZUMv7hAfK4ZBuQDFaqYZn/Wb2Hh1TN9YafctMQL62CVwE97CV+YcGMmDfRh5z7KgVXuP655HIFzzi5N0UbEkCA+33jZPjyfTJ2SnWe27xYYvaBmpOUXNL2bzIonKpm45W6SP/NoHu6n+PWORqXEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170748; c=relaxed/simple;
	bh=lQEAPZGro7WQxpc+Ab2KuDq9sl/FAXJPBGSELB/hUhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxfZel05YMBrSiUTgzSyK9tBL4RSDNPpouwb+Pv4MkG+5xfOCBhGDEUULxp9conxLk/1V3FnuZkPwbWKrYp9KnccSoMrH8BHb67mNwmpI+Gxl7HoSLqVG+RFhJZN6wf/aOfFsnsxBGyQsbw2n0cDBwzVzQZnwoI7fZoiJcXkER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEVf33pw; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEVf33pw"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2508934c50aso413121fac.3
        for <ofono@lists.linux.dev>; Fri, 31 May 2024 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717170745; x=1717775545; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62m+dae7bo6jhFvCmxSMf4kytcEtRV5MgyT0PewiNxk=;
        b=kEVf33pwqWEqypFO8U1WbgWwX5lIVUxTQ1xol+GkPPGFyKiL73XJgiX3GTlSr3MHFM
         Fmye6wNfhpvpnEVaWWjLgkcK/Nd6lrqLBAz6Z0HvKdyWMWWIDaoX2BNquteHhssRLynD
         jv9dYisMhXwmpm6DJBmdn6HAse8YR9Uu7C3pvwwF9BfstoeFktbvkKiuk/tO0PN/FbuR
         yq8EntXMoiRPSxSQubg2/uB8Sachq+IvpBkPB3fhfzYdMODUkknDjLhnDojCDDJGZJ77
         KVg5sHEkgrXpDujQTrApCRn5v74HypxEgxZy6JovKCCTeOzdVy9KwhZsIh41jsbgeuCz
         WmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170745; x=1717775545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62m+dae7bo6jhFvCmxSMf4kytcEtRV5MgyT0PewiNxk=;
        b=XudAZylVHKxIwRoOX9QUbMyz7UBZ9NvSDg4uU0nT0IT0cpi9XxRCjrNRqxYGMU6zMf
         2q1nXvI2JlMuauzb/9PMIVYezgOzWQomc3LG9sPX11jSIjOX2hg1mZdu4JUEmHXn86n6
         2YKIs3UxWQVQWbbu8q8jLeTRDiruVL/DLWEJ9cIDlPU3vGfEi77Vx5WTc1HInt5OmqMi
         YQmDlTK8w1nj4vVyn8CGnYPhVETjBkjUx1fTL8UgnV0gAeymayVlSODdSCmrUPpDUTyj
         WrpQNVCzXe5xtAdq5tc0CDungGxpUiIah7I5Er1FAf3NnFllG2XlAZBln7Gt16MKZAWi
         L0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlo6aE00oYwchCUUGoEu/GtvYNvXCliMcRNALZ67XZNyx5TgjrPw3NRQuIjAXDIQERANe9CqbdwBjXib/jgnk0DFEgbDo=
X-Gm-Message-State: AOJu0YwsdWAx+Pc/hhkE0p31TpppG5KRXpulRa4OCvDVN6w7kDPLRP5X
	Ifg2s8lEgq6t5nbwyYLKMLN8vl6s/GiQkuzwx2zq+h8Jln514jXPkWSevg==
X-Google-Smtp-Source: AGHT+IE2bk9xdbWXaDZAq2avfkRoght7Q7Srr4TEhKVaYiJaaBDtHNKRZQGCGGooZ0F5NulmoeAv9w==
X-Received: by 2002:a05:6870:f721:b0:24c:6184:1152 with SMTP id 586e51a60fabf-2508bc6b35amr2564928fac.56.1717170744648;
        Fri, 31 May 2024 08:52:24 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-6f91059d110sm367833a34.61.2024.05.31.08.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 08:52:24 -0700 (PDT)
Message-ID: <24df8380-b6fe-4f86-bb20-49815ef58c1f@gmail.com>
Date: Fri, 31 May 2024 10:52:23 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] udevng: Fix detection of USB attached tty devices
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
References: <20240530152513.279243-1-denkenz@gmail.com>
 <20240530152513.279243-2-denkenz@gmail.com>
 <b0e4aed1-302a-0d4f-b466-7fd7b999275a@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <b0e4aed1-302a-0d4f-b466-7fd7b999275a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ivo,

>> -
>> +    /* Handle USB-connected devices in check_usb_device */
>> +    if (l_streq0(bus, "usb")) {
>> +        check_usb_device(device);
>>           return;
>>       }
>> -    if (l_streq0(subsystem, "usb") || l_streq0(subsystem, "usbmisc"))
> 
> Is it possible (in theory) that we have 'usb' subsystem device that is not on 
> USB bus? If yes, then you shouldn't drop l_streq0(subsystem, "usb") check.

I hope not.  What i've seen is subsystem 'usbmisc' devices not setting ID_BUS to 
'usb', which is a bit weird.  Hence the 'usbmisc' check below.

I think we do not care about usb subsystem devices, only the leafs:
	- usbmisc (cdc-acm)
	- tty (ttyUSB...)
	- net

Regards,
-Denis

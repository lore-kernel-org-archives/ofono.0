Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD463D966
	for <ofono@lists.linux.dev>; Wed, 17 Apr 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387263; cv=none; b=CAWCq1mAZJACLLTvbTxyIa86I1pLRaEkHxoal1sK7TjwL1KFPw0uk1So1yeHWsFI5uHBiQq+BYCGZGQK/p2rL8wuR7MMdClfKNON8jCrqiqn51dbJ+xKvTgJe7Js9BhtAC8dxVT156IBXWPNsso/z87yJrBngB81wFLOOrKJVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387263; c=relaxed/simple;
	bh=1bQJVjGGOfmvKPGafA1v5SfRKzsT/3EOTdFW+paMCaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yz80+D7hVhBVSzUlkb262vz3VzHyMj9eyX6L5eIe1akFRCEzZqw8c8M2amtzXMJFyA+FvTpNYw1I8COWnXzVMy1n0/BBu0ysVQPlFkdPEi0DhvKzwHR93gqQjqZjRDwzFv8cODsrWZH6UfhjYDyFJlbn1XWAa6WlgXG6so25pHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUshDfqf; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUshDfqf"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea26393116so74167a34.0
        for <ofono@lists.linux.dev>; Wed, 17 Apr 2024 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387261; x=1713992061; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzCwhqaVsy7kJRCCIqxOOqg83udkI6EyOUMvgvM348k=;
        b=EUshDfqfI8LV/YUOt+mefV0elMm12MdV3AxBTFbz0E1zA02yKRCIHoLQIH+0+ETCvu
         23379QvWeIKZr0dH6CK9QPeRu8pU3Phx/nXSqiPSTL6tz8qsjlEjqIwUOUqjIQxsOYJ1
         kt8gqZlM/nYk62yiaqeeLWr5veRSxgeif9JjIQQtKkUb9dUY6CO/WKVAeMal1DX9Sv6z
         4DkTunh58SYoCyq+PudCFuu9SN0BMZUrBRoAJEDziRg/PL5kxITOYcBE3IrBZrIb+LhT
         lVJPDCicYcQyMc3R2ssP/DrZTPNp/uPwMZtdVM7aRrt2HQ4El1IvvkmqIkL5vn2g1TCd
         yChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387261; x=1713992061;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzCwhqaVsy7kJRCCIqxOOqg83udkI6EyOUMvgvM348k=;
        b=YVzqO/Z8mp3I5E9Ca6Ct2oBeoRooiIUB36XjLuVoVVCGqck7pQu/UqoIMN0qBkleih
         ExGt5v2K693CIciVxcZko1sRacivHMV8N+h3Z/oMrJuankz9kqr8yrACkE2cfGmS3D/h
         5vOHX9G+gJ3H/NBU5qovXlg6FQz63xTDdOPbB5MSZdzH/Uak1NsayuxR9gVKGzHBwctO
         BOC1KbEXIWpfUtOIT6J1OSLQFnoDJSbDUi8wdQdgv6EY/nWqn4lHavse3GJfWn0d++CY
         JXeeEyJqIE6MIszR+QZ1jeLNtuKbDPJr2sE2Yeid3/WuOVcEQGG+kYikq5FcFrTd/JMw
         BNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YHnAQGhwwDe9BybMBBwxw1G2vZx3OWiqLFCPok75i/O50mjLxIW55x/n3E6ZGX0AoQszeVDJnUzyak7L1IIQdUh6LPQ=
X-Gm-Message-State: AOJu0YxJD9Pn2fyBPmJl9S96YvdCyvAUu402l8kxEQzwor9qQXcf8L+/
	EnEcdzHlNxRVe/KnxWj9cu+G9nu0+8LU6LBvfbp+BbT6ossQvA6PDbS4Kw==
X-Google-Smtp-Source: AGHT+IGplePdhWNh8kbbdpNVYwJNr5pjpfoLFYiC6pdUgKLI9gILxkdKykFA2ujiUbZ0OsrfJK8/Vw==
X-Received: by 2002:a05:6830:441e:b0:6ea:1001:f077 with SMTP id q30-20020a056830441e00b006ea1001f077mr812202otv.9.1713387261321;
        Wed, 17 Apr 2024 13:54:21 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k20-20020a056830151400b006eb8150f668sm37941otp.74.2024.04.17.13.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 13:54:21 -0700 (PDT)
Message-ID: <c450908a-d42f-4d09-b90f-26cba9dfd495@gmail.com>
Date: Wed, 17 Apr 2024 15:54:20 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] qmimodem: voicecall: Implement call dialing
Content-Language: en-US
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
 <2693964.vuYhMxLoTh@adam-laptop-hp>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2693964.vuYhMxLoTh@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

>>> +		number_size = remote_party->number_size + 1;
>>
>> Why +1?  We can't copy more than remote_party->number_size bytes from
>> remote_party->number, otherwise we read out of bounds ?
> In my testing I found that the last digit of the number was being missed.
> This fixed it, though I suspected it may come back to haunt me!  Any
> suggestions?

l_strlcpy takes 3 parameters:
destination
source
size of the destination in bytes

So strictly speaking, l_strlcpy should be invoked as:
l_strlcpy(call->phone_number.number,
		remote_party->number,
		sizeof(call->phone_number.number));

l_strlcpy ensures that if strlen(src) is bigger than the destination buffer, the 
result is truncated, but the destination buffer is still '\0' terminated.

But here's the problem, in QMI, strings are not NULL terminated, so you're just 
getting lucky that remote_party->number has a '\0' somewhere at the end.  What 
you need to do is copy at most remote_party->size bytes into a buffer of 
sizeof(call->phone_number.number) and make sure the buffer is still '\0' terminated.

You can do this using MAX(), memcpy and memset, or the far easier to understand:

char *tmp = l_strndup(remove_party->number, remote_party->size);

l_strlcpy(call->phone_number.number, tmp, sizeof(call->phone_number.number));
l_free(tmp);

Regards,
-Denis

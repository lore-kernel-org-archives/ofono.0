Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF897CF3D
	for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115132; cv=none; b=TAkIBgMo8wxT/y3VDbSrhFUp//ve+jT2xYayNDmTZLr4laoyd5WBex465o4SQxbwxXRryVK2oBJ2oRuJI/AbrC7Jow1j8x206VZsQ0dEFg9AE757lHOOjF0dkc8Oc6QAv5gKCIZw9+CL51swAaXYGDzwQLzXCYhCe30h3qK4xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115132; c=relaxed/simple;
	bh=5Th2NTDQVuKFdwGEYm8XsAwTOCg14T6oXtum/FapnPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yoq/7g7SdLmSC5yW+A/cAjv54Zv//5msjARyss2ML7TVcUeRQWbjZFzwR+CZyVI29uCdKKUXSGQDrHhu5zxbuoTAXAj1JjgrrDJDuUqkl/nrM3zktDLfPjDqLyIWvxxrlpS8707we5Xjv0jrfiLxeDLTQX3kj5O0VoYiCU+FJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa0XrHGw; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa0XrHGw"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5993047a708so2919024eaf.3
        for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706115129; x=1706719929; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh9crdsw4i3q42Vp6+U+a9sPyc6asN3TDegNQd9iU8=;
        b=Sa0XrHGwynSq6pU0WKL1PqMtLSTEdKT98zB0k2gt/LuQaVe9f2CfZeGnMPF2UiI8NI
         2/NjQ2Y9f8ksUxosudkIuQzH3h94xLcQqw68r1t3j6QsoOYdotJRnVrPRf2mvKAbwcOl
         a/R+yuHhi4u0RRLScwhzwq1RJv5OBMBWwkv3lRcEu2zZF0vUp91nWvuutnnFRog+3IJ/
         TL4XXvGgl18L8KkqC6qdUJdDZRpZnaHoHV+Cr6zb/l1FTSVv84Jvkt5tFO2MkIHLPGog
         QkPVIYpYHnE0M6CHlQbypCKG6Vg0FCeOnYP9//D1G6NzG3FbVomGJUdusWHv319ybg6w
         UD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115129; x=1706719929;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh9crdsw4i3q42Vp6+U+a9sPyc6asN3TDegNQd9iU8=;
        b=cc3yuPxUqxpKAE447G89fiM2Y/DLWYOpzmtkrL677C3A8Gu3kqjt/vRStgtLneAx3d
         1gRt/3ntDv8r21KHJLHjEX7/xWxBZyhHq6TBkmiq7b/OTaj3gGP8XI9fi/tcjIZSOxN9
         5qovk4SX5vSTljEEu6cZh9pq01LU+on+/IHPuIiOx2QEEQyD5PXhp5yox6K1bzlMffgS
         JggOfvX8KELMSv6C8mXbFT/n4/uWqDQMM7X3gx43LDVq2LtG0t8vUUm8kup3Dg587ukr
         /Y/T7D4OpsitmCfDHU554uU1Vj1YOefvseuC8GN4IKTrGuBaH2sDHZ5JFT8lFA7JnGsW
         vxmQ==
X-Gm-Message-State: AOJu0YxWtA0+9g2SnL4MqLQQCCZnCivYcRbtsFsqR14r82s0yMupyatE
	LgmQnO5eV1Ro6CQdcWdeU1KecDQ4SgsZGSplQS0mIKDXetqYci48rTU1kLGs
X-Google-Smtp-Source: AGHT+IFsnq3pVINq1BYIrFwr7U8KBpyYJeISj+/5x/sAQYlwTrn5FlQn+Jd0xSDY/EMDjriLq8VQzA==
X-Received: by 2002:a4a:cf12:0:b0:599:93cc:afd2 with SMTP id l18-20020a4acf12000000b0059993ccafd2mr1449367oos.10.1706115129729;
        Wed, 24 Jan 2024 08:52:09 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h29-20020a4ae8dd000000b00595b35927a3sm29899ooe.39.2024.01.24.08.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:52:09 -0800 (PST)
Message-ID: <443333a7-7e43-48c8-8a63-fd4ab0365b36@gmail.com>
Date: Wed, 24 Jan 2024 10:52:07 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gatchat: fix g_at_chat_unref in notify handler
Content-Language: en-US
To: Maxim Lyubimov <m.lyubimov@aqsi.ru>, ofono@lists.linux.dev
References: <20240123150035.1477546-1-m.lyubimov@aqsi.ru>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240123150035.1477546-1-m.lyubimov@aqsi.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maxim,

On 1/23/24 09:00, Maxim Lyubimov wrote:
> If the new_bytes handler processes a modem shutdown URC, it results in
> a call to the g_at_chat_unref function, which includes a call to the
> chat_cleanup function, which clears the list of URC handlers that
> continue to be traversed after the current handler has completed, and
> may lead to errors. To correct the situation, the chat_cleanup function
> is not called in the at_chat_unref function if the in_read_handler flag
> is set. In the new_bytes function, if the destroyed flag is set, the
> chat_cleanup function is called before calling g_free. Additional
> checks have been added to the chat_cleanup function.
> ---
>   gatchat/gatchat.c | 102 +++++++++++++++++++++++++++-------------------
>   1 file changed, 60 insertions(+), 42 deletions(-)
> 

Looks good.  There's no need to move some of these functions around now though. 
I sent a (much smaller) v3 of this patch so it goes through CI.  Please take a 
look as well.

Regards,
-Denis

